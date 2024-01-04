// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, avoid_print

import 'package:flutter/material.dart';
import 'package:realmen_customer_application/models/account/account_info_model.dart';

import 'package:realmen_customer_application/screens/booking/components/choose_stylist_date_time/time-slot/time_slot.dart';
// ignore: unused_import
import 'package:realmen_customer_application/screens/booking/components/on_off_switch.dart';

import 'stylist/choose_stylist.dart';

class ChooseStylistAndDateTimeBooking extends StatefulWidget {
  final void Function(AccountInfoModel? stylist) onStylistSelected;
  final void Function(dynamic date) onDateSelected;
  final void Function(dynamic time) onTimeSelected;
  List<AccountInfoModel>? accountStaffList;
  ChooseStylistAndDateTimeBooking({
    super.key,
    required this.onStylistSelected,
    required this.onDateSelected,
    required this.onTimeSelected,
    this.accountStaffList,
  });

  @override
  State<ChooseStylistAndDateTimeBooking> createState() =>
      _ChooseStylistAndDateTimeBookingState();
}

class _ChooseStylistAndDateTimeBookingState
    extends State<ChooseStylistAndDateTimeBooking> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
          ChooseStylist(
              onStylistSelected: widget.onStylistSelected,
              accountStaffList: widget.accountStaffList,
              updateSelectedStylist: updateSelectedStylist),
          ChooseDateAndTimeSlot(
              onDateSelected: widget.onDateSelected,
              onTimeSelected: widget.onTimeSelected,
              stylistSelected: stylistSelected,
              isChangeStylist: isChangeStylist),
          const SizedBox(height: 20),
          // Container(
          //   child: Padding(
          //     padding: const EdgeInsets.all(0),
          //     child: Column(
          //       children: [
          //         const SizedBox(height: 10),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           crossAxisAlignment: CrossAxisAlignment.end,
          //           children: [
          //             const Row(
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: [
          //                 Icon(
          //                   Icons.person,
          //                   size: 24,
          //                 ),
          //                 SizedBox(
          //                   width: 10,
          //                 ),
          //                 Text(
          //                   "Chụp Hình Sau Khi Cắt",
          //                   textAlign: TextAlign.start,
          //                   style: TextStyle(
          //                     fontSize: 17,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //             OnOffSwitch(
          //               initialValue: isSwitched2,
          //               onChanged: (value) {
          //                 setState(() {
          //                   isSwitched2 = value;
          //                 });
          //               },
          //             ),
          //           ],
          //         ),
          //         const SizedBox(
          //           height: 6,
          //         ),
          //         isSwitched2
          //             ? const Text(
          //                 "Anh cho phép các em chụp hình lưu lại kiểu tóc, để lần sau không phải mô tả lại cho thợ khác.",
          //                 style: TextStyle(fontSize: 14),
          //               )
          //             : const Text(
          //                 "Anh không cho phép các em chụp hình lưu lại kiểu tóc.",
          //                 style: TextStyle(fontSize: 14),
          //               ),
          //         const SizedBox(
          //           height: 15,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  bool isActived = false;
  bool isSwitched1 = true;
  bool isSwitched2 = true;

// Lấy staff cho time slot
  AccountInfoModel? stylistSelected = AccountInfoModel();
  @override
  void initState() {
    super.initState();
    stylistSelected;
    _validateWorkDateStylist();
  }

  _validateWorkDateStylist() {
    if (widget.accountStaffList != null) {
      widget.accountStaffList = widget.accountStaffList!.where((staff) {
        DateTime now = DateTime.now();
        List<dynamic> listDate = [];
        if (staff.staff!.scheduleList == null ||
            staff.staff!.scheduleList!.isEmpty) {
          return false;
        } else {
          staff.staff!.scheduleList!.asMap().entries.map((schedule) {
            if (DateTime.parse(schedule.value.workingDate!) ==
                    DateTime(now.year, now.month, now.day, 0) ||
                (DateTime.parse(schedule.value.workingDate!).isAfter(now) &&
                    DateTime.parse(schedule.value.workingDate!)
                        .isBefore(now.add(const Duration(days: 4))))) {
              listDate.add(schedule.value);
            }
          }).toList();
          if (listDate.isNotEmpty) {
            return true;
          } else {
            return false;
          }
        }
      }).toList();
      setState(() {
        widget.accountStaffList;
      });
    }
  }

  @override
  void didUpdateWidget(ChooseStylistAndDateTimeBooking oldWidget) {
    isChangeStylist = false;
    _validateWorkDateStylist();
    super.didUpdateWidget(oldWidget);
  }

  bool isChangeStylist = false;
  void updateSelectedStylist(AccountInfoModel? stylistSelected) {
    setState(() {
      this.stylistSelected = stylistSelected;
      isChangeStylist = true;
      print(isChangeStylist);
    });
  }
}
