import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../features/home/home_feed_screen.dart';
import '../features/discover/discover_screen.dart';
import '../features/create/create_post_modal.dart';
import '../features/video_shorts/cooking_shorts_screen.dart';
import '../features/profile/chef_profile_screen.dart';

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeFeedScreen(onNavigateTab: (index) => setState(() => _currentIndex = index)),
      const DiscoverScreen(),
      const SizedBox(), // Placeholder for central + launcher
      const CookingShortsScreen(),
      const ChefProfileScreen(),
    ];
  }

  void _onTabTapped(int index) {
    if (index == 2) {
      // Central + launcher modal
      CreatePostModal.show(context);
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 0,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              activeIcon: Icon(Icons.search_rounded),
              label: 'Discover',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.primaryDark],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 26),
              ),
              label: '',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.play_circle_outline),
              activeIcon: Icon(Icons.play_circle_fill),
              label: 'Shorts',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
