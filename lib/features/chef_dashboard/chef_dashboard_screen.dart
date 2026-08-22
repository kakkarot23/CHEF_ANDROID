import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class ChefDashboardScreen extends StatelessWidget {
  const ChefDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'CHEF DASHBOARD',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            fontSize: 18,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Overview Section Header
          const Text(
            'Performance Overview',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),

          // Overview Metric Grid Cards
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: [
              _buildMetricCard('Total Views', '124,520', Icons.visibility_outlined, AppColors.primary),
              _buildMetricCard('Followers', '12,420', Icons.people_outline, const Color(0xFF00897B)),
              _buildMetricCard('Published Recipes', '248', Icons.restaurant_menu, const Color(0xFFFFB300)),
              _buildMetricCard('Total Likes', '84,250', Icons.favorite_border, AppColors.heartRed),
            ],
          ),

          const SizedBox(height: 24),

          // Weekly Growth Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Weekly Growth Trends',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Chip(
                      backgroundColor: Color(0xFFE8F5E9),
                      label: Text('Last 7 Days', style: TextStyle(color: Color(0xFF2E7D32), fontSize: 12, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildGrowthRow('Views Rate', '↑ 24%', const Color(0xFF4CAF50)),
                const Divider(height: 24),
                _buildGrowthRow('New Followers', '↑ 12%', const Color(0xFF4CAF50)),
                const Divider(height: 24),
                _buildGrowthRow('Engagement & Likes', '↑ 31%', const Color(0xFF4CAF50)),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Top Performing Recipes List
          const Text(
            'Top Performing Recipes',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          _buildTopRecipeItem(
            rank: '1',
            title: 'Kerala Chicken Curry',
            views: '45.2K views',
            rating: '4.9 ★',
            image: 'https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?w=200&auto=format&fit=crop',
          ),
          _buildTopRecipeItem(
            rank: '2',
            title: 'Velvety Murgh Makhani',
            views: '38.9K views',
            rating: '5.0 ★',
            image: 'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?w=200&auto=format&fit=crop',
          ),
          _buildTopRecipeItem(
            rank: '3',
            title: 'Malabar Mutton Biryani',
            views: '29.1K views',
            rating: '4.8 ★',
            image: 'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?w=200&auto=format&fit=crop',
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(String label, String value, IconData icon, Color color) {
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              Icon(icon, color: color, size: 20),
            ],
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthRow(String metric, String growth, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(metric, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        Text(growth, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: color)),
      ],
    );
  }

  Widget _buildTopRecipeItem({
    required String rank,
    required String title,
    required String views,
    required String rating,
    required String image,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Text(
            rank,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
          ),
          const SizedBox(width: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(image, width: 44, height: 44, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(views, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accentGold.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              rating,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
