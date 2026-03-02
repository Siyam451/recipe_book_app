import 'package:flutter/material.dart';
import 'package:recipebookapp/core/app_strings.dart';
import 'package:recipebookapp/presentation/screens/home/widgets/recipecard.dart';
import 'package:recipebookapp/presentation/screens/home/widgets/weekly_recipe_tile.dart';

import '../../../domain/entities/recipes.dart';
import '../details/details_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;   // Category index

  final List<Recipe> popularRecipes = [
    Recipe(
      id: 1,
      title: "Seafood Fried Rice",
      image:
      "https://images.unsplash.com/photo-1604908176997-431d09e9a3c2?w=800&q=80",
      author: "Kadin Curtis",
      rating: 5.0,
    ),
    Recipe(
      id: 2,
      title: "Caprese Salad",
      image:
      "https://images.unsplash.com/photo-1604909052743-2a5d7a2b84f6?w=800&q=80",
      author: "Desirae Herwitz",
      rating: 4.9,
    ),
    Recipe(
      id: 3,
      title: "Chicken Salad",
      image:
      "https://images.unsplash.com/photo-1546069901-ba9599a7e63c?w=800&q=80",
      author: "John Smith",
      rating: 4.8,
    ),
    Recipe(
      id: 4,
      title: "Pasta Alfredo",
      image:
      "https://images.unsplash.com/photo-1605478371310-a9f1e96b6b2a?w=800&q=80",
      author: "Maria Lopez",
      rating: 4.7,
    ),
  ];

  final List<String> categories = [
    "All",
    "Breakfast",
    "Lunch",
    "Dinner",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 10),

                /// HEADER
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage:
                      NetworkImage(AppStrings.profileImageUrl),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Welcome Back!",
                          style: TextStyle(
                              fontSize: 14, color: Colors.grey),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Shahrina sultana Liza",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search)),
                    IconButton(
                        onPressed: () {},
                        icon:
                        const Icon(Icons.notifications_active)),
                  ],
                ),

                const SizedBox(height: 20),

                /// CATEGORIES
                const Text(
                  "Categories",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 12),

                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.orange
                                : Colors.white,
                            borderRadius:
                            BorderRadius.circular(20),
                            border: Border.all(
                                color: Colors.grey.shade300),
                          ),
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 25),

                /// POPULAR RECIPES
                const Text(
                  "Popular Recipes",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 16),

                SizedBox(
                  height: 220,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularRecipes.length,
                    itemBuilder: (context, index) {
                      final recipe = popularRecipes[index];

                      return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: SizedBox(
                          width: 160,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      RecipeDetailsScreen(recipe: recipe),
                                ),
                              );
                            },
                            child: RecipeCard(
                              image: recipe.image,
                              rating: recipe.rating.toString(),
                              title: recipe.title,
                              author: recipe.author,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                /// WEEKLY
                const Text(
                  "Recipes of The Weeks",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 16),

                ListView.builder(
                  shrinkWrap: true,
                  physics:
                  const NeverScrollableScrollPhysics(),
                  itemCount: popularRecipes.length,
                  itemBuilder: (context, index) {
                    return WeeklyRecipeTile(
                      recipe: popularRecipes[index],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}