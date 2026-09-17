import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_message_model.dart';
import '../services/rag_api_service.dart';

final ragApiServiceProvider = Provider<RagApiService>((ref) {
  return RagApiService();
});

class RagChatState {
  final List<ChatMessageModel> messages;
  final bool isGenerating;

  const RagChatState({
    this.messages = const [],
    this.isGenerating = false,
  });

  RagChatState copyWith({
    List<ChatMessageModel>? messages,
    bool? isGenerating,
  }) {
    return RagChatState(
      messages: messages ?? this.messages,
      isGenerating: isGenerating ?? this.isGenerating,
    );
  }
}

class RagChatNotifier extends StateNotifier<RagChatState> {
  final RagApiService _apiService;
  static const _uuid = Uuid();

  RagChatNotifier(this._apiService) : super(const RagChatState());

  Future<void> sendMessage(String question) async {
    final trimmed = question.trim();
    if (trimmed.isEmpty || state.isGenerating) return;

    final userMsgId = _uuid.v4();
    final aiMsgId = _uuid.v4();
    final now = DateTime.now();

    final userMessage = ChatMessageModel(
      id: userMsgId,
      text: trimmed,
      sender: MessageSender.user,
      timestamp: now,
    );

    final aiLoadingMessage = ChatMessageModel(
      id: aiMsgId,
      text: '',
      sender: MessageSender.ai,
      timestamp: now,
      isLoading: true,
    );

    state = state.copyWith(
      messages: [...state.messages, userMessage, aiLoadingMessage],
      isGenerating: true,
    );

    await _fetchAiResponse(trimmed, aiMsgId);
  }

  Future<void> retryMessage(String aiMessageId) async {
    if (state.isGenerating) return;

    final aiIndex = state.messages.indexWhere((m) => m.id == aiMessageId);
    if (aiIndex <= 0) return;

    final prevMessage = state.messages[aiIndex - 1];
    if (!prevMessage.isUser) return;

    final updatedList = List<ChatMessageModel>.from(state.messages);
    updatedList[aiIndex] = updatedList[aiIndex].copyWith(
      isLoading: true,
      isError: false,
      text: '',
    );

    state = state.copyWith(
      messages: updatedList,
      isGenerating: true,
    );

    await _fetchAiResponse(prevMessage.text, aiMessageId);
  }

  Future<void> _fetchAiResponse(String question, String aiMsgId) async {
    try {
      final response = await _apiService.askQuestion(question);

      final updatedList = state.messages.map((msg) {
        if (msg.id == aiMsgId) {
          return msg.copyWith(
            text: response.answer,
            sources: response.sources,
            isGrounded: response.grounded,
            isLoading: false,
            isError: false,
          );
        }
        return msg;
      }).toList();

      state = state.copyWith(
        messages: updatedList,
        isGenerating: false,
      );
    } catch (e) {
      final errorMessage = e is RagApiException
          ? e.message
          : 'Failed to connect to Spendly AI. Please try again.';

      final updatedList = state.messages.map((msg) {
        if (msg.id == aiMsgId) {
          return msg.copyWith(
            text: errorMessage,
            isLoading: false,
            isError: true,
          );
        }
        return msg;
      }).toList();

      state = state.copyWith(
        messages: updatedList,
        isGenerating: false,
      );
    }
  }

  void clearChat() {
    state = const RagChatState();
  }
}

final ragChatNotifierProvider =
    StateNotifierProvider<RagChatNotifier, RagChatState>((ref) {
  final apiService = ref.watch(ragApiServiceProvider);
  return RagChatNotifier(apiService);
});
