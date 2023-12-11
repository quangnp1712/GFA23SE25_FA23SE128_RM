import 'package:flutter/material.dart';
import 'package:realmen_customer_application/models/branch/branch_model.dart';

class ChangeNotifierServices extends ChangeNotifier {
  List<String> _selectedServices = [];
  dynamic _selectedBranch;
  dynamic _selectedStylist;

  List<String> get selectedServices => _selectedServices;
  BranchModel get selectedBranch => _selectedBranch;
  dynamic get selectedStylist => _selectedStylist;

  void updateSelectedServices(List<String> services) {
    _selectedServices = services;
    notifyListeners();
  }

  void updateSelectedBranch(BranchModel? branch) {
    _selectedBranch = branch;
    notifyListeners();
  }

  void updateSelectedStylist(dynamic stylist) {
    _selectedStylist = stylist;
    notifyListeners();
  }
}
