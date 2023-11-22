import 'dart:convert';

import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/models/branch/branch_model.dart';
import 'package:realmen_customer_application/screens/booking/booking_screen.dart';
import 'package:realmen_customer_application/screens/message/success_screen.dart';
import 'package:realmen_customer_application/service/branch/branch_service.dart';
import 'package:realmen_customer_application/service/location/location_service.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';

class branchShopNearYou extends StatefulWidget {
  branchShopNearYou(this.callback, {super.key});
  Function callback;

  @override
  State<branchShopNearYou> createState() => _branchShopNearYouState();
}

class _branchShopNearYouState extends State<branchShopNearYou> {
  List nameShop = [
    'Nguyen Xuan Soan',
    'Hoang Sa',
    'Tran Huu Nghia',
    'Dien Bien Phu',
  ];

  @override
  Widget build(BuildContext context) {
    return branchesForCity != null && branchesForCity != []
        ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              SizedBox(
                height: 310,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.4,
                        margin: const EdgeInsets.only(
                            left: 15, top: 5, bottom: 5, right: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.black,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                ),
                                child: Image.asset(
                                  // "assets/branchshop/${index + 1}.png",
                                  "assets/images/admin.png",
                                  height: 160,
                                  width:
                                      MediaQuery.of(context).size.width / 1.4,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          utf8.decode(branchesForCity![index]
                                              .branchName
                                              .toString()
                                              .runes
                                              .toList()),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              fontSize: 17,
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                            children: [
                                              WidgetSpan(
                                                child: Icon(
                                                  Icons.location_on,
                                                  color: Colors.white
                                                      .withOpacity(0.9),
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: SizedBox(width: 4),
                                              ),
                                              TextSpan(
                                                  text: branchesForCity![index]
                                                      .distanceKilometer,
                                                  style: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.8),
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      utf8.decode(branchesForCity![index]
                                          .address
                                          .toString()
                                          .runes
                                          .toList()),
                                      maxLines: 2,
                                      style: TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 15,
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Container(
                                          height: 40,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: const Color(0xff444444),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Mở cừa: 7h - 23h",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            widget.callback(2);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: const Color(0xffE3E3E3),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Container(
                                            height: 40,
                                            width: 120,
                                            padding: const EdgeInsets.all(0),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  // margin: const EdgeInsets.only(left: 5.0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'đặt lịch'.toUpperCase(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Icon(
                                                    CommunityMaterialIcons
                                                        .arrow_right,
                                                    color: Colors.black,
                                                    size: 24,
                                                  ),
                                                ),
                                              ],
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
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        : Container();
  }

  // Logic
  @override
  void initState() {
    super.initState();
    getBranch();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  bool _isDisposed = false;
  LocationService locationService = LocationService();
  Position? position;
  List<BranchModel>? branchesForCity;

  Future<void> getBranch() async {
    if (!_isDisposed) {
      final locationPermission =
          await SharedPreferencesService.getLocationPermission();
      if (!locationPermission) {
        await locationService.getUserCurrentLocation();
      }
      try {
        BranchService branchService = BranchService();
        final result = await branchService.getSearchBranches("", 5);
        if (result['statusCode'] == 200) {
          branchesForCity = [];
          branchesForCity = result['data'] as List<BranchModel>;
          branchesForCity!.sort((a, b) {
            if (a.distanceKilometer == null && b.distanceKilometer == null) {
              return 0;
            } else if (a.distanceKilometer == null) {
              return 1;
            } else if (b.distanceKilometer == null) {
              return -1;
            } else {
              double distanceA = double.parse(
                  a.distanceKilometer!.replaceAll(RegExp(r'[^0-9.]'), ''));
              double distanceB = double.parse(
                  b.distanceKilometer!.replaceAll(RegExp(r'[^0-9.]'), ''));
              return distanceA.compareTo(distanceB);
            }
          });

          setState(() {
            branchesForCity;
          });
        } else {
          _errorMessage("$result['statusCode'] : $result['error']");
        }
      } on Exception catch (e) {
        _errorMessage(e.toString());
        print("Error: $e");
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
}
