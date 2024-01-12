// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:realmen_customer_application/models/account/account_info_model.dart';
import 'package:realmen_customer_application/models/account/staff_model.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_stylist_date_time/time-slot/time_slot.dart';
import 'package:realmen_customer_application/screens/booking/components/on_off_switch.dart';

class ChooseTimeSlot extends StatefulWidget {
  final void Function(dynamic date) onDateSelected;
  final void Function(dynamic time) onTimeSelected;
  final AccountInfoModel? selectedStylist;
  final bool? isChangeStylist;
  const ChooseTimeSlot({
    super.key,
    required this.onDateSelected,
    required this.onTimeSelected,
    this.selectedStylist,
    this.isChangeStylist,
  });

  @override
  State<ChooseTimeSlot> createState() => _ChooseTimeSlotState();
}

class _ChooseTimeSlotState extends State<ChooseTimeSlot> {
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
            "3. Chọn ngày, giờ ",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          ChooseDateAndTimeSlot(
              onDateSelected: widget.onDateSelected,
              onTimeSelected: widget.onTimeSelected,
              stylistSelected: widget.selectedStylist,
              isChangeStylist: widget.isChangeStylist),
          const SizedBox(
            height: 20,
          ),
          //
        ],
      ),
    );
  }
}
