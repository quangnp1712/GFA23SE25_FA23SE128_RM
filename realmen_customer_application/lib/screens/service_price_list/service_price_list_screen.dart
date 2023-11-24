import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'package:realmen_customer_application/models/categoryservice/category_service.dart';
import 'package:realmen_customer_application/service/categoryservice/category_services_service.dart';
import 'package:get/get.dart';

class ServicePriceListScreen extends StatefulWidget {
  Function callback;
  ServicePriceListScreen(this.callback, {super.key});

  @override
  State<ServicePriceListScreen> createState() => _ServicePriceListScreenState();
  static const String ServicePriceListScreenRoute =
      "/service-price-list-screen";
}

class _ServicePriceListScreenState extends State<ServicePriceListScreen> {
  List name = [
    'Nguyen Xuan Soan',
    'Hoang Sa',
    'Tran Huu Nghia',
    'Dien Bien Phu',
  ];
  List<CategoryServiceModel>? categoryServiceList;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final result = await CategoryServices().getCategoryServiceList();

      if (result['statusCode'] == 200) {
        setState(() {
          categoryServiceList = (result['data'] as List<dynamic>)
              .map((item) => CategoryServiceModel.fromJson(item))
              .toList();
        });
      } else {
        print('Error fetching data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

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
                    padding: const EdgeInsets.only(top: 20),
                    width: 90.w,
                    height: 90.h,
                    // height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: ListView(
                      // padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: <Widget>[
                        Container(
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
                                      icon:
                                          const Icon(Icons.keyboard_arrow_left),
                                      onPressed: () {
                                        widget.callback(0);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "dịch vụ".toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        // // Combo
                        // const SizedBox(
                        //   height: 20,
                        // ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(
                        //         horizontal: 15, vertical: 4),
                        //     decoration: const BoxDecoration(
                        //       border: Border(
                        //         left: BorderSide(color: Colors.black, width: 8),
                        //       ),
                        //     ),
                        //     child: Text(
                        //       "realmen combo".toUpperCase(),
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w600,
                        //         fontSize: 20,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   child: GridView.builder(
                        //     itemCount: 2,
                        //     scrollDirection: Axis.vertical,
                        //     padding: const EdgeInsets.all(5),
                        //     shrinkWrap: true,
                        //     physics: const NeverScrollableScrollPhysics(),
                        //     gridDelegate:
                        //         SliverGridDelegateWithFixedCrossAxisCount(
                        //       crossAxisCount: 1,
                        //       crossAxisSpacing: 2,
                        //       mainAxisSpacing: 20,
                        //       childAspectRatio: MediaQuery.of(context)
                        //               .size
                        //               .width /
                        //           (MediaQuery.of(context).size.height * 0.30),
                        //     ),
                        //     itemBuilder: ((context, index) {
                        //       return Container(
                        //         width: MediaQuery.of(context).size.width / 1,
                        //         // margin: const EdgeInsets.only(top: 5, bottom: 5),
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(12),
                        //           color: Colors.black,
                        //         ),
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(2.0),
                        //           child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.start,
                        //             children: [
                        //               ClipRRect(
                        //                 borderRadius: const BorderRadius.only(
                        //                   topRight: Radius.circular(10),
                        //                   topLeft: Radius.circular(10),
                        //                 ),
                        //                 child: Image.asset(
                        //                   // "assets/branchshop/${index + 1}.png",
                        //                   "assets/images/admin.png",
                        //                   height: 160,
                        //                   width: MediaQuery.of(context)
                        //                           .size
                        //                           .width /
                        //                       1.0,
                        //                   fit: BoxFit.cover,
                        //                 ),
                        //               ),
                        //               Padding(
                        //                 padding: const EdgeInsets.all(5),
                        //                 child: Column(
                        //                   crossAxisAlignment:
                        //                       CrossAxisAlignment.center,
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceEvenly,
                        //                   children: [
                        //                     const SizedBox(
                        //                       height: 5,
                        //                     ),
                        //                     Text(
                        //                       name[index],
                        //                       style: const TextStyle(
                        //                         fontSize: 18,
                        //                         fontWeight: FontWeight.w500,
                        //                         color: Colors.white,
                        //                       ),
                        //                     ),
                        //                     const SizedBox(
                        //                       height: 5,
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       );
                        //     }),
                        //   ),
                        // ),
                        // Dịch vụ
                        // const SizedBox(
                        //   height: 20,
                        // ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.builder(
                            itemCount:
                                2, // Assuming there are two categories in this section
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 4,
                                    ),
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        left: BorderSide(
                                            color: Colors.black, width: 8),
                                      ),
                                    ),
                                    child: Text(
                                      "cắt tóc".toUpperCase(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: GridView.builder(
                                      itemCount: 4,
                                      scrollDirection: Axis.vertical,
                                      padding: const EdgeInsets.all(5),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 20,
                                        childAspectRatio: 2 / 2.9,
                                      ),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height: 204,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.black,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  child: Image.asset(
                                                    "assets/images/admin.png",
                                                    height: 140,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.0,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        name[index],
                                                        maxLines: 1,
                                                        style: const TextStyle(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              );
                            },
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
      ),
    );
  }
}
