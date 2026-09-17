import 'package:flutter/foundation.dart';

enum MessageSender {
  user,
  ai,
}

class RagSource {
  final String docId;
  final String title;
  final String category;
  final double score;

  const RagSource({
    required this.docId,
    required this.title,
    required this.category,
    required this.score,
  });

  factory RagSource.fromJson(Map<String, dynamic> json) {
    return RagSource(
      docId: json['docId']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Document',
      category: json['category']?.toString() ?? 'general',
      score: (json['score'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'docId': docId,
      'title': title,
      'category': category,
      'score': score,
    };
  }

  String get scorePercentage {
    final pct = (score * 100).clamp(0, 100).round();
    return '$pct% match';
  }
}

@immutable
class ChatMessageModel {
  final String id;
  final String text;
  final MessageSender sender;
  final DateTime timestamp;
  final List<RagSource>? sources;
  final bool isGrounded;
  final bool isError;
  final bool isLoading;

  const ChatMessageModel({
    required this.id,
    required this.text,
    required this.sender,
    required this.timestamp,
    this.sources,
    this.isGrounded = false,
    this.isError = false,
    this.isLoading = false,
  });

  bool get isUser => sender == MessageSender.user;
  bool get isAi => sender == MessageSender.ai;

  ChatMessageModel copyWith({
    String? id,
    String? text,
    MessageSender? sender,
    DateTime? timestamp,
    List<RagSource>? sources,
    bool? isGrounded,
    bool? isError,
    bool? isLoading,
  }) {
    return ChatMessageModel(
      id: id ?? this.id,
      text: text ?? this.text,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
      sources: sources ?? this.sources,
      isGrounded: isGrounded ?? this.isGrounded,
      isError: isError ?? this.isError,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
