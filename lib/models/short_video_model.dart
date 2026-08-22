import 'user_model.dart';

class ShortVideoModel {
  final String id;
  final UserModel author;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;
  int likesCount;
  int commentsCount;
  int sharesCount;
  bool isLiked;
  final String recipeId;

  ShortVideoModel({
    required this.id,
    required this.author,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.likesCount,
    required this.commentsCount,
    required this.sharesCount,
    this.isLiked = false,
    required this.recipeId,
  });
}
