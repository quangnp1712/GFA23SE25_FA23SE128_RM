import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'package:realmen_staff_application/screens/task/booking_processing.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
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
                            length: tabs.length,
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
                                  tabs: tabs,
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
                                    children: bookings,
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

  @override
  void initState() {
    super.initState();
    getData();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  late TabController _tabController;
  List<Tab> tabs = [];
  List<BookingProcessingTestTab> bookings = [];

  List<Map<String, dynamic>> datas = [
    {"BookingId": 1},
    {"BookingId": 5},
    {"BookingId": 3},
    {"BookingId": 9},
  ];

// call API
  Future<void> getData() async {
    try {
      for (var data in datas) {
        Tab tab = Tab(
          child: Text(
            '${datas.indexOf(data) + 1}',
            style: GoogleFonts.quicksand(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
        tabs.add(tab);
        BookingProcessingTestTab bookingProcessingTestTab =
            BookingProcessingTestTab(bookingId: data["BookingId"]);
        bookings.add(bookingProcessingTestTab);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

class BookingProcessingTestTab extends StatefulWidget {
  int bookingId;
  BookingProcessingTestTab({
    Key? key,
    required this.bookingId,
  }) : super(key: key);

  @override
  State<BookingProcessingTestTab> createState() =>
      _BookingProcessingTestTabState();
}

class _BookingProcessingTestTabState extends State<BookingProcessingTestTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Center(
        child: Text("Booking ID: ${widget.bookingId}"),
      ),
    );
  }
}
