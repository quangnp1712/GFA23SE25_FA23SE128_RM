import 'package:community_material_icon/community_material_icon.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
  static const String TestScreenRoute = "/test-screen";
}

class _TestScreenState extends State<TestScreen> {
  bool light = true;

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSwitch(
        width: 50.0,
        height: 25.0,
        toggleSize: 15.0,
        value: light,
        borderRadius: 30.0,
        padding: 2.0,
        activeToggleColor: Colors.white,
        inactiveToggleColor: Color(0xFF2F363D),
        activeSwitchBorder: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        inactiveSwitchBorder: Border.all(
          color: Color(0xFFD1D5DA),
          width: 2.0,
        ),
        activeColor: Colors.black,
        inactiveColor: Colors.white,
        activeIcon: Icon(
          CommunityMaterialIcons.check_bold,
          color: Colors.black,
        ),
        inactiveIcon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        onToggle: (val) {
          setState(() {
            light = val;
          });
        },
      ),
    );
  }

  Color _textColor = Colors.black;
  Color _appBarColor = Color.fromRGBO(36, 41, 46, 1);
  Color _scaffoldBgcolor = Colors.white;
}
