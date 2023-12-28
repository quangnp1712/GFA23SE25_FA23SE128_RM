import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/models/account/account_info_model.dart';
import 'package:realmen_customer_application/models/branch/branch_model.dart';
import 'package:realmen_customer_application/screens/booking/booking_haircut_temporary.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_service/service_booking_choose.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_stylist_branch/stylist_branch.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_time_slot/time_slot.dart';
import 'package:realmen_customer_application/screens/booking/components/on_off_switch.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_stylist_date_time/time-slot/time_slot.dart';
import 'package:realmen_customer_application/screens/message/success_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StylistOptionBooking extends StatefulWidget {
  const StylistOptionBooking({super.key});

  @override
  State<StylistOptionBooking> createState() => _StylistOptionBookingState();
}

class _StylistOptionBookingState extends State<StylistOptionBooking>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
        child: Column(
      children: [
        // 1
        ChooseStylistAndBranch(
            onBranchSelected: updateSelectedBranch,
            onStylistSelected: updateSelectedStylist),

        // 2

        TimelineTile(
          // false la hien thanh

          isLast: false,
          beforeLineStyle: const LineStyle(color: Colors.black, thickness: 2),

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
          endChild: selectedBranch.branchId != null
              ? (selectedBranch.branchServiceList != null &&
                      selectedBranch.branchServiceList!.length > 0
                  ? ChooseServiceBooking(
                      onServiceSelected: updateSelectedService,
                      branchServiceList: selectedBranch!.branchServiceList!,
                      isUpdateBranch: isChangeStylist)
                  : Container(
                      height: 150,
                      padding: const EdgeInsets.only(top: 10, right: 15),
                      constraints: const BoxConstraints(minHeight: 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "2. Chọn dịch vụ ",
                            style: TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text("Chi nhánh hiện chưa có dịch vụ."),
                          ),
                          Center(
                            child: Text(
                                "Quý khách hành vui lòng chọn Stylist khác!"),
                          ),
                        ],
                      ),
                    ))
              : Container(
                  height: 150,
                  padding: const EdgeInsets.only(top: 10, right: 15),
                  constraints: const BoxConstraints(minHeight: 120),
                  child: Text(
                    "2. Chọn dịch vụ ",
                    style: TextStyle(fontSize: 20),
                  )),
        ),
        // 3

        TimelineTile(
          // false la hien thanh

          isLast: false,
          beforeLineStyle: const LineStyle(color: Colors.black, thickness: 2),

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
          endChild: selectedBranch.branchId != null &&
                  selectedService.isNotEmpty &&
                  selectedBranch.branchServiceList != null &&
                  selectedBranch.branchServiceList!.isNotEmpty
              ? ChooseTimeSlot(
                  onDateSelected: updateSelectedDate,
                  onTimeSelected: updateSelectedTime,
                  selectedStylist: selectedStylist,
                )
              : Container(
                  height: 150,
                  padding: const EdgeInsets.only(top: 10, right: 15),
                  constraints: const BoxConstraints(minHeight: 120),
                  child: Text(
                    "3. Chọn ngày, giờ ",
                    style: TextStyle(fontSize: 20),
                  )),
        ),
        // button Đặt Lịch
        selectedBranch.branchId != null &&
                selectedStylist.accountId != null &&
                selectedService != null &&
                selectedService != []
            ? Container(
                width: 81.w,
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
                    _onBooking();
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
        )
      ],
    ));
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

  @override
  bool get wantKeepAlive => true;
  BranchModel selectedBranch = BranchModel();
  List<BranchServiceModel> selectedService = [];
  AccountInfoModel selectedStylist = AccountInfoModel();
  dynamic selectedDate;
  dynamic selectedTime;

  bool isChangeStylist = false;
  void updateSelectedBranch(dynamic branch) {
    setState(() {
      selectedBranch = branch;
      print(selectedBranch);
    });
  }

  void updateSelectedStylist(dynamic stylist) {
    setState(() {
      selectedStylist = stylist;
      selectedService = [];
      isChangeStylist = true;
    });
  }

  void updateSelectedService(List<BranchServiceModel> service) {
    setState(() {
      selectedService = service;
      isChangeStylist = false;
      print(selectedService);
    });
  }

  void updateSelectedDate(dynamic date) {
    setState(() {
      selectedDate = date;
      print(selectedDate);
    });
  }

  void updateSelectedTime(dynamic time) {
    setState(() {
      selectedTime = time;
      print(selectedTime);
    });
  }

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

  _onBooking() {
    if (selectedBranch.branchId == null) {
      _errorMessage("Xin chọn lại Stylist");
    } else if (selectedStylist.accountId == null) {
      _errorMessage("Xin chọn lại Stylist");
    } else if (selectedService == []) {
      _errorMessage("Xin chọn dịch vụ");
    } else if (selectedDate == null) {
      _errorMessage("Xin chọn ngày");
    } else if (selectedTime == null) {
      _errorMessage("Xin chọn giờ");
    } else {
      Get.toNamed(BookingHaircutTemporary.BookingHaircutTemporaryScreenRoute,
          arguments: {
            'branch': selectedBranch, // String name
            'service': selectedService, // List <String> name
            'stylist': selectedStylist, // String name
            'date': selectedDate, // String
            'time': selectedTime, // String
          });
    }
  }
}
