import 'ingredient_model.dart';
import 'user_model.dart';

class RecipeModel {
  final String id;
  final String title;
  final String description;
  final String coverImage;
  final UserModel author;
  final String cuisine;
  final String category;
  final String difficulty; // "Easy", "Medium", "Hard"
  final int prepTimeMinutes;
  final int cookTimeMinutes;
  final int servings;
  final int calories;
  final double rating;
  final int reviewsCount;
  final List<IngredientModel> ingredients;
  final List<RecipeStepModel> steps;
  final List<String> dietaryOptions; // e.g. ["Gluten Free", "Halal", "Keto"]
  int likesCount;
  int savesCount;
  bool isLiked;
  bool isSaved;

  RecipeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImage,
    required this.author,
    required this.cuisine,
    required this.category,
    required this.difficulty,
    required this.prepTimeMinutes,
    required this.cookTimeMinutes,
    required this.servings,
    required this.calories,
    this.rating = 4.8,
    this.reviewsCount = 42,
    required this.ingredients,
    required this.steps,
    required this.dietaryOptions,
    this.likesCount = 0,
    this.savesCount = 0,
    this.isLiked = false,
    this.isSaved = false,
  });

  int get totalTimeMinutes => prepTimeMinutes + cookTimeMinutes;
}
