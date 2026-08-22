class CommentModel {
  final String id;
  final String authorName;
  final String authorImage;
  final String text;
  final String timeAgo;
  int likesCount;
  bool isLiked;

  CommentModel({
    required this.id,
    required this.authorName,
    required this.authorImage,
    required this.text,
    required this.timeAgo,
    this.likesCount = 0,
    this.isLiked = false,
  });
}
