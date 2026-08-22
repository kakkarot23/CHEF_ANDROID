import 'package:flutter/material.dart';
import '../../core/constants/mock_data.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/food_card.dart';
import '../../widgets/chef_avatar.dart';
import '../notifications/notifications_screen.dart';
import '../ai_assistant/ai_recipe_generator_screen.dart';
import '../profile/chef_profile_screen.dart';

class HomeFeedScreen extends StatefulWidget {
  final Function(int)? onNavigateTab;

  const HomeFeedScreen({super.key, this.onNavigateTab});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.restaurant_menu, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            const Text(
              'CHEF',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w900,
                fontSize: 22,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome, color: AppColors.primary),
            tooltip: 'AI Recipe Assistant',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AIRecipeGeneratorScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: AppColors.textPrimary),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
          setState(() {});
        },
        child: ListView(
          padding: const EdgeInsets.only(top: 12, bottom: 80),
          children: [
            // Chef Highlights / Stories Tray
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  // Create Story item
                  _buildStoryItem(
                    title: 'Your Story',
                    imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop',
                    isAdd: true,
                    onTap: () {
                      if (widget.onNavigateTab != null) {
                        widget.onNavigateTab!(2);
                      }
                    },
                  ),
                  _buildStoryItem(
                    title: MockData.chefArjun.name.split(' ')[1],
                    imageUrl: MockData.chefArjun.profileImage,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChefProfileScreen(user: MockData.chefArjun),
                        ),
                      );
                    },
                  ),
                  _buildStoryItem(
                    title: MockData.chefPriya.name.split(' ')[1],
                    imageUrl: MockData.chefPriya.profileImage,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChefProfileScreen(user: MockData.chefPriya),
                        ),
                      );
                    },
                  ),
                  _buildStoryItem(
                    title: MockData.chefMarco.name.split(' ')[1],
                    imageUrl: MockData.chefMarco.profileImage,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChefProfileScreen(user: MockData.chefMarco),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Feed Posts List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: MockData.posts.map((post) {
                  return FoodCard(
                    post: post,
                    onChefTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChefProfileScreen(user: post.author),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryItem({
    required String title,
    required String imageUrl,
    bool isAdd = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            Stack(
              children: [
                ChefAvatar(
                  imageUrl: imageUrl,
                  radius: 28,
                  isVerified: false,
                ),
                if (isAdd)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 14),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
