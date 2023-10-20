import 'package:flutter/material.dart';
import 'package:realmen_customer_application/screens/other/navbar.dart';
import 'package:realmen_customer_application/screens/other/tabbar.dart';
import 'package:realmen_customer_application/screens/other/tabbar_view.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
  static const String NavBarScreenRoute = "/navbar-screen";
}

class _NavBarScreenState extends State<NavBarScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 6,
      child: Scaffold(
        drawer: const NavBar(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Hợp Âm Chuẩn',
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
          bottom: const BottomTapBar(),
        ),
        body: const BodyTabBarView(),
      ),
    );
  }
}
