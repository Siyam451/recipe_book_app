import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipebookapp/presentation/screens/home/widgets/recipe_list.dart';
import 'package:recipebookapp/presentation/screens/home/widgets/weekly_recipe_list.dart';

import '../providers/home_screen_provider.dart';
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
      builder: (context, provider, _) {

        if (provider.homescreenloading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (provider.errorMassege != null) {
          return Center(child: Text(provider.errorMassege!));
        }

        return ListView(
          children: const [
            RecipeList(),
            SizedBox(height: 20),
            WeeklyRecipeList(),
          ],
        );
      },
    );
  }
}