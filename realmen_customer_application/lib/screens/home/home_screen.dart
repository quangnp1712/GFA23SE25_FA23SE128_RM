import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realmen_customer_application/screens/home/components/recoment_services.dart';
import 'package:realmen_customer_application/screens/home/components/top_barber.dart';
import 'package:realmen_customer_application/screens/home/components/branch_shop_near_you.dart';
import 'package:sizer/sizer.dart';

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
                    padding: const EdgeInsets.only(top: 30, left: 0),
                    width: 90.w,
                    height: 90.h,
                    // height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: ListView(
                      children: [
                        Container(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(200),
                              ),
                            ),
                            child: GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 4,
                              crossAxisSpacing: 25,
                              mainAxisSpacing: 25,
                              childAspectRatio: 4 / 4.2,
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
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          'Chi nhánh'.toUpperCase(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 7,
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
                          height: 35,
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
                child: Icon(iconData, color: Color(0xff323232)),
              ),
              const SizedBox(height: 5),
              Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 7,
                ),
              )
            ],
          ),
        ),
      );
}
