import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/services/ai_service.dart';
import '../../models/recipe_model.dart';
import '../recipes/recipe_detail_screen.dart';

class AIRecipeGeneratorScreen extends StatefulWidget {
  const AIRecipeGeneratorScreen({super.key});

  @override
  State<AIRecipeGeneratorScreen> createState() => _AIRecipeGeneratorScreenState();
}

class _AIRecipeGeneratorScreenState extends State<AIRecipeGeneratorScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _pantryController = TextEditingController();
  final TextEditingController _substituteController = TextEditingController(text: 'Butter');
  
  final List<String> _ingredientsList = ['Chicken', 'Onion', 'Tomato', 'Coconut Milk', 'Garlic'];
  bool _isLoading = false;
  RecipeModel? _generatedRecipe;
  List<Map<String, String>> _substitutionResults = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _onSearchSubstitutions('Butter');
  }

  void _addPantryItem() {
    if (_pantryController.text.trim().isNotEmpty) {
      setState(() {
        _ingredientsList.add(_pantryController.text.trim());
        _pantryController.clear();
      });
    }
  }

  void _generateRecipe() async {
    setState(() => _isLoading = true);
    final recipe = await AIService.generateRecipeFromIngredients(_ingredientsList);
    setState(() {
      _generatedRecipe = recipe;
      _isLoading = false;
    });
  }

  void _onSearchSubstitutions(String name) {
    setState(() {
      _substitutionResults = AIService.getSubstitutions(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.auto_awesome, color: AppColors.primary),
            SizedBox(width: 8),
            Text(
              'CHEF AI Assistant',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'AI Recipe Generator'),
            Tab(text: 'Ingredient Substitutions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: AI Recipe Generator from Pantry
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFF5722), Color(0xFFFF8A65)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '🤖 What ingredients do you have today?',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Enter your fridge pantry items and let CHEF AI craft a customized recipe instantly.',
                      style: TextStyle(color: Colors.white70, fontSize: 13),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Add Ingredient Bar
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _pantryController,
                      decoration: InputDecoration(
                        hintText: 'Add ingredient (e.g. Rice, Mushroom)',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _addPantryItem(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: _addPantryItem,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Chips of added ingredients
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _ingredientsList.map((item) {
                  return Chip(
                    backgroundColor: Colors.white,
                    label: Text(item, style: const TextStyle(fontWeight: FontWeight.w600)),
                    deleteIcon: const Icon(Icons.close, size: 16),
                    onDeleted: () {
                      setState(() => _ingredientsList.remove(item));
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // Generate Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Icon(Icons.auto_awesome, color: Colors.white),
                  label: Text(
                    _isLoading ? 'AI GENERATING RECIPE...' : 'GENERATE AI RECIPE',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
                  ),
                  onPressed: _isLoading ? null : _generateRecipe,
                ),
              ),

              const SizedBox(height: 24),

              // Generated Recipe Result
              if (_generatedRecipe != null) ...[
                const Text(
                  'Generated AI Masterpiece:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _generatedRecipe!.title,
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _generatedRecipe!.description,
                        style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                      ),
                      const SizedBox(height: 14),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accentTeal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RecipeDetailScreen(recipe: _generatedRecipe!),
                            ),
                          );
                        },
                        child: const Text('View Full AI Cooking Steps →'),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),

          // Tab 2: AI Ingredient Substitution Helper
          ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'No Butter or Heavy Cream?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              const Text(
                'Find instant culinary substitutes with exact conversion ratios.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 16),

              TextField(
                controller: _substituteController,
                decoration: InputDecoration(
                  hintText: 'Enter missing ingredient (e.g. Butter, Cream, Egg)...',
                  prefixIcon: const Icon(Icons.swap_horiz, color: AppColors.primary),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: _onSearchSubstitutions,
              ),

              const SizedBox(height: 20),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _substitutionResults.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final sub = _substitutionResults[index];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.check_circle_rounded, color: AppColors.accentGreen, size: 20),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                sub['sub']!,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                            ),
                            Chip(
                              backgroundColor: AppColors.primary.withOpacity(0.1),
                              label: Text(
                                sub['ratio']!,
                                style: const TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          sub['note']!,
                          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
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
