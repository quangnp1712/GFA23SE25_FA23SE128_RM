import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_service/choose_service_screen.dart';
import 'package:realmen_customer_application/service/change_notifier_provider/change_notifier_provider_service.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ChooseServiceBooking extends StatefulWidget {
  const ChooseServiceBooking({
    super.key,
  });

  @override
  State<ChooseServiceBooking> createState() => _ChooseServiceBookingState();
}

class _ChooseServiceBookingState extends State<ChooseServiceBooking> {
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      // false la hien thanh

      isLast: false,

      beforeLineStyle: isActived
          ? const LineStyle(color: Colors.black, thickness: 2)
          : const LineStyle(color: Colors.grey, thickness: 2),

      // icon
      indicatorStyle: IndicatorStyle(
        color: Colors.transparent,
        width: 35,
        height: 40,
        padding: const EdgeInsets.only(top: 4, bottom: 4, right: 5),
        indicator: Image.asset('assets/images/logo-no-text.png'),
        indicatorXY: 0.0,
      ),

      // content
      endChild: Container(
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
                  List<String>? selectedServices = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<ChangeNotifierServices>.value(
                        value: selectedServicesProvider,
                        child: ChooseServiceBookingScreen(),
                      ),
                    ),
                  );

                  // Handle the selected services here
                  if (selectedServices != null) {
                    setState(() {
                      // Update your UI or perform other actions with selectedServices
                      hasSelectedServices = selectedServices.isNotEmpty;
                      if (hasSelectedServices) {
                        textContainers = selectedServices.map((service) {
                          return Container(
                            child: Text(
                              service,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          );
                        }).toList();
                      }
                      // Update the button text
                      buttonText = hasSelectedServices
                          ? 'Đã chọn ${selectedServices.length} dịch vụ'
                          : 'Xem tất cả danh sách dịch vụ';
                    });
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
}
