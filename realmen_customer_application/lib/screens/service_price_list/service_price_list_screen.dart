import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'package:realmen_customer_application/models/categoryservice/category_service.dart';
import 'package:realmen_customer_application/service/categoryservice/category_services_service.dart';
import 'dart:typed_data';

class ServicePriceListScreen extends StatefulWidget {
  Function callback;
  ServicePriceListScreen(this.callback, {super.key});

  @override
  State<ServicePriceListScreen> createState() => _ServicePriceListScreenState();
  static const String ServicePriceListScreenRoute =
      "/service-price-list-screen";
}

class _ServicePriceListScreenState extends State<ServicePriceListScreen> {
  List<CategoryModel>? categories;

  @override
  void initState() {
    super.initState();
    // Gọi API để lấy danh sách category và dịch vụ
    _fetchCategoryServiceList();
  }

  Future<void> _fetchCategoryServiceList() async {
    try {
      final categoryService = CategoryServices();
      final result = await categoryService.getCategoryServiceList();

      if (result['statusCode'] == 200) {
        setState(() {
          categories = result['data'].values;
        });
      } else {
        // Xử lý lỗi nếu cần
      }
    } catch (e) {}
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
                                        "bảng dịch vụ".toUpperCase(),
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
// chỉ xử lý code API từ đây trở xuống
                        // chỉ xử lý API từ đây xuống
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: ListView.builder(
                            itemCount: categories?.length ?? 0,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, categoryIndex) {
                              final category = categories?[categoryIndex];
                              return category?.serviceList != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                color: Colors.black,
                                                width: 8,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            utf8
                                                .decode(category
                                                        ?.title?.codeUnits ??
                                                    Uint8List(0))
                                                .toUpperCase(),
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
                                            itemCount:
                                                category?.serviceList?.length ??
                                                    0,
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
                                              childAspectRatio: 2 / 3.1,
                                            ),
                                            itemBuilder:
                                                (context, serviceIndex) {
                                              final service = category
                                                  ?.serviceList?[serviceIndex];
// final thumbnailUrl = service?.branchServiceList?.first.thumbnailUrl ?? '';
                                              return Container(
                                                height: 204,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.black,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                        child: FutureBuilder<
                                                            Widget>(
                                                          future: getImageFB(
                                                              service!),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot<
                                                                      Widget>
                                                                  snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .done) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                return snapshot
                                                                    .data!; // Return the widget when the future is complete
                                                              } else {
                                                                return Container(
                                                                    height:
                                                                        140); // Handle the case when the future completes with an error
                                                              }
                                                            } else {
                                                              return const SizedBox(
                                                                  height: 140,
                                                                  child: Center(
                                                                      child:
                                                                          CircularProgressIndicator())); // Show a loading indicator while the future is in progress
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Flexible(
                                                                  child:
                                                                      ClipRRect(
                                                                    child:
                                                                        Container(
                                                                      child:
                                                                          Text(
                                                                        utf8.decode(service?.name?.codeUnits ??
                                                                            Uint8List(0)),
                                                                        maxLines:
                                                                            2, // Số dòng tối đa
                                                                        softWrap:
                                                                            true, // Cho phép tự động xuống dòng
                                                                        style:
                                                                            const TextStyle(
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
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
                                    )
                                  : Container();
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

  final storage = FirebaseStorage.instance;
  List<String> urlList = [
    "1.jpg",
    "2.png",
    "3.png",
  ];
  Future<Widget> getImageFB(SubServiceModel service) async {
    try {
      if (service.serviceDisplayList != null &&
          service.serviceDisplayList!.length > 0) {
        final String serviceDisplayUrl =
            service.serviceDisplayList![0].serviceDisplayUrl.toString();
        var reference = storage.ref('service/$serviceDisplayUrl');
        return Image.network(
          await reference.getDownloadURL(),
          scale: 1,
          fit: BoxFit.cover,
          height: 140,
          width: MediaQuery.of(context).size.width / 1.0,
        );
      } else
        return Container();
    } catch (e) {
      final _random = new Random();
      var randomUrl = _random.nextInt(urlList.length);
      var reference = storage.ref('service/${urlList[randomUrl]}');
      return Image.network(
        await reference.getDownloadURL(),
        scale: 1,
        fit: BoxFit.cover,
        height: 140,
        width: MediaQuery.of(context).size.width / 1.0,
      );
    }
  }
}
