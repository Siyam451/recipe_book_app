import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipebookapp/presentation/screens/profile/widgets/profile_header.dart';
import 'package:recipebookapp/presentation/screens/profile/widgets/section_card.dart';
import '../../common/provider/theme_provider.dart';
import 'models/profile_item_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProfileItem> section1 = [
      ProfileItem(
        title: "About Foody",
        subtitle: "Active Bids, In Progress, Orders",
        icon: Icons.fastfood,
      ),
      ProfileItem(
        title: "Language & Settings",
        subtitle: "Active Asks, Sales, Seller Profile",
        icon: Icons.language,
      ),
      ProfileItem(
        title: "Favorites",
        subtitle: "Items and Lists You've Saved",
        icon: Icons.favorite,
      ),
      ProfileItem(
        title: "Settings",
        subtitle: "Security And Notifications",
        icon: Icons.settings,
      ),
    ];

    final List<ProfileItem> section2 = [
      ProfileItem(
        title: "FAQ",
        subtitle: "Payments, Payout, Gift Cards, Credits",
        icon: Icons.info,
      ),
      ProfileItem(
        title: "Terms of Use",
        subtitle: "Security And Notifications",
        icon: Icons.description,
      ),
      ProfileItem(
        title: "Privacy Policy",
        subtitle: "Security And Notifications",
        icon: Icons.lock,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ProfileHeader(),
          const SizedBox(height: 16),
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Card(
                child: SwitchListTile(
                  secondary: const Icon(Icons.dark_mode),
                  title: const Text("Dark Mode"),
                  subtitle: const Text("Enable dark theme"),
                  value: themeProvider.isDark,
                  onChanged: (value) {
                    themeProvider.toggleTheme(value);
                  },
                ),
              );
            },
          ),
          SectionCard(items: section1),
          const SizedBox(height: 16),
          SectionCard(items: section2),
        ],
      ),
    );
  }
}