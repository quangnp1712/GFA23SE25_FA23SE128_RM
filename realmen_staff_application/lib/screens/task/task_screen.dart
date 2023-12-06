import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realmen_staff_application/screens/task/booking_processing.dart';
import 'package:realmen_staff_application/screens/task/booking_waiting.dart';
import 'package:sizer/sizer.dart';

class TaskScreen extends StatefulWidget {
  TaskScreen(this.callback, {super.key});
  Function callback;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
  static const String ProfileScreenRoute = "/task-screen";
}

class _TaskScreenState extends State<TaskScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                        physics: NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 7),
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Text(
                                    "Công việc".toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          DefaultTabController(
                            length: 2,
                            child: Column(
                              children: [
                                TabBar(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: _tabController,
                                  labelColor: Colors.black,
                                  labelStyle: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                  indicator: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        'ĐANG PHỤC VỤ',
                                        style: GoogleFonts.quicksand(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'ĐANG CHỜ',
                                        style: GoogleFonts.quicksand(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  // color: Colors.amber,
                                  // width: 400,
                                  height: 72.h,
                                  child: TabBarView(
                                    controller: _tabController,
                                    physics: NeverScrollableScrollPhysics(),
                                    children: [
                                      BookingProcessingTab(),
                                      BookingWaitingTab(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    _tabController.dispose();
    super.dispose();
  }
}
