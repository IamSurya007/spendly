import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/chat_conversation_model.dart';
import '../models/chat_message_model.dart';
import '../services/rag_api_service.dart';

final ragApiServiceProvider = Provider<RagApiService>((ref) {
  return RagApiService();
});

class RagChatState {
  final List<ChatMessageModel> messages;
  final bool isGenerating;

  /// Saved conversation this chat belongs to; null until the first answer
  /// is saved by the server.
  final String? conversationId;
  final String? title;
  final bool isLoadingConversation;
  final String? loadError;

  const RagChatState({
    this.messages = const [],
    this.isGenerating = false,
    this.conversationId,
    this.title,
    this.isLoadingConversation = false,
    this.loadError,
  });

  RagChatState copyWith({
    List<ChatMessageModel>? messages,
    bool? isGenerating,
    String? conversationId,
    String? title,
    bool? isLoadingConversation,
    String? loadError,
    bool clearLoadError = false,
  }) {
    return RagChatState(
      messages: messages ?? this.messages,
      isGenerating: isGenerating ?? this.isGenerating,
      conversationId: conversationId ?? this.conversationId,
      title: title ?? this.title,
      isLoadingConversation: isLoadingConversation ?? this.isLoadingConversation,
      loadError: clearLoadError ? null : (loadError ?? this.loadError),
    );
  }
}

class RagChatNotifier extends StateNotifier<RagChatState> {
  final RagApiService _apiService;
  final Ref _ref;
  static const _uuid = Uuid();

  RagChatNotifier(this._apiService, this._ref) : super(const RagChatState());

  Future<void> sendMessage(String question) async {
    final trimmed = question.trim();
    if (trimmed.isEmpty || state.isGenerating || state.isLoadingConversation) return;

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
      final response = await _apiService.askQuestion(
        question,
        conversationId: state.conversationId,
      );

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
        conversationId: response.conversationId,
        title: response.conversationTitle,
      );

      final id = response.conversationId;
      if (id != null) {
        _ref.read(chatHistoryProvider.notifier).touch(
              ChatConversationSummary(
                id: id,
                title: response.conversationTitle ?? state.title ?? question,
                lastMessageAt: DateTime.now(),
                preview: response.answer,
              ),
            );
      }
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

  /// Starts a fresh conversation. The previous one stays in history.
  void newChat() {
    state = const RagChatState();
  }

  /// Opens a saved conversation from history.
  Future<void> loadConversation(String conversationId, {String? title}) async {
    if (state.isGenerating) return;
    state = RagChatState(
      conversationId: conversationId,
      title: title,
      isLoadingConversation: true,
    );
    try {
      final result = await _apiService.getMessages(conversationId);
      if (state.conversationId != conversationId) return; // user moved on
      state = state.copyWith(
        messages: result.messages,
        title: result.title,
        isLoadingConversation: false,
        clearLoadError: true,
      );
    } catch (e) {
      if (state.conversationId != conversationId) return;
      state = state.copyWith(
        isLoadingConversation: false,
        loadError: e is RagApiException ? e.message : 'Could not load this conversation.',
      );
    }
  }

  /// Called when the open conversation was deleted from history.
  void onConversationDeleted(String conversationId) {
    if (state.conversationId == conversationId) newChat();
  }

  void onConversationRenamed(String conversationId, String title) {
    if (state.conversationId == conversationId) {
      state = state.copyWith(title: title);
    }
  }
}

final ragChatNotifierProvider =
    StateNotifierProvider<RagChatNotifier, RagChatState>((ref) {
  final apiService = ref.watch(ragApiServiceProvider);
  return RagChatNotifier(apiService, ref);
});

// ── Chat history ───────────────────────────────────────────────────────────

class ChatHistoryState {
  final List<ChatConversationSummary> items;
  final bool isLoading;
  final bool isLoadingMore;
  final String? nextCursor;
  final String? error;

  const ChatHistoryState({
    this.items = const [],
    this.isLoading = false,
    this.isLoadingMore = false,
    this.nextCursor,
    this.error,
  });

  bool get hasMore => nextCursor != null;
}

class ChatHistoryNotifier extends StateNotifier<ChatHistoryState> {
  final RagApiService _api;
  final Ref _ref;

  ChatHistoryNotifier(this._api, this._ref) : super(const ChatHistoryState());

  Future<void> refresh() async {
    state = ChatHistoryState(items: state.items, isLoading: true);
    try {
      final page = await _api.listConversations();
      state = ChatHistoryState(items: page.items, nextCursor: page.nextCursor);
    } catch (e) {
      state = ChatHistoryState(
        items: state.items,
        error: e is RagApiException ? e.message : 'Could not load chat history.',
      );
    }
  }

  Future<void> loadMore() async {
    final cursor = state.nextCursor;
    if (cursor == null || state.isLoadingMore) return;
    state = ChatHistoryState(items: state.items, nextCursor: cursor, isLoadingMore: true);
    try {
      final page = await _api.listConversations(cursor: cursor);
      state = ChatHistoryState(items: [...state.items, ...page.items], nextCursor: page.nextCursor);
    } catch (_) {
      state = ChatHistoryState(items: state.items, nextCursor: cursor);
    }
  }

  /// Moves [conversation] to the top (new message) without a network round-trip.
  void touch(ChatConversationSummary conversation) {
    state = ChatHistoryState(
      items: [conversation, ...state.items.where((c) => c.id != conversation.id)],
      nextCursor: state.nextCursor,
    );
  }

  Future<void> delete(String id) async {
    final before = state.items;
    state = ChatHistoryState(
      items: before.where((c) => c.id != id).toList(),
      nextCursor: state.nextCursor,
    );
    try {
      await _api.deleteConversation(id);
      _ref.read(ragChatNotifierProvider.notifier).onConversationDeleted(id);
    } catch (e) {
      state = ChatHistoryState(
        items: before,
        nextCursor: state.nextCursor,
        error: e is RagApiException ? e.message : 'Could not delete the conversation.',
      );
    }
  }

  Future<void> rename(String id, String title) async {
    final trimmed = title.trim();
    if (trimmed.isEmpty) return;
    final before = state.items;
    state = ChatHistoryState(
      items: before.map((c) => c.id == id ? c.copyWith(title: trimmed) : c).toList(),
      nextCursor: state.nextCursor,
    );
    try {
      await _api.renameConversation(id, trimmed);
      _ref.read(ragChatNotifierProvider.notifier).onConversationRenamed(id, trimmed);
    } catch (e) {
      state = ChatHistoryState(
        items: before,
        nextCursor: state.nextCursor,
        error: e is RagApiException ? e.message : 'Could not rename the conversation.',
      );
    }
  }
}

final chatHistoryProvider =
    StateNotifierProvider<ChatHistoryNotifier, ChatHistoryState>((ref) {
  return ChatHistoryNotifier(ref.watch(ragApiServiceProvider), ref);
});
