import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/constants/app_colors.dart';
import 'app/main_navigation_shell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ChefApp());
}

class ChefApp extends StatelessWidget {
  const ChefApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CHEF — Food & Recipes Social App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.accentGold,
          background: AppColors.background,
        ),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.outfitTextTheme(
          Theme.of(context).textTheme,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      home: const MainNavigationShell(),
    );
  }
}
