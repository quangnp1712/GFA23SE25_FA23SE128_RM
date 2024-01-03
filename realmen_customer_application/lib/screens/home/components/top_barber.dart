// ignore_for_file: camel_case_types, avoid_unnecessary_containers, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:realmen_customer_application/models/account/account_info_model.dart';
import 'package:realmen_customer_application/screens/message/success_screen.dart';
import 'package:realmen_customer_application/service/account/account_service.dart';

class barberTop extends StatefulWidget {
  // const barberTop({super.key});

  const barberTop({super.key});

  @override
  State<barberTop> createState() => _barberTopState();
}

class _barberTopState extends State<barberTop> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 310,
      child: GridView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: staffList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 310 / 240,
          ),
          itemBuilder: (context, index) {
            return Container(
              // height: 200,
              // width: MediaQuery.of(context).size.width / 0.4,
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: const Color(0xA6444444),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: staffList[index].thumbnailUrl!,
                              height: 200,
                              width: MediaQuery.of(context).size.width / 1.4,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  value: progress.progress,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 26,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Text(
                                        utf8.decode(
                                            ("${staffList[index].firstName!.substring(staffList[index].firstName!.lastIndexOf(" ") + 1)} ${staffList[index].lastName!}")
                                                .toString()
                                                .runes
                                                .toList()),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 66,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(
                                      fontSize: 17,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    children: [
                                      const WidgetSpan(
                                        child: Icon(
                                          Icons.star,
                                          color: Color(0xff323232),
                                        ),
                                      ),
                                      const WidgetSpan(
                                        child: SizedBox(width: 4),
                                      ),
                                      TextSpan(
                                        text: staffList[index]
                                            .staff!
                                            .averageRating
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 5),
                                // Text.rich(
                                //   TextSpan(
                                //     style: TextStyle(
                                //       fontSize: 17,
                                //       color: Colors.black.withOpacity(0.6),
                                //     ),
                                //     children: [
                                //       const WidgetSpan(
                                //         child: Icon(
                                //           Icons.location_on,
                                //           color: Color(0xff323232),
                                //         ),
                                //       ),
                                //       const WidgetSpan(
                                //         child: SizedBox(width: 4),
                                //       ),
                                //       TextSpan(
                                //           text: utf8.decode(staffList[index]
                                //               .branch!
                                //               .branchName
                                //               .toString()
                                //               .runes
                                //               .toList())),
                                //     ],
                                //   ),
                                // ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Color(0xff323232),
                                    ),
                                    const SizedBox(width: 4),
                                    SizedBox(
                                      width: 229 - 63,
                                      child: Text(
                                        utf8.decode(staffList[index]
                                            .branch!
                                            .branchName
                                            .toString()
                                            .runes
                                            .toList()),
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 17,
                                          overflow: TextOverflow.ellipsis,
                                          color: Colors.grey.shade800,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  void initState() {
    super.initState();
    getStylist();
  }

  // ignore: unused_field
  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  final storage = FirebaseStorage.instance;

  List<String> urlList = [
    "1.jpg",
    "2.jpg",
    "3.jpg",
    "4.jpg",
  ];
  List<AccountInfoModel> staffList = [];
  Future<void> getStylist() async {
    if (!_isDisposed && mounted) {
      try {
        int current = 1;
        int totalPages = 0;
        do {
          AccountService accountService = AccountService();
          staffList = [];
          final result = await accountService.getStaff(5, current, null);
          if (result['statusCode'] == 200) {
            staffList = result['data'] as List<AccountInfoModel>;
            current = result['current'];
            totalPages = result['totalPages'];
            staffList
                .removeWhere((staff) => staff.staff!.professional == 'MASSEUR');
            for (var staff in staffList) {
              try {
                var reference = storage.ref('stylist/${staff.thumbnailUrl}');
                staff.thumbnailUrl = await reference.getDownloadURL();
              } catch (e) {
                final random = Random();
                var randomUrl = random.nextInt(urlList.length);
                var reference = storage.ref('stylist/${urlList[randomUrl]}');
                staff.thumbnailUrl = await reference.getDownloadURL();
              }
            }
            setState(() {
              staffList;
            });
            current++;
          } else if (result['statusCode'] == 500) {
            _errorMessage(result['error']);
            break;
          } else {
            print("$result");
            break;
          }
        } while (current <= totalPages);
      } on Exception catch (e) {
        print(e.toString());
        print("Error: $e");
      }
    }
  }

  // ignore: unused_element
  void _successMessage(String? message) {
    try {
      ShowSnackBar.SuccessSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

  // ignore: unused_element
  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }
}
