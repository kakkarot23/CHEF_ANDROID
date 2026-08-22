import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/post_model.dart';
import '../core/constants/app_colors.dart';
import 'chef_avatar.dart';
import 'chef_badge.dart';
import 'comments_bottom_sheet.dart';
import '../features/recipes/recipe_detail_screen.dart';

class FoodCard extends StatefulWidget {
  final PostModel post;
  final VoidCallback? onChefTap;

  const FoodCard({
    super.key,
    required this.post,
    this.onChefTap,
  });

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  late bool _isLiked;
  late int _likesCount;
  late bool _isSaved;
  late int _savesCount;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.isLiked;
    _likesCount = widget.post.likesCount;
    _isSaved = widget.post.isSaved;
    _savesCount = widget.post.savesCount;
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
      _isLiked ? _likesCount++ : _likesCount--;
    });
  }

  void _toggleSave() {
    setState(() {
      _isSaved = !_isSaved;
      _isSaved ? _savesCount++ : _savesCount--;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isSaved ? 'Saved to Kerala Recipes collection' : 'Removed from collection'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Chef info
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                ChefAvatar(
                  imageUrl: post.author.profileImage,
                  radius: 20,
                  isVerified: post.author.isVerified,
                  onTap: widget.onChefTap,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: widget.onChefTap,
                            child: Text(
                              post.author.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          if (post.author.isVerified) ...[
                            const SizedBox(width: 4),
                            const ChefBadge(size: 16),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 12, color: AppColors.textSecondary),
                          const SizedBox(width: 2),
                          Text(
                            post.location,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '• ${post.timeAgo}',
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: AppColors.textSecondary),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          // Food Photo
          GestureDetector(
            onDoubleTap: _toggleLike,
            onTap: () {
              if (post.recipe != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => RecipeDetailScreen(recipe: post.recipe!),
                  ),
                );
              }
            },
            child: Stack(
              children: [
                ClipRRect(
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: CachedNetworkImage(
                      imageUrl: post.foodImage,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade100,
                        child: const Center(
                          child: CircularProgressIndicator(color: AppColors.primary),
                        ),
                      ),
                    ),
                  ),
                ),

                // Difficulty Tag Overlay
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.local_fire_department, color: AppColors.accentGold, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          post.difficulty,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Action Buttons: Like, Comment, Save, Share
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    color: _isLiked ? AppColors.heartRed : AppColors.textPrimary,
                  ),
                  onPressed: _toggleLike,
                ),
                Text(
                  '${_likesCount > 999 ? "${(_likesCount / 1000).toStringAsFixed(1)}K" : _likesCount}',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const SizedBox(width: 16),

                IconButton(
                  icon: const Icon(Icons.chat_bubble_outline_rounded),
                  onPressed: () => CommentsBottomSheet.show(context, post.foodName),
                ),
                Text(
                  '${post.commentsCount}',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),
                const SizedBox(width: 16),

                IconButton(
                  icon: Icon(
                    _isSaved ? Icons.bookmark : Icons.bookmark_border_rounded,
                    color: _isSaved ? AppColors.primary : AppColors.textPrimary,
                  ),
                  onPressed: _toggleSave,
                ),
                Text(
                  '${_savesCount}',
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                ),

                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.share_outlined),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Recipe link copied to clipboard ↗'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Food Name & Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.foodName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  post.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Details Row (Time, Difficulty, Cuisine)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.timer_outlined, size: 14, color: AppColors.primary),
                      const SizedBox(width: 4),
                      Text(
                        '⏱ ${post.prepTimeMinutes} min',
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.restaurant_menu, size: 14, color: AppColors.accentTeal),
                      const SizedBox(width: 4),
                      Text(
                        post.cuisine,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // VIEW FULL RECIPE Button
          if (post.recipe != null)
            Padding(
              padding: const EdgeInsets.all(14),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => RecipeDetailScreen(recipe: post.recipe!),
                      ),
                    );
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'VIEW FULL RECIPE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
