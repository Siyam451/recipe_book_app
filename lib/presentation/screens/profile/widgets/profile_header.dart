import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
            "https://i.pravatar.cc/150?img=3",
          ),
        ),
        title: const Text("Billy Hanson"),
        subtitle: const Text("torri_greene@gmail.com"),
        trailing: const Icon(Icons.person_outline),
      ),
    );
  }
}