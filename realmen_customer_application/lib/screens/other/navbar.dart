import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/screens/home/home_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey.shade800,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "Username",
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: const Text("Email@gmail.com",
                style: TextStyle(color: Colors.white)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/images/admin.png",
                  fit: BoxFit.cover,
                  height: 80,
                ),
              ),
            ),
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
          ListTile(
            leading: const Icon(
              Icons.music_note,
              color: Colors.white,
            ),
            title: const Text(
              "Bài hát",
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Get.toNamed(HomeScreen.HomeScreenRoute);
            },
          ),
          const ListTile(
            leading: Icon(
              Icons.music_note,
              color: Colors.white,
            ),
            title: Text(
              "Bài hát",
              style: TextStyle(color: Colors.white),
            ),
            // onTap:,
          ),
          Divider(
            color: Colors.grey.shade700,
          ),
          const ListTile(
            leading: Icon(
              Icons.music_note,
              color: Colors.white,
            ),
            title: Text(
              "Bài hát",
              style: TextStyle(color: Colors.white),
            ),
            // onTap:,
          ),
          const ListTile(
            leading: Icon(
              Icons.music_note,
              color: Colors.white,
            ),
            title: Text(
              "Bài hát",
              style: TextStyle(color: Colors.white),
            ),
            // onTap:,
          ),
          const ListTile(
            leading: Icon(
              Icons.music_note,
              color: Colors.white,
            ),
            title: Text(
              "Bài hát",
              style: TextStyle(color: Colors.white),
            ),
            // onTap:,
          ),
        ],
      ),
    );
  }
}
