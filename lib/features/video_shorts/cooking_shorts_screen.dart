import 'package:flutter/material.dart';
import '../../core/constants/mock_data.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/chef_avatar.dart';
import '../recipes/recipe_detail_screen.dart';

class CookingShortsScreen extends StatefulWidget {
  const CookingShortsScreen({super.key});

  @override
  State<CookingShortsScreen> createState() => _CookingShortsScreenState();
}

class _CookingShortsScreenState extends State<CookingShortsScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    final shorts = MockData.cookingShorts;

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: shorts.length,
        itemBuilder: (context, index) {
          final item = shorts[index];
          return Stack(
            fit: StackFit.expand,
            children: [
              // Background Image simulation of vertical cooking video
              Image.network(
                item.thumbnailUrl,
                fit: BoxFit.cover,
              ),

              // Dark Overlay Gradient
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              // Play Icon overlay
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
              ),

              // Right Action Buttons Tray (Like, Comment, Share, Recipe Link)
              Positioned(
                right: 16,
                bottom: 100,
                child: Column(
                  children: [
                    _buildActionButton(
                      icon: item.isLiked ? Icons.favorite : Icons.favorite_border,
                      color: item.isLiked ? AppColors.heartRed : Colors.white,
                      label: '${(item.likesCount / 1000).toStringAsFixed(1)}K',
                      onTap: () {
                        setState(() {
                          item.isLiked = !item.isLiked;
                          item.isLiked ? item.likesCount++ : item.likesCount--;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildActionButton(
                      icon: Icons.chat_bubble_outline_rounded,
                      color: Colors.white,
                      label: '${item.commentsCount}',
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),
                    _buildActionButton(
                      icon: Icons.share_outlined,
                      color: Colors.white,
                      label: '${item.sharesCount}',
                      onTap: () {},
                    ),
                    const SizedBox(height: 20),

                    // Recipe Shortcut Button
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RecipeDetailScreen(recipe: MockData.recipeKeralaChickenCurry),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.restaurant_menu, color: Colors.white, size: 22),
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom Caption & Chef info
              Positioned(
                left: 16,
                right: 80,
                bottom: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ChefAvatar(
                          imageUrl: item.author.profileImage,
                          radius: 20,
                          isVerified: item.author.isVerified,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          item.author.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Follow',
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            radius: 22,
            backgroundColor: Colors.black.withOpacity(0.4),
            child: Icon(icon, color: color, size: 24),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
