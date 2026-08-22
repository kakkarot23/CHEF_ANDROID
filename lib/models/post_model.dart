import 'user_model.dart';
import 'recipe_model.dart';

class PostModel {
  final String id;
  final UserModel author;
  final String location;
  final String foodImage;
  final String foodName;
  final String description;
  final int prepTimeMinutes;
  final String difficulty;
  final String cuisine;
  int likesCount;
  int commentsCount;
  int savesCount;
  bool isLiked;
  bool isSaved;
  final RecipeModel? recipe;
  final String timeAgo;

  PostModel({
    required this.id,
    required this.author,
    required this.location,
    required this.foodImage,
    required this.foodName,
    required this.description,
    required this.prepTimeMinutes,
    required this.difficulty,
    required this.cuisine,
    required this.likesCount,
    required this.commentsCount,
    required this.savesCount,
    this.isLiked = false,
    this.isSaved = false,
    this.recipe,
    required this.timeAgo,
  });
}
