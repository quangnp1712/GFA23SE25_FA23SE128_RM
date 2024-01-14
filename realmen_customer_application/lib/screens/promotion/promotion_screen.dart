// ignore_for_file: must_be_immutable, constant_identifier_names

import 'package:flutter/material.dart';

class PromotionScreen extends StatefulWidget {
  Function callback;
  PromotionScreen(this.callback, {super.key});
  @override
  State<PromotionScreen> createState() => _PromotionScreenState();
  static const String PromotionScreenRoute = "/pormotion-screen";
}

class _PromotionScreenState extends State<PromotionScreen> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: Scaffold());
  }
}
