import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipebookapp/core/app_strings.dart';
import 'package:recipebookapp/presentation/screens/home/providers/home_screen_provider.dart';
import 'package:recipebookapp/presentation/screens/home/widgets/recipecard.dart';
import 'package:recipebookapp/presentation/screens/home/widgets/weekly_recipe_tile.dart';
import 'package:recipebookapp/presentation/screens/search-by-name/search_by_name_screen.dart';
import '../details/details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int selectedIndex = 0;

  final List<String> categories = [
    "All",
    "Breakfast",
    "Lunch",
    "Dinner",
  ];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context
          .read<HomeScreenProvider>()
          .fetchcategoryRecipes("All");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                  GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=> SearchByNameScreen()));
                      },
                      child: Icon(Icons.search)),
                  SizedBox(width: 10),
                  Icon(Icons.notifications_active),
                ],
              ),

              const SizedBox(height: 20),

              /// CATEGORIES TITLE
              const Text(
                "Categories",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 12),

              /// CATEGORY LIST
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

                        context
                            .read<HomeScreenProvider>()
                            .fetchcategoryRecipes(categories[index]);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 18),
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

              const SizedBox(height: 20),

              /// DATA SECTION WITH CONSUMER
              Expanded(
                child: Consumer<HomeScreenProvider>(
                  builder: (context, provider, _) {

                    /// LOADING
                    if (provider.homescreenloading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    /// ERROR
                    if (provider.errorMassege != null) {
                      return Center(
                        child: Text(provider.errorMassege!),
                      );
                    }

                    /// DATA
                    return ListView(
                      children: [

                        const Text(
                          "Recipes",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 16),

                        /// HORIZONTAL LIST
                        SizedBox(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: provider.categoryrecipe.length,
                            itemBuilder: (context, index) {
                              final recipe =
                              provider.categoryrecipe[index];

                              return Padding(
                                padding:
                                const EdgeInsets.only(right: 15),
                                child: SizedBox(
                                  width: 160,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              RecipeDetailsScreen(
                                                  recipe: recipe),
                                        ),
                                      );
                                    },
                                    child: RecipeCard(
                                      image: recipe.image,
                                      rating:
                                      recipe.rating.toString(),
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

                        const Text(
                          "Recipes of The Week",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// VERTICAL LIST
                        ListView.builder(
                          shrinkWrap: true,
                          physics:
                          const NeverScrollableScrollPhysics(),
                          itemCount: provider.categoryrecipe.length,
                          itemBuilder: (context, index) {
                            return WeeklyRecipeTile(
                              recipe:
                              provider.categoryrecipe[index],
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}