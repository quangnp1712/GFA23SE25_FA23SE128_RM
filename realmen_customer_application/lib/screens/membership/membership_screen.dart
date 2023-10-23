import 'package:flutter/material.dart';

class MembershipScreen extends StatefulWidget {
  Function callback;
  MembershipScreen(this.callback);

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
