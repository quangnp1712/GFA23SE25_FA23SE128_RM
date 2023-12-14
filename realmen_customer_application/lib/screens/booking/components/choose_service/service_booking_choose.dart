import 'dart:convert';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:realmen_customer_application/models/branch/branch_model.dart';
import 'package:realmen_customer_application/screens/booking/booking_processing.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_service/choose_service_screen.dart';
import 'package:realmen_customer_application/service/change_notifier_provider/change_notifier_provider_service.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ChooseServiceBooking extends StatefulWidget {
  final void Function(dynamic service) onServiceSelected;
  final List<BranchServiceModel> branchServiceList;
  const ChooseServiceBooking({
    super.key,
    required this.onServiceSelected,
    required this.branchServiceList,
  });

  @override
  State<ChooseServiceBooking> createState() => _ChooseServiceBookingState();
}

class _ChooseServiceBookingState extends State<ChooseServiceBooking> {
  List<String>? servicesList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 15),
      constraints: const BoxConstraints(minHeight: 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "2. Chọn dịch vụ ",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: ElevatedButton(
              onPressed: () async {
                if (!_isDisposed && mounted) {
                  // List<String>? selectedServices = await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ChangeNotifierProvider<
                  //         ChangeNotifierServices>.value(
                  //       value: selectedServicesProvider,
                  //       child: ChooseServiceBookingScreen(),
                  //     ),
                  //   ),
                  // );
                  List<String> _servicesList = List<String>.from(servicesList!);
                  List<String>? selectedServices = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChooseServiceBookingScreen(
                          selectedServices: _servicesList,
                          branchServiceList: widget.branchServiceList),
                    ),
                  );

                  // Handle the selected services here
                  if (selectedServices != null) {
                    setState(() {
                      _getTextContainers(selectedServices);
                      servicesList = selectedServices;
                    });
                    widget.onServiceSelected(selectedServices);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: Colors.grey,
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  padding: const EdgeInsets.only(right: 0, left: 10)),
              child: Container(
                // color: Colors.amber,
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: [
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.cut,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                buttonText,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Align(
                        alignment: Alignment.centerRight,
                        child: Icon(Icons.arrow_right, color: Colors.black))
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            children: hasSelectedServices ? textContainers : [],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  String buttonText = 'Xem tất cả danh sách dịch vụ'; // giữ
  bool hasSelectedServices = false; // giữ
  List<Widget> textContainers = []; // giữ
  ChangeNotifierServices selectedServicesProvider =
      ChangeNotifierServices(); // giữ
  @override // giữ
  void initState() {
    super.initState();
    hasSelectedServices = textContainers.isNotEmpty;
  }

  int _index = 0;
  bool isActived = false;
  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  _getTextContainers(List<String> selectedServices) {
// Update your UI or perform other actions with selectedServices
    hasSelectedServices = selectedServices.isNotEmpty;
    if (hasSelectedServices) {
      textContainers = selectedServices.map((service) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            utf8.decode(service.toString().runes.toList()),
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        );
      }).toList();
    }
    // Update the button text
    buttonText = hasSelectedServices
        ? 'Đã chọn ${selectedServices.length} dịch vụ'
        : 'Xem tất cả danh sách dịch vụ';
  }
}
