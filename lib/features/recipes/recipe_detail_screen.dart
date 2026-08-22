import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/recipe_model.dart';
import '../../core/constants/app_colors.dart';
import '../../widgets/chef_avatar.dart';
import '../../widgets/chef_badge.dart';

class RecipeDetailScreen extends StatefulWidget {
  final RecipeModel recipe;

  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late int _servings;
  late bool _isLiked;
  late bool _isSaved;
  final Set<int> _checkedIngredients = {};

  @override
  void initState() {
    super.initState();
    _servings = widget.recipe.servings;
    _isLiked = widget.recipe.isLiked;
    _isSaved = widget.recipe.isSaved;
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;
    final scaleFactor = _servings / recipe.servings;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar with Cover Image
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            actions: [
              IconButton(
                icon: Icon(_isLiked ? Icons.favorite : Icons.favorite_border),
                color: _isLiked ? AppColors.heartRed : Colors.white,
                onPressed: () {
                  setState(() => _isLiked = !_isLiked);
                },
              ),
              IconButton(
                icon: Icon(_isSaved ? Icons.bookmark : Icons.bookmark_border),
                color: _isSaved ? AppColors.primary : Colors.white,
                onPressed: () {
                  setState(() => _isSaved = !_isSaved);
                },
              ),
              IconButton(
                icon: const Icon(Icons.share_outlined),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Recipe link copied!')),
                  );
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: recipe.coverImage,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            recipe.cuisine.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          recipe.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Recipe Body
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Chef Header
                  Row(
                    children: [
                      ChefAvatar(
                        imageUrl: recipe.author.profileImage,
                        radius: 22,
                        isVerified: recipe.author.isVerified,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  recipe.author.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                if (recipe.author.isVerified) ...[
                                  const SizedBox(width: 4),
                                  const ChefBadge(),
                                ],
                              ],
                            ),
                            Text(
                              recipe.author.role,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text('Follow'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Quick Stats Row (Prep Time, Cook Time, Servings, Calories)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(Icons.timer_outlined, '${recipe.prepTimeMinutes}m', 'Prep Time'),
                        _buildDivider(),
                        _buildStatItem(Icons.outdoor_grill_outlined, '${recipe.cookTimeMinutes}m', 'Cook Time'),
                        _buildDivider(),
                        _buildStatItem(Icons.local_fire_department_outlined, '${recipe.calories}', 'Calories'),
                        _buildDivider(),
                        _buildStatItem(Icons.star_rounded, '${recipe.rating}', 'Rating'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Description
                  Text(
                    recipe.description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textPrimary,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Servings Selector & Ingredients Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove, size: 16),
                              onPressed: () {
                                if (_servings > 1) {
                                  setState(() => _servings--);
                                }
                              },
                            ),
                            Text(
                              '$_servings Servings',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add, size: 16),
                              onPressed: () {
                                setState(() => _servings++);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Dynamic Ingredients Checklist
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recipe.ingredients.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final ing = recipe.ingredients[index];
                      final isChecked = _checkedIngredients.contains(index);
                      
                      // Calculate adjusted quantity
                      double qty = double.tryParse(ing.quantity) ?? 1.0;
                      double adjustedQty = qty * scaleFactor;
                      String displayQty = adjustedQty % 1 == 0 
                          ? adjustedQty.toInt().toString() 
                          : adjustedQty.toStringAsFixed(1);

                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (isChecked) {
                              _checkedIngredients.remove(index);
                            } else {
                              _checkedIngredients.add(index);
                            }
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          decoration: BoxDecoration(
                            color: isChecked ? AppColors.primary.withOpacity(0.05) : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isChecked ? AppColors.primary.withOpacity(0.3) : AppColors.border,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                isChecked ? Icons.check_circle : Icons.circle_outlined,
                                color: isChecked ? AppColors.primary : AppColors.textMuted,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  ing.name,
                                  style: TextStyle(
                                    fontSize: 15,
                                    decoration: isChecked ? TextDecoration.lineThrough : null,
                                    color: isChecked ? AppColors.textMuted : AppColors.textPrimary,
                                    fontWeight: isChecked ? FontWeight.normal : FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                '$displayQty ${ing.unit}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 28),

                  // Cooking Steps Header
                  const Text(
                    'Cooking Instructions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Steps List
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recipe.steps.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final step = recipe.steps[index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 14,
                                  backgroundColor: AppColors.primary,
                                  child: Text(
                                    '${step.stepNumber}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Text(
                                    step.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                if (step.timerMinutes != null)
                                  Chip(
                                    backgroundColor: AppColors.accentGold.withOpacity(0.15),
                                    avatar: const Icon(Icons.timer, size: 14, color: AppColors.accentGold),
                                    label: Text(
                                      '${step.timerMinutes}m',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              step.instruction,
                              style: const TextStyle(
                                fontSize: 14,
                                color: AppColors.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  // Start Cooking Mode Floating Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      icon: const Icon(Icons.play_circle_fill_rounded),
                      label: const Text(
                        'START GUIDED COOKING MODE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Starting step-by-step handsfree cooking mode 🍳'),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          label,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(height: 24, width: 1, color: AppColors.border);
  }
}
