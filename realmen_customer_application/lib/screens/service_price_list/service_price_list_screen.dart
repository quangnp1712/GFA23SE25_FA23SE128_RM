// ignore_for_file: must_be_immutable, constant_identifier_names, avoid_print, avoid_unnecessary_containers, use_build_context_synchronously

import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:realmen_customer_application/screens/message/success_screen.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'package:realmen_customer_application/models/categoryservice/category_model.dart';
import 'package:realmen_customer_application/service/categoryservice/category_services_service.dart';

import 'package:cached_network_image/cached_network_image.dart';

class ServicePriceListScreen extends StatefulWidget {
  Function? callback;
  ServicePriceListScreen(this.callback, {super.key});

  @override
  State<ServicePriceListScreen> createState() => _ServicePriceListScreenState();
  static const String ServicePriceListScreenRoute =
      "/service-price-list-screen";
}

class _ServicePriceListScreenState extends State<ServicePriceListScreen> {
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
                                        widget.callback!(0);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "bảng dịch vụ".toUpperCase(),
                                        style: const TextStyle(
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

                        isLoading
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 30),
                                    height: 50,
                                    width: 50,
                                    child: const CircularProgressIndicator(),
                                  )
                                ],
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: ListView.builder(
                                  itemCount: categories?.length ?? 0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, categoryIndex) {
                                    final category = categories?[categoryIndex];
                                    return category!.serviceList != null
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
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
                                                  category.categoryType!
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                child: GridView.builder(
                                                  itemCount: category
                                                          .serviceList
                                                          ?.length ??
                                                      0,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  padding:
                                                      const EdgeInsets.all(5),
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
                                                    final service =
                                                        category.serviceList?[
                                                            serviceIndex];
                                                    // final thumbnailUrl = service?.branchServiceList?.first.thumbnailUrl ?? '';
                                                    return Container(
                                                      height: 204,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        color: Colors.black,
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        10),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                              ),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: service!
                                                                    .serviceDisplayList![
                                                                        0]
                                                                    .serviceDisplayUrl!,
                                                                height: 140,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.4,
                                                                fit: BoxFit
                                                                    .cover,
                                                                progressIndicatorBuilder:
                                                                    (context,
                                                                            url,
                                                                            progress) =>
                                                                        Center(
                                                                  child:
                                                                      CircularProgressIndicator(
                                                                    value: progress
                                                                        .progress,
                                                                  ),
                                                                ),
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
                                                                              utf8.decode(service.name.toString().runes.toList()),
                                                                              maxLines: 2, // Số dòng tối đa
                                                                              softWrap: true, // Cho phép tự động xuống dòng
                                                                              style: const TextStyle(
                                                                                overflow: TextOverflow.ellipsis,
                                                                                fontSize: 18,
                                                                                fontWeight: FontWeight.w500,
                                                                                color: Colors.white,
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

  List<CategoryModel>? categories;
  bool isLoading = true;

  @override
  void initState() {
    _fetchCategoryServiceList();
    super.initState();
  }

  Future<void> _fetchCategoryServiceList() async {
    if (!_isDisposed && mounted) {
      try {
        final categoryService = CategoryServices();
        final result = await categoryService.getCategoryServiceList();

        if (result['statusCode'] == 200) {
          categories = result['data'].values;
          for (var category in categories!) {
            if (category.categoryType == 'HAIRCUT') {
              category.categoryType = 'Cắt tóc'.toUpperCase();
            } else if (category.categoryType == 'MASSAGE') {
              category.categoryType;
            } else {
              category.categoryType = 'Dịch vụ khác'.toUpperCase();
            }
            for (var service in category.serviceList!) {
              try {
                var reference = storage.ref(
                    'service/${service.serviceDisplayList![0].serviceDisplayUrl}');
                service.serviceDisplayList![0].serviceDisplayUrl =
                    await reference.getDownloadURL();
              } catch (e) {
                final random = Random();
                var randomUrl = random.nextInt(urlList.length);
                var reference = storage.ref('service/${urlList[randomUrl]}');
                service.serviceDisplayList![0].serviceDisplayUrl =
                    await reference.getDownloadURL();
              }
            }
          }
          if (!_isDisposed && mounted) {
            setState(() {
              categories;
              isLoading = false;
            });
          }
        } else if (result['statusCode'] == 500) {
          _errorMessage("${result['error']}");
        } else {
          // Xử lý lỗi nếu cần
          print(result['status'] + result['error']);
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  final storage = FirebaseStorage.instance;
  List<String> urlList = [
    "1.jpg",
    "2.png",
    "3.png",
  ];
}
