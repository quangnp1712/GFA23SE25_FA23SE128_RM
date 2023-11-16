import 'package:flutter/material.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_branch/branch_booking_choose.dart';
import 'package:realmen_customer_application/screens/booking/components/on_off_switch.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_service/service_booking_choose.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_stylist_date_time/stylist_date_time_booking_choose.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_stylist_date_time/time-slot/time_slot.dart';
import 'package:timeline_tile/timeline_tile.dart';

class BranchOptionBooking extends StatefulWidget {
  const BranchOptionBooking({super.key});

  @override
  State<BranchOptionBooking> createState() => _BranchOptionBookingState();
}

class _BranchOptionBookingState extends State<BranchOptionBooking>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        // 1
        const ChooseBranchBooking(),

        // 2
        const ChooseServiceBooking(),

        // 3
        const ChooseStylistAndDateTimeBooking(),

        // button Đặt Lịch
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xff302E2E),
                  Color(0xe6444141),
                  Color(0x8c484646),
                  Color(0x26444141),
                ]),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            onPressed: () {
              // Xử lý chuyển trang khi nhấn nút
              // Navigator.push(context, MaterialPageRoute(builder: (context) => YourNextScreen()));
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black12,
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              minimumSize: const Size(200, 50),
              padding: const EdgeInsets.all(0),
              shadowColor: Colors.transparent,
            ),
            child: const Text(
              'Đặt Lịch',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),

        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
