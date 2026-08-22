import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/user_model.dart';
import '../../core/constants/mock_data.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/chef_badge.dart';
import '../chef_dashboard/chef_dashboard_screen.dart';
import '../../widgets/recipe_card.dart';

class ChefProfileScreen extends StatefulWidget {
  final UserModel? user;

  const ChefProfileScreen({super.key, this.user});

  @override
  State<ChefProfileScreen> createState() => _ChefProfileScreenState();
}

class _ChefProfileScreenState extends State<ChefProfileScreen> with SingleTickerProviderStateMixin {
  late UserModel _user;
  late TabController _tabController;
  bool _isFollowing = false;

  @override
  void initState() {
    super.initState();
    _user = widget.user ?? MockData.chefArjun;
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          _user.handle,
          style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics_outlined, color: AppColors.primary),
            tooltip: 'Chef Dashboard',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChefDashboardScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Profile Photo
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [AppColors.primary, AppColors.accentGold],
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: CachedNetworkImageProvider(_user.profileImage),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Name & Verified Badge
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          _user.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (_user.isVerified) ...[
                          const SizedBox(width: 6),
                          const ChefBadge(size: 20),
                        ],
                      ],
                    ),

                    const SizedBox(height: 4),

                    // Role & Location
                    Text(
                      '${_user.role} • ${_user.location}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Bio
                    Text(
                      _user.bio,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Specialization Chips
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      alignment: WrapAlignment.center,
                      children: _user.specializations.map((spec) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            spec,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),

                    // Stats Row (Followers | Following | Recipes)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatColumn('${(_user.followersCount / 1000).toStringAsFixed(1)}K', 'Followers'),
                        Container(height: 24, width: 1, color: AppColors.border),
                        _buildStatColumn('${_user.followingCount}', 'Following'),
                        Container(height: 24, width: 1, color: AppColors.border),
                        _buildStatColumn('${_user.totalRecipesCount}', 'Recipes'),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Buttons: [ FOLLOW ] [ MESSAGE ] [ DASHBOARD ]
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isFollowing ? Colors.grey.shade200 : AppColors.primary,
                              foregroundColor: _isFollowing ? AppColors.textPrimary : Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            onPressed: () {
                              setState(() => _isFollowing = !_isFollowing);
                            },
                            child: Text(
                              _isFollowing ? 'FOLLOWING' : 'FOLLOW CHEF',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.textPrimary,
                              side: const BorderSide(color: AppColors.border),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Opening Chat Message window...')),
                              );
                            },
                            child: const Text('MESSAGE', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  indicatorColor: AppColors.primary,
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(icon: Icon(Icons.grid_on_rounded), text: 'Posts'),
                    Tab(icon: Icon(Icons.restaurant_menu), text: 'Recipes'),
                    Tab(icon: Icon(Icons.bookmark_outline), text: 'Saved'),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            // Tab 1: Food Posts Grid
            GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              itemCount: MockData.posts.length * 3,
              itemBuilder: (context, index) {
                final post = MockData.posts[index % MockData.posts.length];
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: post.foodImage,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),

            // Tab 2: Recipes Grid
            GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: 2,
              itemBuilder: (context, index) {
                return RecipeCard(recipe: index == 0 ? MockData.recipeKeralaChickenCurry : MockData.recipeButterChicken);
              },
            ),

            // Tab 3: Saved Items
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                RecipeCard(recipe: MockData.recipeHandmadePasta),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
