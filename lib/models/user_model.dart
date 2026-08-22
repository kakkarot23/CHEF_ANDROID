class UserModel {
  final String id;
  final String name;
  final String handle;
  final String profileImage;
  final String bio;
  final String role; // e.g. "Executive Chef", "Pastry Master", "Home Gourmet"
  final String location;
  final bool isVerified;
  final bool isChef;
  final int followersCount;
  final int followingCount;
  final int totalRecipesCount;
  final int totalLikesCount;
  final List<String> specializations;
  final double rating;

  UserModel({
    required this.id,
    required this.name,
    required this.handle,
    required this.profileImage,
    required this.bio,
    required this.role,
    required this.location,
    this.isVerified = true,
    this.isChef = true,
    required this.followersCount,
    required this.followingCount,
    required this.totalRecipesCount,
    required this.totalLikesCount,
    required this.specializations,
    this.rating = 4.9,
  });
}
