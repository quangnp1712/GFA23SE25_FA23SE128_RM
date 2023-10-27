import 'package:flutter/material.dart';

class BookingScreen extends StatefulWidget {
  Function callback;
  BookingScreen(this.callback, {super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
  static const String BookingScreenRoute = "/booking-screen";
}

class _BookingScreenState extends State<BookingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("BOOKING SCREEN"),
      ),
    );
  }
}
