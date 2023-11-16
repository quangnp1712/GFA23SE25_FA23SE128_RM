import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:realmen_customer_application/screens/booking/components/on_off_switch.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_stylist_date_time/time-slot/time_slot.dart';

import 'stylist/choose_stylist.dart';

class ChooseStylistAndDateTimeBooking extends StatefulWidget {
  const ChooseStylistAndDateTimeBooking({
    super.key,
  });

  @override
  State<ChooseStylistAndDateTimeBooking> createState() =>
      _ChooseStylistAndDateTimeBookingState();
}

class _ChooseStylistAndDateTimeBookingState
    extends State<ChooseStylistAndDateTimeBooking> {
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
              "3. Chọn stylist & ngày, giờ ",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            ChooseStylist(),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                padding: const EdgeInsets.only(
                    left: 10, right: 0, top: 5, bottom: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 1.5),
                      blurRadius: 1,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: const Icon(
                            Icons.calendar_today,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              alignment: Alignment.center,
                              value: dateController,
                              items: listDate != null
                                  ? listDate
                                      ?.map(
                                        (item) => DropdownMenuItem(
                                          value: item['date'],
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 5, left: 0),
                                            // width: 220,
                                            // height: 40,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 10.0),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          item['date']
                                                              as String,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                item['type'] == "Ngày thường"
                                                    ? Container(
                                                        width: 100,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 5,
                                                                vertical: 5),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0xff207A20),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            "Ngày thường",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        width: 100,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 5,
                                                                vertical: 5),
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              Color(0xff964444),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            "Cuối tuần",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList()
                                  : [],
                              onChanged: (value) {
                                setState(() {
                                  dateController = value as String?;
                                  type = value
                                      .toString()
                                      .substring(
                                          0, value.toString().indexOf(","))
                                      .toString();
                                  type == "Thứ bảy" || type == "Chủ nhật"
                                      ? type = "Cuối tuần"
                                      : type = "Ngày thường";
                                });
                              },
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: 200,
                                width: 325,
                                padding: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  // borderRadius: BorderRadius.circular(14),
                                  color: Colors.grey.shade200,
                                ),
                                offset: const Offset(-35, -6),
                                scrollbarTheme: ScrollbarThemeData(
                                  // radius: const Radius.circular(40),
                                  // thickness: MaterialStateProperty.all(6),
                                  thumbVisibility:
                                      MaterialStateProperty.all(true),
                                ),
                              ),
                              menuItemStyleData: const MenuItemStyleData(
                                height: 40,
                                padding: EdgeInsets.only(left: 35, right: 24),
                              ),
                              buttonStyleData: const ButtonStyleData(
                                padding: EdgeInsets.all(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              child: TimeSlot(type: type),
            ),
            const SizedBox(height: 10),
            Container(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.person,
                          size: 16,
                        ),
                        const Text(
                          "Yêu Cầu Tư Vấn",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 50),
                        OnOffSwitch(),
                      ],
                    ),
                    const Text(
                      "Anh không cho phép các em giới thiệu về chương trình khuyến mãi, dịch vụ tốt nhất dành cho anh.",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.person,
                          size: 16,
                        ),
                        const Text(
                          "Chụp Hình Sau Khi Cắt",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 20),
                        OnOffSwitch(),
                      ],
                    ),
                    const Text(
                      "Anh cho phép các em chụp hình lưu lại kiểu tóc, để lần sau không phải mô tả lại cho thợ khác.",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
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

    getDate();
    dateController = listDate?.first?['date'].toString();
  }

  int _index = 0;
  bool isActived = false;
  String? dateController;
  String type = "Ngày thường";
  List<Map<String, dynamic>>? listDate = [];

  getDate() {
    DateTime now = DateTime.now();
    for (int i = 0; i <= 5; i++) {
      listDate?.add({
        'date': formatDate(now.add(Duration(days: i)))['date'],
        'type': formatDate(now.add(Duration(days: i)))['type'],
      });
    }
  }

  Map<String, dynamic> formatDate(DateTime date) {
    String day = DateFormat('EEEE').format(date);
    day = formatDay(day);
    return {
      'date': "$day, ${DateFormat('dd/MM/yyyy').format(date)}",
      'type':
          day == "Thứ bảy" || day == "Chủ nhật" ? "Cuối tuần" : "Ngày thường"
    };
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
