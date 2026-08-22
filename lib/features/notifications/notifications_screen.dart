import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'icon': Icons.favorite,
        'color': AppColors.heartRed,
        'title': 'Chef Priya Roy liked your recipe',
        'subtitle': 'Kerala Chicken Curry',
        'time': '10 min ago',
      },
      {
        'icon': Icons.person_add,
        'color': AppColors.primary,
        'title': 'Rahul Verma started following you',
        'subtitle': 'You have 12.4K followers now',
        'time': '45 min ago',
      },
      {
        'icon': Icons.mode_comment,
        'color': const Color(0xFF00897B),
        'title': 'Anu Sharma commented on your recipe',
        'subtitle': '"How much coconut milk should I use?"',
        'time': '2 hours ago',
      },
      {
        'icon': Icons.star,
        'color': AppColors.accentGold,
        'title': 'Your recipe received a 5-star rating ⭐',
        'subtitle': 'Kerala Chicken Curry',
        'time': '5 hours ago',
      },
      {
        'icon': Icons.local_fire_department,
        'color': AppColors.primary,
        'title': '🔥 Your recipe is trending on CHEF!',
        'subtitle': 'Featured on the Discover screen top choices',
        'time': '1 day ago',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final item = notifications[index];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: (item['color'] as Color).withOpacity(0.15),
                  child: Icon(item['icon'] as IconData, color: item['color'] as Color, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item['subtitle'] as String,
                        style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                      ),
                    ],
                  ),
                ),
                Text(
                  item['time'] as String,
                  style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
