import 'package:flutter/material.dart';

class ServicePriceListScreen extends StatefulWidget {
  const ServicePriceListScreen({super.key});

  @override
  State<ServicePriceListScreen> createState() => _ServicePriceListScreenState();
  static const String ServicePriceListScreenRoute =
      "/service-price-list-screen";
}

class _ServicePriceListScreenState extends State<ServicePriceListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("SERVICE PRICE LIST SCREEN"),
      ),
    );
  }
}
