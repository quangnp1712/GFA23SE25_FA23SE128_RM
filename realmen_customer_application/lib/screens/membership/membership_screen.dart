import 'package:flutter/material.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
  static const String MembershipScreenRoute = "/membership-screen";
}

class _MembershipScreenState extends State<MembershipScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("MEMBER SHIP SCREEN"),
      ),
    );
  }
}
