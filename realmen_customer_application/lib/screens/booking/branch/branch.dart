import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/screens/booking/booking_haircut_temporary.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_branch/branch_booking_choose.dart';
import 'package:realmen_customer_application/screens/booking/components/on_off_switch.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_service/service_booking_choose.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_stylist_date_time/stylist_date_time_booking_choose.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_stylist_date_time/time-slot/time_slot.dart';
import 'package:realmen_customer_application/screens/message/success_screen.dart';
import 'package:sizer/sizer.dart';
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
    super.build(context);
    return SingleChildScrollView(
        child: Column(
      children: [
        // 1
        ChooseBranchBooking(onBranchSelected: updateSelectedBranch),

        // 2
        selectedBranch != null
            ? ChooseServiceBooking(onServiceSelected: updateSelectedService)
            : Container(),

        // 3
        selectedBranch != null && selectedService != null
            ? ChooseStylistAndDateTimeBooking(
                onDateSelected: updateSelectedDate,
                onTimeSelected: updateSelectedTime,
                onStylistSelected: updateSelectedStylist)
            : Container(),

        // button Đặt Lịch
        selectedService != null
            ? Container(
                width: 81.w,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                padding: const EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.amber,
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
                    if (selectedBranch == null) {
                      print("Xin chọn chi nhánh");
                    } else if (selectedService == null) {
                      print("Xin chọn dịch vụ");
                    } else if (selectedDate == null) {
                      print("Xin chọn ngày");
                    } else if (selectedTime == null) {
                      print("Xin chọn giờ");
                    } else {
                      Get.toNamed(
                          BookingHaircutTemporary
                              .BookingHaircutTemporaryScreenRoute,
                          arguments: {
                            'branch': selectedBranch,
                            'service': selectedService,
                            'stylist': selectedStylist,
                            'date': selectedDate,
                            'time': selectedTime,
                          });
                    }
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
              )
            : Container(),

        const SizedBox(
          height: 20,
        ),
      ],
    ));
  }

  @override
  bool get wantKeepAlive => true;
  dynamic selectedBranch;
  dynamic selectedService;
  dynamic selectedStylist;
  dynamic selectedDate;
  dynamic selectedTime;

  void updateSelectedBranch(dynamic branch) {
    if (!_isDisposed) {
      setState(() {
        selectedBranch = branch;
        print(selectedBranch);
      });
    }
  }

  void updateSelectedStylist(dynamic stylist) {
    if (!_isDisposed) {
      setState(() {
        selectedStylist = stylist;
        print(selectedStylist);
      });
    }
  }

  void updateSelectedService(dynamic service) {
    if (!_isDisposed) {
      setState(() {
        selectedService = service;
        print(selectedService);
      });
    }
  }

  void updateSelectedDate(dynamic date) {
    if (!_isDisposed) {
      setState(() {
        selectedDate = date;
        print(selectedDate);
      });
    }
  }

  void updateSelectedTime(dynamic time) {
    if (!_isDisposed) {
      setState(() {
        selectedTime = time;
        print(selectedTime);
      });
    }
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getDate();
    print(selectedDate);
  }

  getDate() {
    DateTime now = DateTime.now();
    if (!_isDisposed) {
      setState(() {
        selectedDate = formatDate(now.add(Duration(days: 0)));
      });
    }
  }

  formatDate(DateTime date) {
    String day = DateFormat('EEEE').format(date);
    day = formatDay(day);
    return "$day, ${DateFormat('dd/MM/yyyy').format(date)}";
  }

  String formatDay(String day) {
    return dayNames[day.toLowerCase()] ?? day;
  }

  final Map<String, String> dayNames = {
    'monday': 'Thứ hai',
    'tuesday': 'Thứ ba',
    'wednesday': 'Thứ tư',
    'thursday': 'Thứ năm',
    'friday': 'Thứ sáu',
    'saturday': 'Thứ bảy',
    'sunday': 'Chủ nhật'
  };
}
