import 'package:flutter/material.dart';

class OnOffSwitch extends StatefulWidget {
  final ValueChanged<bool> onChanged;
  final bool initialValue;
  const OnOffSwitch(
      {Key? key, required this.initialValue, required this.onChanged})
      : super(key: key);
  @override
  _OnOffSwitchState createState() => _OnOffSwitchState();
}

class _OnOffSwitchState extends State<OnOffSwitch> {
  late bool isSwitched;

  @override
  void initState() {
    super.initState();
    isSwitched = widget.initialValue;
  }

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
            widget.onChanged(value);
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
