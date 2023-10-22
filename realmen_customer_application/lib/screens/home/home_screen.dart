import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realmen_customer_application/screens/home/components/recoment_services.dart';
import 'package:realmen_customer_application/screens/home/components/top_barber.dart';
import 'package:realmen_customer_application/screens/home/components/branch_shop_near_you.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:custom_rounded_rectangle_border/custom_rounded_rectangle_border.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  static const String LoginPhoneScreenRoute = "/home-screen";
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover),
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
                    padding: const EdgeInsets.only(top: 20, left: 0),
                    width: 90.w,
                    height: 90.h,
                    // height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: ListView(
                      children: [
                        Container(
                          height: 80,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          alignment: Alignment.topLeft,
                          child: Image.asset('assets/images/logo.png'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 70,
                          margin: const EdgeInsets.only(right: 25),
                          padding: EdgeInsets.only(left: 25),
                          decoration: const ShapeDecoration(
                            shape: CustomRoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              // leftSide: BorderSide.none,
                              topRightCornerSide: BorderSide(
                                width: 1,
                                color: Color(0x73444444),
                              ),
                              bottomRightCornerSide: BorderSide(
                                width: 1,
                                color: Color(0x73444444),
                              ),
                              bottomSide: BorderSide(
                                width: 1,
                                color: Color(0x73444444),
                              ),
                              topSide: BorderSide(
                                width: 1,
                                color: Color(0x73444444),
                              ),
                              rightSide: BorderSide(
                                width: 1,
                                color: Color(0x73444444),
                              ),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 60,
                                height: 60,
                                child: CircleAvatar(
                                  child: ClipOval(
                                    child: Image.asset(
                                      "assets/images/admin.png",
                                      fit: BoxFit.cover,
                                      width: 120,
                                      height: 120,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                child: Flexible(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Chào buổi sáng, MikeMikeMikeMike",
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        "Level 1",
                                        style: GoogleFonts.quicksand(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            color: Colors.white,
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 10,
                              childAspectRatio: 4 / 4.5,
                              children: [
                                cardHolder(
                                  'Đặt lịch',
                                  Icons.calendar_month,
                                  Color(0xffE3E3E3),
                                  () {},
                                ),
                                cardHolder(
                                  'Lịch sử đặt lịch',
                                  Icons.history,
                                  Color(0xffE3E3E3),
                                  () {},
                                ),
                                cardHolder(
                                  'Bảng giá',
                                  CommunityMaterialIcons.view_list_outline,
                                  Color(0xffE3E3E3),
                                  () {},
                                ),
                                cardHolder(
                                  'Realmen Member',
                                  CommunityMaterialIcons.crown,
                                  Color(0xffE3E3E3),
                                  () {},
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: const BoxDecoration(
                                            color: Color(0xffE3E3E3),
                                            shape: BoxShape.circle,
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/icons/store-marker-outline.svg',
                                            color: const Color(0xff323232),
                                            height: 24,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Chi nhánh'.toUpperCase(),
                                          style: GoogleFonts.quicksand(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                cardHolder(
                                  'Ưu Đãi',
                                  CommunityMaterialIcons.ticket_percent_outline,
                                  const Color(0xffE3E3E3),
                                  () {},
                                ),
                                cardHolder(
                                  'Lịch đặt của bạn',
                                  CommunityMaterialIcons.calendar_check_outline,
                                  const Color(0xffE3E3E3),
                                  () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "Trải Nghiệm Dịch Vụ",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            RecomendServices(),
                            const SizedBox(
                              height: 30,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "Top Thợ Cắt Tóc",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            barberTop(),
                            const SizedBox(
                              height: 30,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "Chi Nhánh Gần Bạn",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            branchShopNearYou(),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }

  cardHolder(String title, IconData iconData, Color background,
          VoidCallback onTap) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            // boxShadow: [
            //   BoxShadow(
            //     offset: const Offset(0, 5),
            //     // color: primaryColor.withOpacity(.2),
            //     spreadRadius: 2,
            //     blurRadius: 5,
            //   )
            // ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: background,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  iconData,
                  color: const Color(0xff323232),
                  size: 24,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: GoogleFonts.quicksand(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
      );
}
