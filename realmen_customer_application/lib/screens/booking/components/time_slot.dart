import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeSlot extends StatefulWidget {
  @override
  _TimeSlotState createState() => _TimeSlotState();
}

class _TimeSlotState extends State<TimeSlot> {
  String _selectedTimeSlot = ''; // Track selected time slot

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 280.0,
          height: 220.0, // Limit height
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0),
          ),
          child: TimeSlotGrid(
              selectedTimeSlot: _selectedTimeSlot,
              onTimeSlotSelected: _onTimeSlotSelected),
        ),
      ),
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

class TimeSlotGrid extends StatelessWidget {
  final String selectedTimeSlot;
  final void Function(String timeSlot) onTimeSlotSelected;

  TimeSlotGrid(
      {required this.selectedTimeSlot, required this.onTimeSlotSelected});

  @override
  Widget build(BuildContext context) {
    final timeSlots = generateTimeSlots();
    final now = DateTime.now();
    final formatter = DateFormat('HH:mm');
    final currentTime = formatter.format(now);

    return GridView.builder(
      scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1 / 1.5),
      itemCount: timeSlots.length,
      itemBuilder: (BuildContext context, int index) {
        final timeSlot = timeSlots[index];
        final isSelected = timeSlot == selectedTimeSlot;
        final isSelectable = timeSlot.compareTo(currentTime) >= 0;

        return TimeSlotCard(
          timeSlot: timeSlot,
          isSelected: isSelected,
          isSelectable: isSelectable,
          onSelected: onTimeSlotSelected,
        );
      },
    );
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
  final bool isSelected;
  final bool isSelectable;
  final void Function(String timeSlot) onSelected;

  TimeSlotCard(
      {required this.timeSlot,
      required this.isSelected,
      required this.isSelectable,
      required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        isSelected ? Colors.grey : (isSelectable ? Colors.white : Colors.grey);

    return GestureDetector(
      onTap: () {
        if (isSelectable) {
          onSelected(timeSlot);
        }
      },
      child: Container(
        height: 20.0,
        width: 20.0,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1.0),
          borderRadius: BorderRadius.circular(5.0),
          color: backgroundColor,
        ),
        child: Center(
          child: Text(
            timeSlot,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
