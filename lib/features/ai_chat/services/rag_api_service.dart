import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../models/chat_conversation_model.dart';
import '../models/chat_message_model.dart';

class RagApiException implements Exception {
  final String message;
  final int? statusCode;

  RagApiException(this.message, {this.statusCode});

  @override
  String toString() => 'RagApiException: $message (status: $statusCode)';
}

class RagResponse {
  final String answer;
  final List<RagSource> sources;
  final bool grounded;

  /// Set when the server saved this exchange to chat history.
  final String? conversationId;
  final String? conversationTitle;
  final String? messageId;

  RagResponse({
    required this.answer,
    required this.sources,
    required this.grounded,
    this.conversationId,
    this.conversationTitle,
    this.messageId,
  });

  factory RagResponse.fromJson(Map<String, dynamic> json) {
    final rawSources = json['sources'];
    final sourcesList = <RagSource>[];
    if (rawSources is List) {
      for (final item in rawSources) {
        if (item is Map<String, dynamic>) {
          sourcesList.add(RagSource.fromJson(item));
        }
      }
    }

    return RagResponse(
      answer: json['answer']?.toString() ?? 'No response answer provided.',
      sources: sourcesList,
      grounded: json['grounded'] as bool? ?? false,
      conversationId: json['conversationId'] as String?,
      conversationTitle: json['conversationTitle'] as String?,
      messageId: json['messageId'] as String?,
    );
  }
}

class ConversationPage {
  final List<ChatConversationSummary> items;
  final String? nextCursor;

  ConversationPage(this.items, this.nextCursor);
}

class RagApiService {
  final Dio _dio;
  final String baseUrl;

  RagApiService({
    Dio? dio,
    this.baseUrl = 'https://fiscora-api.duckdns.org',
  }) : _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: baseUrl,
                connectTimeout: const Duration(seconds: 45),
                receiveTimeout: const Duration(seconds: 45),
                contentType: Headers.jsonContentType,
              ),
            );

  Future<Options> _authOptions() async {
    final token = await FirebaseAuth.instance.currentUser?.getIdToken(false);
    return Options(
      headers: {
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
  }

  Map<String, dynamic> _asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is String) return jsonDecode(data) as Map<String, dynamic>;
    throw RagApiException('Unexpected response format from server.');
  }

  /// Asks a question. Pass [conversationId] to continue a saved conversation
  /// (the server then includes its recent messages as context).
  Future<RagResponse> askQuestion(String question, {String? conversationId}) {
    return _guard(() async {
      final response = await _dio.post(
        '/rag/ask',
        data: {
          'question': question,
          if (conversationId != null) 'conversationId': conversationId,
        },
        options: await _authOptions(),
      );
      return RagResponse.fromJson(_asMap(response.data));
    });
  }

  Future<ConversationPage> listConversations({String? cursor}) {
    return _guard(() async {
      final response = await _dio.get(
        '/rag/conversations',
        queryParameters: {if (cursor != null) 'cursor': cursor},
        options: await _authOptions(),
      );
      final data = _asMap(response.data);
      final items = (data['items'] as List? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(ChatConversationSummary.fromJson)
          .toList();
      return ConversationPage(items, data['nextCursor'] as String?);
    });
  }

  Future<({String title, List<ChatMessageModel> messages})> getMessages(String conversationId) {
    return _guard(() async {
      final response = await _dio.get(
        '/rag/conversations/$conversationId/messages',
        options: await _authOptions(),
      );
      final data = _asMap(response.data);
      final messages = (data['messages'] as List? ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(ChatMessageModel.fromServerJson)
          .toList();
      return (title: data['title']?.toString() ?? 'Conversation', messages: messages);
    });
  }

  Future<void> renameConversation(String conversationId, String title) {
    return _guard(() async {
      await _dio.patch(
        '/rag/conversations/$conversationId',
        data: {'title': title},
        options: await _authOptions(),
      );
    });
  }

  Future<void> deleteConversation(String conversationId) {
    return _guard(() async {
      await _dio.delete('/rag/conversations/$conversationId', options: await _authOptions());
    });
  }

  /// Maps transport errors to user-friendly [RagApiException]s.
  Future<T> _guard<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      if (kDebugMode) {
        print('RagApiService DioError: ${e.message} | Response: ${e.response?.data}');
      }
      final statusCode = e.response?.statusCode;
      String userFriendlyMessage = 'Unable to connect to Spendly AI service.';
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        userFriendlyMessage = 'Request timed out. Please check your internet connection.';
      } else if (statusCode == 401 || statusCode == 403) {
        userFriendlyMessage = 'Authentication token expired. Please re-login.';
      } else if (statusCode == 404) {
        userFriendlyMessage = 'This conversation no longer exists.';
      } else if (statusCode != null && statusCode >= 500) {
        userFriendlyMessage = 'Spendly AI server is currently undergoing maintenance.';
      } else if (e.response?.data is Map &&
          (e.response!.data as Map).containsKey('message')) {
        userFriendlyMessage = (e.response!.data as Map)['message'].toString();
      }

      throw RagApiException(userFriendlyMessage, statusCode: statusCode);
    } catch (e) {
      if (e is RagApiException) rethrow;
      throw RagApiException('An unexpected error occurred: ${e.toString()}');
    }
  }
}
