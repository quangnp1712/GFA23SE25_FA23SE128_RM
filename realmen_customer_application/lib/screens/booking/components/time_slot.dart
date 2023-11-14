import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 1.0),
            ),
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
          border: Border.all(color: Colors.black, width: 1.0),
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
