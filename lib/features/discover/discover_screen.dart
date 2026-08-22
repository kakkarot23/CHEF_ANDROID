import 'package:flutter/material.dart';
import '../../core/constants/mock_data.dart';
import '../../core/constants/app_colors.dart';
import '../../models/recipe_model.dart';
import '../../widgets/recipe_card.dart';
import '../../widgets/chef_avatar.dart';
import '../profile/chef_profile_screen.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String _searchQuery = '';
  String _selectedCuisine = 'All';
  String _selectedDiet = 'All';
  String _selectedTime = 'All';

  final List<String> _cuisines = ['All', 'Indian', 'Italian', 'Mexican', 'Asian'];
  final List<String> _diets = ['All', 'Vegetarian', 'Vegan', 'Keto', 'Gluten Free'];
  final List<String> _times = ['All', '< 15 min', '< 30 min', '< 60 min'];

  List<RecipeModel> get _filteredRecipes {
    final allRecipes = [
      MockData.recipeKeralaChickenCurry,
      MockData.recipeButterChicken,
      MockData.recipeHandmadePasta,
    ];

    return allRecipes.where((recipe) {
      // Search query filter
      final matchesSearch = _searchQuery.isEmpty ||
          recipe.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          recipe.cuisine.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          recipe.author.name.toLowerCase().contains(_searchQuery.toLowerCase());

      // Cuisine filter
      final matchesCuisine = _selectedCuisine == 'All' || recipe.cuisine.contains(_selectedCuisine);

      // Diet filter
      final matchesDiet = _selectedDiet == 'All' || recipe.dietaryOptions.contains(_selectedDiet);

      // Time filter
      bool matchesTime = true;
      if (_selectedTime == '< 15 min') {
        matchesTime = recipe.totalTimeMinutes <= 15;
      } else if (_selectedTime == '< 30 min') {
        matchesTime = recipe.totalTimeMinutes <= 30;
      } else if (_selectedTime == '< 60 min') {
        matchesTime = recipe.totalTimeMinutes <= 60;
      }

      return matchesSearch && matchesCuisine && matchesDiet && matchesTime;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Discover Culinary World',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 90),
        children: [
          // Search Input Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              onChanged: (val) => setState(() => _searchQuery = val),
              decoration: InputDecoration(
                hintText: 'Search recipes, chefs, ingredients...',
                hintStyle: const TextStyle(color: AppColors.textMuted),
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, size: 18),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Filters Section (Cuisine, Diet, Time)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildFilterChips('Cuisine', _cuisines, _selectedCuisine, (val) {
                  setState(() => _selectedCuisine = val);
                }),
                const SizedBox(height: 10),
                _buildFilterChips('Diet', _diets, _selectedDiet, (val) {
                  setState(() => _selectedDiet = val);
                }),
                const SizedBox(height: 10),
                _buildFilterChips('Cooking Time', _times, _selectedTime, (val) {
                  setState(() => _selectedTime = val);
                }),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Popular Chefs Section
          if (_searchQuery.isEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Popular Master Chefs',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildChefItem(MockData.chefArjun),
                  _buildChefItem(MockData.chefPriya),
                  _buildChefItem(MockData.chefMarco),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Search Results / Recipes Grid Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              _searchQuery.isNotEmpty ? 'Search Results (${_filteredRecipes.length})' : 'Explore Recipes',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 12),

          // Recipes Grid
          if (_filteredRecipes.isEmpty)
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                children: const [
                  Icon(Icons.search_off_rounded, size: 48, color: AppColors.textMuted),
                  SizedBox(height: 12),
                  Text(
                    'No recipes matched your search filter.',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
                  ),
                ],
              ),
            )
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _filteredRecipes.length,
              itemBuilder: (context, index) {
                return RecipeCard(recipe: _filteredRecipes[index]);
              },
            ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(
    String label,
    List<String> options,
    String selectedValue,
    Function(String) onSelect,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: options.map((opt) {
          final isSelected = opt == selectedValue;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(opt),
              selected: isSelected,
              onSelected: (_) => onSelect(opt),
              selectedColor: AppColors.primary,
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? AppColors.primary : AppColors.border,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildChefItem(user) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ChefProfileScreen(user: user)),
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ChefAvatar(imageUrl: user.profileImage, radius: 22, isVerified: user.isVerified),
            const SizedBox(height: 6),
            Text(
              user.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            Text(
              '${(user.followersCount / 1000).toStringAsFixed(1)}K followers',
              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
