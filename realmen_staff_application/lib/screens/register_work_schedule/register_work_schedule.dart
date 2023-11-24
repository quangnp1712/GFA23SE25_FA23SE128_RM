import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegisterWorkScheduleScreen extends StatefulWidget {
  Function callback;
  RegisterWorkScheduleScreen(this.callback, {super.key});

  @override
  State<RegisterWorkScheduleScreen> createState() =>
      _RegisterWorkScheduleScreenState();
  static const String RegisterWorkScheduleScreenRoute =
      "/register-work-schedule-screen";
}

class _RegisterWorkScheduleScreenState
    extends State<RegisterWorkScheduleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
              child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 15,
                bottom: 27,
                child: Container(
                    padding: const EdgeInsets.only(top: 30),
                    width: 90.w,
                    height: 90.h,
                    // height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 7),
                          child: Center(
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Text(
                                  "Đăng kí lịch làm".toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ))
        ],
      ),
    );
  }
}
