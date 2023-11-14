import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_branch/choose_branch_screen.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ChooseBranchBooking extends StatefulWidget {
  const ChooseBranchBooking({
    super.key,
  });

  @override
  State<ChooseBranchBooking> createState() => _ChooseBranchBookingState();
}

class _ChooseBranchBookingState extends State<ChooseBranchBooking> {
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
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
          // mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "1. Chọn chi nhánh ",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(ChooseBranchesScreen.ChooseBranchesScreenRoute);
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
                                CommunityMaterialIcons.storefront,
                                color: Colors.black,
                                size: 24,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              child: const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Xem tất cả chi nhánh REALMEN",
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
          ],
        ),
      ),
    );
  }

  // Logic
  @override
  void initState() {
    super.initState();
  }

  int _index = 0;
  bool isActived = true;
}
