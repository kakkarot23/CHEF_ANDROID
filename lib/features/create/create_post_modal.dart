import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import 'create_recipe_screen.dart';

class CreatePostModal extends StatelessWidget {
  const CreatePostModal({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const CreatePostModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'What do you want to create?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 20),

          _buildOptionTile(
            context,
            icon: Icons.menu_book_rounded,
            emoji: '🍲',
            title: 'Publish Detailed Recipe',
            subtitle: 'Ingredients, step-by-step photos & cooking timer',
            color: const Color(0xFFFF5722),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CreateRecipeScreen()),
              );
            },
          ),
          const SizedBox(height: 12),

          _buildOptionTile(
            context,
            icon: Icons.photo_camera_rounded,
            emoji: '📸',
            title: 'Share Food Post',
            subtitle: 'High quality food photography, caption & location',
            color: const Color(0xFF4CAF50),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Food Post Creator Opened 📸')),
              );
            },
          ),
          const SizedBox(height: 12),

          _buildOptionTile(
            context,
            icon: Icons.video_collection_rounded,
            emoji: '🎥',
            title: 'Upload Cooking Video Short',
            subtitle: 'Vertical 60-sec culinary Reel or technique clip',
            color: const Color(0xFF00897B),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Video Uploader Opened 🎥')),
              );
            },
          ),
          const SizedBox(height: 12),

          _buildOptionTile(
            context,
            icon: Icons.tips_and_updates_rounded,
            emoji: '📝',
            title: 'Share Cooking Tip',
            subtitle: 'Kitchen hacks, spice prep & knife tricks',
            color: const Color(0xFFFFB300),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Tip Creator Opened 📝')),
              );
            },
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildOptionTile(
    BuildContext context, {
    required IconData icon,
    required String emoji,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: color),
          ],
        ),
      ),
    );
  }
}
