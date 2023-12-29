// ignore_for_file: library_private_types_in_public_api

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

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
    return FlutterSwitch(
      width: 50.0,
      height: 22.0,
      toggleSize: 15.0,
      value: isSwitched,
      borderRadius: 30.0,
      padding: 2.0,
      activeToggleColor: Colors.white,
      inactiveToggleColor: const Color(0xFF2F363D),
      activeSwitchBorder: Border.all(
        color: Colors.black,
        width: 2.0,
      ),
      inactiveSwitchBorder: Border.all(
        color: const Color(0xFFD1D5DA),
        width: 2.0,
      ),
      activeColor: Colors.black,
      inactiveColor: Colors.white,
      activeIcon: const Icon(
        CommunityMaterialIcons.check_bold,
        color: Colors.black,
      ),
      inactiveIcon: const Icon(
        Icons.close,
        color: Colors.white,
      ),
      onToggle: (value) {
        setState(() {
          isSwitched = value;
        });
        widget.onChanged(value);
      },
    );
  }

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(
          Icons.check,
          color: Colors.black,
        );
      }
      return const Icon(
        Icons.close,
        color: Colors.white,
      );
    },
  );
}
