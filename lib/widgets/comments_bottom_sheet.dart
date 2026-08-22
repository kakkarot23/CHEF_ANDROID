import 'package:flutter/material.dart';
import '../models/comment_model.dart';
import '../core/constants/mock_data.dart';
import '../core/constants/app_colors.dart';

class CommentsBottomSheet extends StatefulWidget {
  final String postTitle;

  const CommentsBottomSheet({super.key, required this.postTitle});

  static void show(BuildContext context, String postTitle) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CommentsBottomSheet(postTitle: postTitle),
    );
  }

  @override
  State<CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<CommentsBottomSheet> {
  final List<CommentModel> _comments = List.from(MockData.sampleComments);
  final TextEditingController _commentController = TextEditingController();

  void _addComment() {
    if (_commentController.text.trim().isEmpty) return;
    setState(() {
      _comments.insert(
        0,
        CommentModel(
          id: 'cm_${DateTime.now().millisecondsSinceEpoch}',
          authorName: 'Chef User',
          authorImage: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop',
          text: _commentController.text.trim(),
          timeAgo: 'Just now',
        ),
      );
      _commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          // Drag indicator
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.mode_comment_rounded, color: AppColors.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Comments (${_comments.length})',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Comments list
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _comments.length,
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final comment = _comments[index];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(comment.authorImage),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                comment.authorName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                comment.timeAgo,
                                style: const TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            comment.text,
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        comment.isLiked ? Icons.favorite : Icons.favorite_border,
                        size: 18,
                        color: comment.isLiked ? AppColors.heartRed : AppColors.textSecondary,
                      ),
                      onPressed: () {
                        setState(() {
                          comment.isLiked = !comment.isLiked;
                          comment.isLiked ? comment.likesCount++ : comment.likesCount--;
                        });
                      },
                    ),
                  ],
                );
              },
            ),
          ),
          // Input field
          Container(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
              bottom: MediaQuery.of(context).viewInsets.bottom + 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      hintText: 'Add a culinary comment...',
                      hintStyle: const TextStyle(color: AppColors.textMuted),
                      filled: true,
                      fillColor: AppColors.background,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: AppColors.primary,
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
                    onPressed: _addComment,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
