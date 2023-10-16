import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:realmen_customer_application/screens/booking/booking_screen.dart';
import 'package:realmen_customer_application/screens/home/home_screen.dart';
import 'package:realmen_customer_application/screens/membership/membership_screen.dart';
import 'package:realmen_customer_application/screens/profile/profile_screen.dart';
import 'package:realmen_customer_application/screens/service_price_list/service_price_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
  static const String MainScreenRoute = "/main-screen";
}

class _MainScreenState extends State<MainScreen> {
  int bottomIndex = 1;
  List<Widget> pages = const [
    HomeScreen(),
    ServicePriceListScreen(),
    MembershipScreen(),
    BookingScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[bottomIndex],
      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.white,
        backgroundColor: Colors.black87,
        items: const [
          CurvedNavigationBarItem(
            child: Icon(Icons.home_outlined),
            label: 'Trang chủ',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.list_alt),
            label: 'Bảng giá',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.calendar_month),
            label: 'Đặt lịch',
          ),
          CurvedNavigationBarItem(
            // child: Icon(Icons.newspaper),
            child: Icon(CommunityMaterialIcons.crown),
            label: 'RM Member',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.perm_identity),
            label: 'Tài khoản',
          ),
        ],
        onTap: (value) {
          setState(() {
            bottomIndex = value;
          });
        },
      ),
    );
  }
}
