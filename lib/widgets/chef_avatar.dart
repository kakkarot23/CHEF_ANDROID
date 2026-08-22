import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ChefAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final bool isVerified;
  final VoidCallback? onTap;

  const ChefAvatar({
    super.key,
    required this.imageUrl,
    this.radius = 24.0,
    this.isVerified = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFFF5722), Color(0xFFFFB300)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: CircleAvatar(
              radius: radius,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: CachedNetworkImageProvider(imageUrl),
            ),
          ),
          if (isVerified)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.verified_rounded,
                  size: 14,
                  color: Color(0xFF1DA1F2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
