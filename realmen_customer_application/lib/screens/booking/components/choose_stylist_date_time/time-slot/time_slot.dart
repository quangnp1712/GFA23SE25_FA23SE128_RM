// ignore_for_file: must_be_immutable, avoid_print, unused_local_variable, avoid_unnecessary_containers, library_private_types_in_public_api

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/models/account/account_info_model.dart';

class ChooseDateAndTimeSlot extends StatefulWidget {
  final void Function(dynamic date) onDateSelected;
  final void Function(dynamic time) onTimeSelected;
  final AccountInfoModel? stylistSelected;
  bool? isChangeStylist;

  ChooseDateAndTimeSlot(
      {super.key,
      required this.onDateSelected,
      required this.onTimeSelected,
      required this.stylistSelected,
      this.isChangeStylist});

  @override
  State<ChooseDateAndTimeSlot> createState() => _ChooseDateAndTimeSlotState();
}

class _ChooseDateAndTimeSlotState extends State<ChooseDateAndTimeSlot> {
  @override
  Widget build(BuildContext context) {
    return listDate!.isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                                        ?.asMap()
                                        .entries
                                        .map(
                                          (item) => DropdownMenuItem(
                                            value: item.value['id'],
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
                                                        margin: const EdgeInsets
                                                            .only(left: 10.0),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            item.value['date']
                                                                as String,
                                                            style: const TextStyle(
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
                                                  item.value['type'] ==
                                                          "Ngày thường"
                                                      ? Container(
                                                          width: 100,
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 5,
                                                                  vertical: 5),
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Color(
                                                                0xff207A20),
                                                          ),
                                                          child: const Center(
                                                            child: Text(
                                                              "Ngày thường",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white,
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
                                                            color: Color(
                                                                0xff964444),
                                                          ),
                                                          child: const Center(
                                                            child: Text(
                                                              "Cuối tuần",
                                                              style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .white,
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

                                    dateSeleted = listDate!
                                        .where((date) =>
                                            date['id'] == value.toString())
                                        .toList()
                                        .first;
                                    print("onchange: $dateSeleted");
                                    type = dateSeleted!['type'].toString();
                                    type == "Thứ bảy" || type == "Chủ nhật"
                                        ? type = "Cuối tuần"
                                        : type = "Ngày thường";
                                    isCurrentDate =
                                        _isCurrentDate(dateSeleted!['date']);
                                    widget.onDateSelected(dateSeleted);
                                  });

                                  timeSlotKey.currentState?.rebuildTimeslot();
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
              SizedBox(
                height: 200,
                child: TimeSlot(
                    key: timeSlotKey,
                    dateSeleted: dateSeleted,
                    isCurrentDate: isCurrentDate,
                    onTimeSelected: widget.onTimeSelected,
                    onDateSelected: widget.onDateSelected,
                    stylistSelected: widget.stylistSelected),
              ),
            ],
          )
        : Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                    "Thợ cắt ${utf8.decode(("${widget.stylistSelected!.firstName!.substring(widget.stylistSelected!.firstName!.lastIndexOf(" ") + 1)} ${widget.stylistSelected!.lastName!}").runes.toList())} hiện chưa có lịch làm!"),
              ),
              const Center(
                child: Text("Anh vui lòng chọn thợ cắt khác"),
              )
            ],
          );
  }

  // Logic
  @override
  void initState() {
    super.initState();
    getDate();

    setState(() {
      dateController = listDate?.first['id'].toString();
      dateSeleted = listDate?.first;
      type = listDate!.first['type'].toString();
    });
    // widget.onDateSelected(dateController);
  }

  // ignore: unused_field
  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true; // Đánh dấu widget đã bị dispose
    super.dispose();
  }

  @override
  void didUpdateWidget(ChooseDateAndTimeSlot oldWidget) {
    getDate();
    if (widget.isChangeStylist!) {
      if (listDate!.isNotEmpty) {
        dateController = listDate?.first['id'].toString();
        dateSeleted = listDate?.first;
        print("didUpdateWidget: $dateController");
        type = listDate!.first['type'].toString();
        timeSlotKey.currentState?.rebuildTimeslot();
        setState(() {
          widget.isChangeStylist = false;
          isCurrentDate = _isCurrentDate(dateSeleted!['date']);
        });
      }

      build(context);
    }
    print("didUpdateWidget: $dateSeleted");
    super.didUpdateWidget(oldWidget);
  }

  GlobalKey<_TimeSlotState> timeSlotKey = GlobalKey();
  bool isCurrentDate = true;
  bool isActived = false;
  String? dateController;
  Map<String, dynamic>? dateSeleted;
  String type = "Ngày thường";
  List<Map<String, dynamic>>? listDate = [];

  getDate() {
    DateTime now = DateTime.now();
    listDate = [];
    if (widget.stylistSelected?.staff?.scheduleList == null) {
      for (int i = 0; i <= 4; i++) {
        listDate?.add({
          'id': i.toString(),
          'date': formatDate(now.add(Duration(days: i)))['date'],
          'type': formatDate(now.add(Duration(days: i)))['type'],
        });
      }
    } else {
      try {
        widget.stylistSelected?.staff!.scheduleList!
            .asMap()
            .entries
            .map((schedule) {
          if (DateTime.parse(schedule.value.workingDate!) ==
                  DateTime(now.year, now.month, now.day, 0) ||
              (DateTime.parse(schedule.value.workingDate!).isAfter(now) &&
                  DateTime.parse(schedule.value.workingDate!)
                      .isBefore(now.add(const Duration(days: 4))))) {
            // if (!listDate!.any((date) =>
            //     date['date'] ==
            //     formatDate(
            //         DateTime.parse(schedule.value.workingDate!))['date'])) {
            listDate?.add({
              'id': schedule.key.toString(),
              'date': formatDate(
                  DateTime.parse(schedule.value.workingDate!))['date'],
              'type': formatDate(
                  DateTime.parse(schedule.value.workingDate!))['type'],
              'start': schedule.value.start,
              'end': schedule.value.end
            });
            // }
          }
        }).toList();
        if (!_isDisposed && mounted) {
          setState(() {
            listDate;
          });
        }
      } on Exception catch (e) {
        listDate?.add({
          'date': formatDate(now.add(const Duration(days: 1)))['date'],
          'type': formatDate(now.add(const Duration(days: 1)))['type'],
        });
        print(e.toString());
      }
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

  bool _isCurrentDate(dynamic dateSelected) {
    DateTime now = DateTime.now();
    String? dateNow = formatDate(now.add(const Duration(days: 0)))['date'];
    if (dateSelected.toString() == dateNow) {
      return true;
    } else {
      return false;
    }
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

class TimeSlot extends StatefulWidget {
  const TimeSlot(
      {super.key,
      required this.dateSeleted,
      required this.onTimeSelected,
      required this.onDateSelected,
      required this.isCurrentDate,
      required this.stylistSelected});
  final Map<String, dynamic>? dateSeleted;
  final bool isCurrentDate;
  final void Function(dynamic time) onTimeSelected;
  final void Function(dynamic time) onDateSelected;
  final AccountInfoModel? stylistSelected;

  @override
  _TimeSlotState createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  String _selectedTimeSlot = ''; // Track selected time slot

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(TimeSlot oldWidget) {
    setState(() {
      build(context);
    });

    super.didUpdateWidget(oldWidget);
  }

  void rebuildTimeslot() {
    setState(() {
      _selectedTimeSlot = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              style: BorderStyle.solid,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Giờ hẹn:",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                _selectedTimeSlot,
                style: const TextStyle(fontSize: 23),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Center(
          child: SizedBox(
            width: 230.0,
            height: 220.0, // Limit height

            child: TimeSlotGrid(
                dateSeleted: widget.dateSeleted,
                isCurrentDate: widget.isCurrentDate,
                selectedTimeSlot: _selectedTimeSlot,
                onTimeSlotSelected: _onTimeSlotSelected,
                stylistSelected: widget.stylistSelected),
          ),
        ),
      ],
    );
  }

  void _onTimeSlotSelected(String timeSlot) {
    setState(() {
      if (timeSlot == _selectedTimeSlot) {
        // Deselect the time slot if it's already selected
        _selectedTimeSlot = '';
        widget.onTimeSelected(_selectedTimeSlot);
        widget.onDateSelected(widget.dateSeleted!['date']);
      } else {
        _selectedTimeSlot = timeSlot;
        widget.onTimeSelected(_selectedTimeSlot);
        widget.onDateSelected(widget.dateSeleted!['date']);
      }
    });
  }
}

class TimeSlotGrid extends StatefulWidget {
  final Map<String, dynamic>? dateSeleted;
  final bool isCurrentDate;

  final String selectedTimeSlot;
  final void Function(String timeSlot) onTimeSlotSelected;
  AccountInfoModel? stylistSelected;

  TimeSlotGrid(
      {Key? key,
      required this.dateSeleted,
      required this.isCurrentDate,
      required this.selectedTimeSlot,
      required this.onTimeSlotSelected,
      required this.stylistSelected})
      : super(key: key);

  @override
  State<TimeSlotGrid> createState() => _TimeSlotGridState();
}

class _TimeSlotGridState extends State<TimeSlotGrid> {
  @override
  void initState() {
    super.initState();
    timeSlots = generateTimeSlots();

    Future.delayed(Duration.zero, () {
      // Gọi sau khi build xong
      final now = DateTime.now();
      final formatter = DateFormat('HH:mm');
      final currentTime = formatter.format(now);
      List<int> scrollListIndex = [];
      if (widget.isCurrentDate) {
        for (int i = 0; i < timeSlots.length; i++) {
          final timeSlot = timeSlots[i];
          final isSelectable = timeSlot.compareTo(currentTime) >= 0;
          if (isSelectable) {
            scrollListIndex.add(timeSlots.indexOf(timeSlots[i]));
          }
        }
      } else {
        for (int i = 0; i < timeSlots.length; i++) {
          scrollListIndex.add(timeSlots.indexOf(timeSlots[i]));
        }
      }

      if (scrollListIndex.isNotEmpty) {
        final scrollIndex = scrollListIndex.first;
        scrollToIndex(scrollIndex);
      }
    });
  }

  @override
  void didUpdateWidget(TimeSlotGrid oldWidget) {
    build(context);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm');
    final currentTime = formatter.format(now);

    return GridView.builder(
      scrollDirection: Axis.horizontal,
      controller: scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1 / 1.5),
      itemCount: timeSlots.length,
      itemBuilder: (BuildContext context, int index) {
        final timeSlot = timeSlots[index];
        final isSelected = timeSlot == widget.selectedTimeSlot;

        // kiểm tra được chọn hay không
        // TRUE chọn
        bool isSelectable;
        isSelectable = checkTimeSlotSelected(timeSlot);
        if (widget.isCurrentDate) {
          isSelectable = timeSlot.compareTo(currentTime) >= 0 && isSelectable;
        } else {
          isSelectable;
        }

        return TimeSlotCard(
          dateSeleted: widget.dateSeleted,
          timeSlot: timeSlot,
          isSelected: isSelected,
          isSelectable: isSelectable,
          onSelected: widget.onTimeSlotSelected,
        );
      },
    );
  }

  bool checkTimeSlotSelected(dynamic timeSlot) {
    try {
      if (widget.dateSeleted?['start'] != null &&
          widget.dateSeleted?['end'] != null) {
        final start = timeSlot.compareTo(
                widget.dateSeleted!['start'].toString().substring(0, 5)) >=
            0;
        final end = timeSlot.compareTo(
                widget.dateSeleted!['end'].toString().substring(0, 5)) <=
            0;

        if (timeSlot.compareTo(
                    widget.dateSeleted!['start'].toString().substring(0, 5)) >=
                0 &&
            timeSlot.compareTo(
                    widget.dateSeleted!['end'].toString().substring(0, 5)) <=
                0) {
          return true;
        } else {
          return false;
        }
      } else {
        return true;
      }
      // ignore: unused_catch_clause
    } on Exception catch (e) {
      return false;
    }
  }

  List<String> timeSlots = [];
  ScrollController scrollController = ScrollController();

  void scrollToIndex(int index) {
    scrollController.animateTo((index / 3).floor() * 99,
        duration: const Duration(milliseconds: 1), curve: Curves.easeIn);
  }

  List<String> generateTimeSlots() {
    List<String> timeSlots = [];
    for (int hour = 7; hour <= 23; hour++) {
      for (int minute = 0; minute < 60; minute += 20) {
        final formattedHour = hour.toString().padLeft(2, '0');
        final formattedMinute = minute.toString().padLeft(2, '0');
        timeSlots.add('$formattedHour:$formattedMinute');
      }
    }
    return timeSlots;
  }
}

class TimeSlotCard extends StatefulWidget {
  final String timeSlot;
  final Map<String, dynamic>? dateSeleted;
  final bool isSelected;
  final bool isSelectable;
  final void Function(String timeSlot) onSelected;

  const TimeSlotCard(
      {super.key,
      required this.timeSlot,
      required this.isSelected,
      required this.isSelectable,
      required this.onSelected,
      required this.dateSeleted});

  @override
  State<TimeSlotCard> createState() => _TimeSlotCardState();
}

class _TimeSlotCardState extends State<TimeSlotCard> {
  @override
  void didUpdateWidget(TimeSlotCard oldWidget) {
    build(context);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isSelected
        ? (widget.dateSeleted!['type'] == "Ngày thường"
            ? const Color(0xff207A20)
            : const Color(0xff964444))
        : (widget.isSelectable ? Colors.white : Colors.grey);
    final textColor = widget.isSelected ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: () {
        if (widget.isSelectable) {
          widget.onSelected(widget.timeSlot);
        }
      },
      child: Container(
        // height: 20.0,
        // width: 40.0,
        decoration: BoxDecoration(
          border: widget.isSelectable
              ? Border.all(color: Colors.black, width: 1.0)
              : null,
          borderRadius: BorderRadius.circular(5.0),
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            widget.timeSlot,
            style: TextStyle(fontSize: 23, color: textColor),
          ),
        ),
      ),
    );
  }
}
