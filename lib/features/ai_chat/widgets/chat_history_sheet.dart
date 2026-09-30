import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../models/chat_conversation_model.dart';
import '../providers/rag_chat_provider.dart';

Future<void> showChatHistorySheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const ChatHistorySheet(),
  );
}

/// Saved AI conversations: open, rename or delete.
class ChatHistorySheet extends ConsumerStatefulWidget {
  const ChatHistorySheet({super.key});

  @override
  ConsumerState<ChatHistorySheet> createState() => _ChatHistorySheetState();
}

class _ChatHistorySheetState extends ConsumerState<ChatHistorySheet> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(chatHistoryProvider.notifier).refresh());
  }

  String _groupFor(DateTime t) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(t.year, t.month, t.day);
    final diff = today.difference(day).inDays;
    if (diff <= 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff < 7) return 'Previous 7 days';
    if (diff < 30) return 'Previous 30 days';
    return DateFormat('MMMM yyyy').format(t);
  }

  Future<void> _rename(ChatConversationSummary c) async {
    final controller = TextEditingController(text: c.title);
    final title = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Rename chat'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 60,
          textCapitalization: TextCapitalization.sentences,
          onSubmitted: (v) => Navigator.pop(ctx, v),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, controller.text), child: const Text('Save')),
        ],
      ),
    );
    controller.dispose();
    if (title != null && title.trim().isNotEmpty) {
      await ref.read(chatHistoryProvider.notifier).rename(c.id, title);
    }
  }

  Future<bool> _confirmDelete(ChatConversationSummary c) async {
    return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Delete chat?'),
            content: Text('"${c.title}" will be removed from your chat history.'),
            actions: [
              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('Delete', style: TextStyle(color: AppColors.expenseRed)),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(chatHistoryProvider);
    final activeId = ref.watch(ragChatNotifierProvider.select((s) => s.conversationId));

    // Flatten into group headers + rows.
    final rows = <Object>[];
    String? currentGroup;
    for (final c in history.items) {
      final group = _groupFor(c.lastMessageAt);
      if (group != currentGroup) {
        rows.add(group);
        currentGroup = group;
      }
      rows.add(c);
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          const SizedBox(height: AppSpacing.md),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.screenPadding, AppSpacing.md, 8, AppSpacing.sm),
            child: Row(
              children: [
                Expanded(child: Text('Chat history', style: AppTextStyles.h2)),
                TextButton.icon(
                  onPressed: () {
                    ref.read(ragChatNotifierProvider.notifier).newChat();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.add_comment_rounded, size: 18),
                  label: const Text('New chat'),
                ),
              ],
            ),
          ),
          if (history.error != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPadding),
              child: Text(history.error!, style: AppTextStyles.caption.copyWith(color: AppColors.expenseRed)),
            ),
          Expanded(
            child: history.isLoading && history.items.isEmpty
                ? const Center(child: CircularProgressIndicator(color: AppColors.accent))
                : history.items.isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.xl),
                          child: Text(
                            'No saved chats yet.\nYour conversations with Spendly AI will appear here.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.mutedText),
                          ),
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () => ref.read(chatHistoryProvider.notifier).refresh(),
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (n) {
                            if (n.metrics.pixels > n.metrics.maxScrollExtent - 200) {
                              ref.read(chatHistoryProvider.notifier).loadMore();
                            }
                            return false;
                          },
                          child: ListView.builder(
                            itemCount: rows.length + (history.isLoadingMore ? 1 : 0),
                            itemBuilder: (_, i) {
                              if (i >= rows.length) {
                                return const Padding(
                                  padding: EdgeInsets.all(AppSpacing.md),
                                  child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                );
                              }
                              final row = rows[i];
                              if (row is String) {
                                return Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    AppSpacing.screenPadding, AppSpacing.md, AppSpacing.screenPadding, 4,
                                  ),
                                  child: Text(
                                    row.toUpperCase(),
                                    style: AppTextStyles.caption.copyWith(letterSpacing: 1.1),
                                  ),
                                );
                              }
                              final c = row as ChatConversationSummary;
                              return Dismissible(
                                key: ValueKey(c.id),
                                direction: DismissDirection.endToStart,
                                confirmDismiss: (_) => _confirmDelete(c),
                                onDismissed: (_) => ref.read(chatHistoryProvider.notifier).delete(c.id),
                                background: Container(
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 24),
                                  color: AppColors.statusOverdueBackground,
                                  child: const Icon(Icons.delete_outline_rounded, color: AppColors.expenseRed),
                                ),
                                child: ListTile(
                                  selected: c.id == activeId,
                                  selectedTileColor: AppColors.activeNavBg,
                                  leading: const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.mutedText),
                                  title: Text(c.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.h3),
                                  subtitle: c.preview.isEmpty
                                      ? null
                                      : Text(c.preview, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.caption),
                                  trailing: PopupMenuButton<String>(
                                    icon: const Icon(Icons.more_vert_rounded, color: AppColors.mutedText),
                                    onSelected: (v) async {
                                      if (v == 'rename') await _rename(c);
                                      if (v == 'delete' && await _confirmDelete(c)) {
                                        await ref.read(chatHistoryProvider.notifier).delete(c.id);
                                      }
                                    },
                                    itemBuilder: (_) => const [
                                      PopupMenuItem(value: 'rename', child: Text('Rename')),
                                      PopupMenuItem(value: 'delete', child: Text('Delete')),
                                    ],
                                  ),
                                  onTap: () {
                                    ref.read(ragChatNotifierProvider.notifier).loadConversation(c.id, title: c.title);
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
