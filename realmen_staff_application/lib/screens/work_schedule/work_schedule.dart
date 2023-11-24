import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class WorkScheduleScreen extends StatefulWidget {
  Function callback;
  WorkScheduleScreen(this.callback, {super.key});

  @override
  State<WorkScheduleScreen> createState() => _WorkScheduleState();
  static const String WorkScheduleScreenRoute = "/work-schedule-screen";
}

class _WorkScheduleState extends State<WorkScheduleScreen> {
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
                                  "lịch làm".toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          // width: 80.w,
                          height: 80.w,
                          child: SfCalendar(
                            view: CalendarView.week,
                            monthViewSettings:
                                MonthViewSettings(showAgenda: true),
                          ),
                        )
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
