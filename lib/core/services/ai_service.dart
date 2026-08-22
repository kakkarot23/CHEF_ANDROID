import '../../models/recipe_model.dart';
import '../../models/ingredient_model.dart';
import '../constants/mock_data.dart';

class AIService {
  // Generate Recipe based on available ingredients
  static Future<RecipeModel> generateRecipeFromIngredients(List<String> userIngredients) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate AI calculation

    final formattedIngredients = userIngredients.isEmpty 
        ? ['Chicken', 'Coconut Milk', 'Onions', 'Curry Leaves'] 
        : userIngredients;

    final title = 'AI Gourmet: ${formattedIngredients.take(2).join(" & ")} Fusion';

    return RecipeModel(
      id: 'ai_${DateTime.now().millisecondsSinceEpoch}',
      title: title,
      description: 'Custom AI curated recipe generated specifically for your available kitchen pantry items: ${formattedIngredients.join(", ")}.',
      coverImage: 'https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&auto=format&fit=crop',
      author: MockData.chefArjun,
      cuisine: 'Smart Fusion',
      category: 'Main Course',
      difficulty: 'Easy',
      prepTimeMinutes: 10,
      cookTimeMinutes: 20,
      servings: 3,
      calories: 420,
      rating: 4.9,
      reviewsCount: 12,
      dietaryOptions: ['Custom Pantry', 'High Protein', 'Gluten Free'],
      ingredients: formattedIngredients.map((item) => IngredientModel(
        name: item,
        quantity: '1',
        unit: 'portion',
      )).toList(),
      steps: [
        RecipeStepModel(
          stepNumber: 1,
          title: 'Prep Ingredients',
          instruction: 'Clean and chop ${formattedIngredients.join(", ")} evenly.',
          timerMinutes: 5,
        ),
        RecipeStepModel(
          stepNumber: 2,
          title: 'Sauté & Infuse Aromatics',
          instruction: 'Heat olive oil or ghee in a pan. Sauté aromatics until fragrant.',
          timerMinutes: 8,
        ),
        RecipeStepModel(
          stepNumber: 3,
          title: 'Combine & Simmer',
          instruction: 'Add remaining ingredients with a pinch of sea salt and simmer until tender.',
          timerMinutes: 12,
        ),
      ],
    );
  }

  // Ingredient Substitution Engine
  static List<Map<String, String>> getSubstitutions(String ingredientName) {
    final lower = ingredientName.toLowerCase();
    if (lower.contains('butter')) {
      return [
        {'sub': 'Ghee (Clarified Butter)', 'ratio': '1:1 ratio', 'note': 'Adds rich nutty aroma, ideal for high heat cooking'},
        {'sub': 'Extra Virgin Olive Oil', 'ratio': '3/4 cup per 1 cup butter', 'note': 'Heart-healthy alternative for sautéing'},
        {'sub': 'Coconut Oil', 'ratio': '1:1 ratio', 'note': 'Best for baking and tropical curries'},
      ];
    } else if (lower.contains('heavy cream') || lower.contains('cream')) {
      return [
        {'sub': 'Thick Coconut Milk', 'ratio': '1:1 ratio', 'note': 'Dairy-free, creamy texture for curries'},
        {'sub': 'Greek Yogurt + Milk', 'ratio': '1:1 ratio', 'note': 'Lower calorie option with slight tang'},
        {'sub': 'Blended Cashew Cream', 'ratio': '1/2 cup cashews + 1/2 cup water', 'note': 'Ultra-rich vegan alternative'},
      ];
    } else if (lower.contains('egg') || lower.contains('eggs')) {
      return [
        {'sub': 'Flaxseed Egg', 'ratio': '1 tbsp ground flax + 3 tbsp water', 'note': 'Ideal binder for baking'},
        {'sub': 'Mashed Banana', 'ratio': '1/2 banana per egg', 'note': 'Adds natural sweetness'},
        {'sub': 'Aquafaba (Chickpea water)', 'ratio': '3 tbsp per egg', 'note': 'Best for meringues & light batters'},
      ];
    } else {
      return [
        {'sub': 'Organic Himalayan Salt & Herb Blend', 'ratio': 'To taste', 'note': 'Enhances natural ingredient profile'},
        {'sub': 'Avocado Oil', 'ratio': '1:1 ratio', 'note': 'High smoke point substitute'},
      ];
    }
  }
}
