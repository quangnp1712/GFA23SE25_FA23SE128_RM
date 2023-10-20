import 'package:flutter/material.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});
  static const String PopularScreenRoute = "/popular-screen";
  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.count(
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(5),
      crossAxisSpacing: 2,
      childAspectRatio: 2 / 2.2,
      children: [
        SizedBox(
          child: Column(
            children: [
              Image.asset(
                "assets/images/nhac_tre.jpg",
                fit: BoxFit.cover,
                height: 200,
              ),
              const SizedBox(
                height: 5,
              ),
              const Center(child: Text("Nhac Tre"))
            ],
          ),
        ),
        SizedBox(
          child: Column(
            children: [
              Image.asset(
                "assets/images/zingchart.jpg",
                fit: BoxFit.cover,
                height: 200,
              ),
              const SizedBox(
                height: 5,
              ),
              const Center(child: Text("ZingChart"))
            ],
          ),
        ),
        SizedBox(
          child: Column(
            children: [
              Image.asset(
                "assets/images/nhac_tre.jpg",
                fit: BoxFit.cover,
                height: 200,
              ),
              const SizedBox(
                height: 5,
              ),
              const Center(child: Text("Nhac Tre"))
            ],
          ),
        ),
        SizedBox(
          child: Column(
            children: [
              Image.asset(
                "assets/images/zingchart.jpg",
                fit: BoxFit.cover,
                height: 200,
              ),
              const SizedBox(
                height: 5,
              ),
              const Center(child: Text("ZingChart"))
            ],
          ),
        ),
      ],
    ));
  }
}
