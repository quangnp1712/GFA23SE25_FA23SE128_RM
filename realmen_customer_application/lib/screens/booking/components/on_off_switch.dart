import 'package:flutter/material.dart';

class OnOffSwitch extends StatefulWidget {
  @override
  _OnOffSwitchState createState() => _OnOffSwitchState();
}

class _OnOffSwitchState extends State<OnOffSwitch> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.6, // Điều chỉnh tỷ lệ kích thước ở đây
      child: Container(
        height: 30,
        width: 60,
        decoration: BoxDecoration(
          // color: Colors.black12,
          borderRadius: BorderRadius.circular(12.0), // Độ bo góc của đường viền
          border: Border.all(
            color: Colors.black, // Màu sắc của đường viền
            width: 1.2, // Độ rộng của đường viền
          ),
        ),
        child: Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
            });
          },
          activeTrackColor: Colors.white,
          activeColor: Colors.black,
          inactiveTrackColor: Colors.grey,
          inactiveThumbColor: Colors.black,
        ),
      ),
    );
  }
}
