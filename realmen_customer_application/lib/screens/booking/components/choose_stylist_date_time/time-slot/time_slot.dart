import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChooseDateAndTimeSlot extends StatefulWidget {
  const ChooseDateAndTimeSlot({super.key});

  @override
  State<ChooseDateAndTimeSlot> createState() => _ChooseDateAndTimeSlotState();
}

class _ChooseDateAndTimeSlotState extends State<ChooseDateAndTimeSlot> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Container(
            padding:
                const EdgeInsets.only(left: 10, right: 0, top: 5, bottom: 5),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      item['date'] as String,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            item['type'] == "Ngày thường"
                                                ? Container(
                                                    width: 100,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xff207A20),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "Ngày thường",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(
                                                    width: 100,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5,
                                                        vertical: 5),
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xff964444),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "Cuối tuần",
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white,
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
                                  .substring(0, value.toString().indexOf(","))
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
                              thumbVisibility: MaterialStateProperty.all(true),
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
      ],
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

class TimeSlot extends StatefulWidget {
  TimeSlot({super.key, required this.type});
  final String type;

  @override
  _TimeSlotState createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  String _selectedTimeSlot = ''; // Track selected time slot
  late String type;

  @override
  void initState() {
    super.initState();
    type = widget.type;
  }

  @override
  void didUpdateWidget(TimeSlot oldWidget) {
    setState(() {
      type = widget.type;
    });

    super.didUpdateWidget(oldWidget);
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
                _selectedTimeSlot ?? "",
                style: TextStyle(fontSize: 23),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Center(
          child: Container(
            width: 240.0,
            height: 220.0, // Limit height

            child: TimeSlotGrid(
                type: type,
                selectedTimeSlot: _selectedTimeSlot,
                onTimeSlotSelected: _onTimeSlotSelected),
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
      } else {
        _selectedTimeSlot = timeSlot;
      }
    });
  }
}

class TimeSlotGrid extends StatefulWidget {
  final String type;

  final String selectedTimeSlot;
  final void Function(String timeSlot) onTimeSlotSelected;

  TimeSlotGrid({
    required this.selectedTimeSlot,
    required this.onTimeSlotSelected,
    required this.type,
  });

  @override
  State<TimeSlotGrid> createState() => _TimeSlotGridState();
}

class _TimeSlotGridState extends State<TimeSlotGrid> {
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
        final isSelectable = timeSlot.compareTo(currentTime) >= 0;

        return TimeSlotCard(
          type: widget.type,
          timeSlot: timeSlot,
          isSelected: isSelected,
          isSelectable: isSelectable,
          onSelected: widget.onTimeSlotSelected,
        );
      },
    );
  }

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
      for (int i = 0; i < timeSlots.length; i++) {
        final timeSlot = timeSlots[i];
        final isSelectable = timeSlot.compareTo(currentTime) >= 0;
        if (isSelectable) {
          scrollListIndex.add(timeSlots.indexOf(timeSlots[i]));
        }
      }
      if (scrollListIndex != null) {
        final _scrollIndex = scrollListIndex.first;
        scrollToIndex(_scrollIndex);
      }
    });
  }

  List<String> timeSlots = [];
  ScrollController scrollController = ScrollController();

  void scrollToIndex(int index) {
    scrollController.animateTo((index / 3).floor() * 99,
        duration: Duration(milliseconds: 1), curve: Curves.easeIn);
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

class TimeSlotCard extends StatelessWidget {
  final String timeSlot;
  final String type;
  final bool isSelected;
  final bool isSelectable;
  final void Function(String timeSlot) onSelected;

  TimeSlotCard(
      {required this.timeSlot,
      required this.isSelected,
      required this.isSelectable,
      required this.onSelected,
      required this.type});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSelected
        ? (type == "Ngày thường"
            ? const Color(0xff207A20)
            : const Color(0xff964444))
        : (isSelectable ? Colors.white : Colors.grey);
    final textColor = isSelected ? Colors.white : Colors.black;

    return GestureDetector(
      onTap: () {
        if (isSelectable) {
          onSelected(timeSlot);
        }
      },
      child: Container(
        // height: 20.0,
        // width: 40.0,
        decoration: BoxDecoration(
          border:
              isSelectable ? Border.all(color: Colors.black, width: 1.0) : null,
          borderRadius: BorderRadius.circular(5.0),
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            timeSlot,
            style: TextStyle(fontSize: 23, color: textColor),
          ),
        ),
      ),
    );
  }
}
