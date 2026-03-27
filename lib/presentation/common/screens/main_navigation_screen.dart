import 'package:flutter/material.dart';
import 'package:recipebookapp/presentation/screens/profile/profile_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/saved-recipes/saved_recipe_screen.dart';
import '../app_nav_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState
    extends State<MainNavigationScreen> {

  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    Placeholder(),        // Recipes screen (future)
    Placeholder(),        // Add screen (center)
    SavedRecipeScreen(),
    ProfileScreen(),       
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      bottomNavigationBar: AppBottomNavBar(
        selectedIndex: _currentIndex,
        onItemTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}