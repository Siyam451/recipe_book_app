import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipebookapp/presentation/common/screens/main_navigation_screen.dart';
import 'package:recipebookapp/presentation/screens/details/provider/recipe_details_provider.dart';
import 'package:recipebookapp/presentation/screens/home/home_screen.dart';
import 'package:recipebookapp/presentation/screens/home/providers/home_screen_provider.dart';
import 'package:recipebookapp/presentation/screens/search-by-name/provider/search_recipe_provider.dart';

import 'core/app_colors.dart';
import 'core/app_strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=> HomeScreenProvider()),
        ChangeNotifierProvider(create: (_)=> RecipeDetailsProvider()),
        ChangeNotifierProvider(create: (_)=> SearchRecipeProvider()),
      ],
      child: MaterialApp(
          title: AppStrings.appName,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.primary,
              secondary: AppColors.accent,
              surface: AppColors.surface,
              error: AppColors.error,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),
            useMaterial3: true,
          ),
        home: MainNavigationScreen()
      ),
    );
  }
}



