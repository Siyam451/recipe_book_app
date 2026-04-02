import 'package:recipebookapp/presentation/screens/home/providers/home_screen_provider.dart';
import 'package:recipebookapp/presentation/screens/home/widgets/category_list.dart';
import 'package:recipebookapp/presentation/screens/home/widgets/home_content.dart';
import 'package:recipebookapp/presentation/screens/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final provider = context.read<HomeScreenProvider>();

      await provider.fetchcategoryRecipes("All"); // wait
      await provider.loadFavorites();             // then load
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: const [
              HomeHeader(),
              SizedBox(height: 20),
              CategoryList(),
              SizedBox(height: 20),
              Expanded(child: HomeContent()),
            ],
          ),
        ),
      ),
    );
  }
}