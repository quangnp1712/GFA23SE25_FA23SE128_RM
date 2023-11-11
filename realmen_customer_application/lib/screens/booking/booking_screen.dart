import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realmen_customer_application/screens/booking/components/branch.dart';
import 'package:realmen_customer_application/screens/booking/components/stylist.dart';
import 'package:realmen_customer_application/screens/membership/components/labeltext_level.dart';
import 'package:sizer/sizer.dart';

class BookingScreen extends StatefulWidget {
  Function callback;
  BookingScreen(this.callback, {super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
  static const String BookingScreenRoute = "/booking-screen";
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.only(top: 15, left: 0),
                  width: 90.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.only(left: 7),
                        child: Center(
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 50,
                                child: IconButton(
                                  alignment: Alignment.centerLeft,
                                  color: Colors.black,
                                  iconSize: 22,
                                  icon: const Icon(Icons.keyboard_arrow_left),
                                  onPressed: () {
                                    widget.callback(0);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "đặt lịch giữ chỗ".toUpperCase(),
                                    style: GoogleFonts.quicksand(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                              height: 180,
                              decoration:
                                  const BoxDecoration(color: Colors.black)),
                          Image.asset(
                            "assets/images/Logo-White-NoBG-O-15.png",
                            width: 360,
                            height: 180,
                          ),
                          Container(
                            height: 180,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Chào mừng bạn đến với REALMEN",
                                          style: GoogleFonts.quicksand(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    "Bạn có hai cách để đặt lịch cắt tóc:",
                                    style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    "• Chọn theo chi nhánh: Bạn có thể chọn chi nhánh gần nhất với vị trí của mình để đặt lịch",
                                    style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Text(
                                    "• Chọn theo chi nhánh: Bạn có thể chọn chi nhánh gần nhất với vị trí của mình để đặt lịch",
                                    style: GoogleFonts.quicksand(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TabBar(
                        controller: _tabController,
                        labelColor: Colors.black,
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                        indicator: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.black,
                              width: 2.0,
                            ),
                          ),
                        ),
                        tabs: const [
                          Tab(text: 'Theo chi nhánh'),
                          Tab(text: 'Theo thợ cắt tóc'),
                        ],
                      ),
                      Container(
                        color: Colors.amber,
                        width: 400,
                        height: 52.h,
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            Center(child: BranchOptionBooking()),
                            Center(child: StylistOptionBooking()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ))
      ],
    ));
  }

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
