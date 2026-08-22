import 'package:flutter/material.dart';
import '../../core/constants/mock_data.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/recipe_card.dart';

class SavedRecipesScreen extends StatefulWidget {
  const SavedRecipesScreen({super.key});

  @override
  State<SavedRecipesScreen> createState() => _SavedRecipesScreenState();
}

class _SavedRecipesScreenState extends State<SavedRecipesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final savedRecipes = [
      MockData.recipeKeralaChickenCurry,
      MockData.recipeButterChicken,
      MockData.recipeHandmadePasta,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Saved Cookbook',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          tabs: const [
            Tab(text: 'Saved Recipes'),
            Tab(text: 'My Collections'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: Saved Recipes Grid
          GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: savedRecipes.length,
            itemBuilder: (context, index) {
              return RecipeCard(recipe: savedRecipes[index]);
            },
          ),

          // Tab 2: Collections Folders
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '📁 My Recipe Folders',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.create_new_folder_outlined, color: AppColors.primary),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Create Collection Folder Dialog')),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: MockData.savedCollections.length,
                itemBuilder: (context, index) {
                  final col = MockData.savedCollections[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: NetworkImage(col['image']),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.45),
                          BlendMode.darken,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          col['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${col['count']} Recipes',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
