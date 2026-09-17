import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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

  RagResponse({
    required this.answer,
    required this.sources,
    required this.grounded,
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
    );
  }
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

  Future<RagResponse> askQuestion(String question) async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken(false);

      final response = await _dio.post(
        '/rag/ask',
        data: {'question': question},
        options: Options(
          headers: {
            if (token != null && token.isNotEmpty)
              'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data;
        if (response.data is Map<String, dynamic>) {
          data = response.data as Map<String, dynamic>;
        } else if (response.data is String) {
          data = jsonDecode(response.data as String) as Map<String, dynamic>;
        } else {
          throw RagApiException('Unexpected response format from server.');
        }

        return RagResponse.fromJson(data);
      }

      throw RagApiException(
        'Server returned HTTP status ${response.statusCode}',
        statusCode: response.statusCode,
      );
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
