import 'package:flutter/material.dart';

class ChangeNotifierServices extends ChangeNotifier {
  List<String> _selectedServices = [];
  String _selectedBranch = "";

  List<String> get selectedServices => _selectedServices;
  String get selectedBranch => _selectedBranch;

  void updateSelectedServices(List<String> services) {
    _selectedServices = services;
    notifyListeners();
  }

  void updateSelectedBranch(String branch) {
    _selectedBranch = branch;
    notifyListeners();
  }
}
