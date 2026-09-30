import 'package:flutter/foundation.dart';

/// A saved AI chat, as listed in chat history.
@immutable
class ChatConversationSummary {
  final String id;
  final String title;
  final DateTime lastMessageAt;
  final String preview;

  const ChatConversationSummary({
    required this.id,
    required this.title,
    required this.lastMessageAt,
    this.preview = '',
  });

  factory ChatConversationSummary.fromJson(Map<String, dynamic> json) {
    return ChatConversationSummary(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Conversation',
      lastMessageAt: DateTime.tryParse(json['lastMessageAt']?.toString() ?? '')?.toLocal() ?? DateTime.now(),
      preview: json['preview']?.toString() ?? '',
    );
  }

  ChatConversationSummary copyWith({String? title, DateTime? lastMessageAt, String? preview}) {
    return ChatConversationSummary(
      id: id,
      title: title ?? this.title,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      preview: preview ?? this.preview,
    );
  }
}
