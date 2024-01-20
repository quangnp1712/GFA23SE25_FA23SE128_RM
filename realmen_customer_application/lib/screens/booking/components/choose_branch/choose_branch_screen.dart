// ignore_for_file: prefer_const_constructors_in_immutables, constant_identifier_names, avoid_print, use_build_context_synchronously, duplicate_ignore, prefer_conditional_assignment

import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:provider/provider.dart';
import 'package:realmen_customer_application/models/branch/branch_model.dart';
import 'package:realmen_customer_application/service/branch/branch_service.dart';
import 'package:realmen_customer_application/service/change_notifier_provider/change_notifier_provider_service.dart';
import 'package:realmen_customer_application/service/location/location_service.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';
import 'package:sizer/sizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class ChooseBranchesScreen extends StatefulWidget {
  ChooseBranchesScreen({super.key});

  @override
  State<ChooseBranchesScreen> createState() => _ChooseBranchesScreenState();
  static const String ChooseBranchesScreenRoute = "/choose-branches-screen";
}

class _ChooseBranchesScreenState extends State<ChooseBranchesScreen> {
  @override
  Widget build(BuildContext context) {
    var selectedProvider = Provider.of<ChangeNotifierServices>(context);

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
                      padding: const EdgeInsets.only(top: 15, left: 0),
                      width: 90.w,
                      height: 90.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: ListView(
                        controller: _scrollController,
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
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "chọn barber".toUpperCase(),
                                        style: const TextStyle(
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
                                  height: 160,
                                  decoration:
                                      const BoxDecoration(color: Colors.black)),
                              Image.asset(
                                "assets/images/Logo-White-NoBG-O-15.png",
                                width: 360,
                                height: 160,
                              ),
                              Container(
                                height: 160,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "các barber CỦA REALMEN".toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "Tận hưởng trải nghiệm cắt tóc nam đỉnh \ncao tại hơn $count barber RealMen trải dài khắp \n${city1 ?? ""}${city2 != null ? ', $city2 ' : ''} ${city1 != null || city2 != null ? 'và ' : ''}các tỉnh lân cận!",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        height: 1.4,
                                      ),
                                      // textAlign: TextAlign.justify,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          // search autocomplete
                          SizedBox(
                            // width: 80.w,
                            // height: 50,
                            child: FocusScope(
                              node: focusScopeNode,
                              child: Autocomplete<BranchModel>(
                                displayStringForOption: displayStringForOption,
                                // initialValue: null,
                                optionsBuilder: (textEditingValue) async {
                                  if (textEditingValue.text.isEmpty ||
                                      textEditingValue.text == '') {
                                    return const Iterable.empty();
                                  }
                                  if (cityController == "Thành Phố/Tỉnh") {
                                    final value = await BranchService()
                                        .getSearchBranches(
                                            textEditingValue.text, 5, 1);
                                    if (value['statusCode'] == 200) {
                                      try {
                                        options = (await value)['data']
                                            as Iterable<BranchModel>;

                                        return Future.value(options);
                                      } catch (e) {
                                        print(e);
                                      }
                                    }
                                  } else {
                                    if (branchesForCity != null) {
                                      options = branchesForCity!.where(
                                          (element) => utf8
                                              .decode(element.address!.runes
                                                  .toList())
                                              .toLowerCase()
                                              .contains(textEditingValue.text
                                                  .toLowerCase()));

                                      return Future.value(options);
                                    }
                                  }

                                  return [];
                                },
                                onSelected: (address) {
                                  if (!_isDisposed) {
                                    setState(() {
                                      branchesForCity = [];
                                      (branchesForCity as List<BranchModel>)
                                          .add(address);
                                      focusScopeNode.unfocus();
                                      isSearching = true;
                                    });
                                  }
                                  debugPrint('You just selected $address');
                                },
                                fieldViewBuilder: (context, controller,
                                    focusNode, onEditingComplete) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: TextField(
                                      // controller: firstNameController,
                                      controller: controller,
                                      focusNode: focusNode,
                                      onEditingComplete: onEditingComplete,
                                      onSubmitted: (value) async {
                                        searchBranches(value, focusNode, false);
                                        focusNode.requestFocus();
                                      },

                                      cursorColor: Colors.black,
                                      cursorWidth: 1,
                                      style: const TextStyle(
                                          height: 1.17,
                                          fontSize: 20,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.search),
                                        suffixIcon: buildSuffixIcon(
                                            controller, focusNode),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffC4C4C4)),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color(0xffC4C4C4)),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            // top: 10,
                                            // bottom: 20,
                                            left: 15,
                                            right: 15),
                                        hintText: "Tìm kiếm Barber",
                                        hintStyle: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xffC4C4C4)),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 40,
                                width: 200,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xff8E1D1D),
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.grey.shade800, // Màu của bóng
                                      offset: const Offset(0,
                                          2), // Độ dịch chuyển theo trục x và y
                                      blurRadius: 2, // Bán kính làm mờ của bóng
                                      spreadRadius:
                                          0, // Bán kính lan rộng của bóng
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                  style: const ButtonStyle(),
                                  onPressed: () {
                                    searchBranchesWithLocation();
                                  },
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.location_on),
                                      Text(
                                        "Barber gần anh",
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 150,
                                padding: const EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      'Thành phố/Tỉnh',
                                      style: TextStyle(
                                        // fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    alignment: Alignment.center,
                                    value: cityController,
                                    items: cities != [] && cities.isNotEmpty
                                        ? cities
                                            .map((city) =>
                                                DropdownMenuItem<String>(
                                                  value: city,
                                                  child: Text(
                                                    city,
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ))
                                            .toList()
                                        : [],
                                    onChanged: (city) => setState(() {
                                      cityController = city!;

                                      getBranches(city, false);
                                    }),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 160,
                                      width: 150,
                                      // padding: EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(14),
                                        color: Colors.grey.shade200,
                                      ),
                                      offset: const Offset(-5, -2),
                                      scrollbarTheme: ScrollbarThemeData(
                                        // radius: const Radius.circular(40),
                                        // thickness: MaterialStateProperty.all(6),
                                        thumbVisibility:
                                            MaterialStateProperty.all(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 14, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),

                          // nội dung branch

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
                              : branchesForCity != null &&
                                      branchesForCity!.isNotEmpty
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: branchesForCity?.length,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl: branchesForCity![index]
                                                  .branchDisplayList![0]
                                                  .url!,
                                              height: 140,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2,
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder:
                                                  (context, url, progress) =>
                                                      Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: progress.progress,
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                "assets/images/barber1.jpg",
                                                height: 140,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.2,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            ListTile(
                                              title: Wrap(
                                                spacing:
                                                    8.0, // Khoảng cách giữa các widget con theo chiều ngang
                                                runSpacing:
                                                    4.0, // Khoảng cách giữa các dòng theo chiều dọc
                                                children: [
                                                  Text(utf8.decode(
                                                      branchesForCity![index]
                                                          .branchName
                                                          .toString()
                                                          .runes
                                                          .toList())),
                                                  branchesForCity![index]
                                                              .distanceKilometer !=
                                                          null
                                                      ? Text.rich(
                                                          TextSpan(
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                            ),
                                                            children: [
                                                              WidgetSpan(
                                                                child: Icon(
                                                                  Icons
                                                                      .location_on,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.9),
                                                                ),
                                                              ),
                                                              const WidgetSpan(
                                                                child: SizedBox(
                                                                    width: 4),
                                                              ),
                                                              TextSpan(
                                                                  text: branchesForCity![
                                                                          index]
                                                                      .distanceKilometer,
                                                                  style:
                                                                      TextStyle(
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8),
                                                                  )),
                                                            ],
                                                          ),
                                                        )
                                                      : Container(),
                                                ],
                                              ),
                                              subtitle: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4),
                                                child: Text(utf8.decode(
                                                    branchesForCity![index]
                                                        .address
                                                        .toString()
                                                        .runes
                                                        .toList())),
                                              ),
                                              trailing: Container(
                                                height: 40,
                                                width: 85,
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffE3E3E3),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(4),
                                                  ),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .shade800, // Màu của bóng
                                                      offset: const Offset(0,
                                                          2), // Độ dịch chuyển theo trục x và y
                                                      blurRadius:
                                                          2, // Bán kính làm mờ của bóng
                                                      spreadRadius:
                                                          0, // Bán kính lan rộng của bóng
                                                    ),
                                                  ],
                                                ),
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    getBranchById(
                                                        branchesForCity![index]
                                                            .branchId!,
                                                        selectedProvider);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding:
                                                        const EdgeInsets.all(0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                    ),
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    shadowColor:
                                                        Colors.transparent,
                                                  ),
                                                  child: const Text(
                                                    'Chọn',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            (index !=
                                                    branchesForCity!.length - 1)
                                                ? const Divider(
                                                    color: Color(0x73444444),
                                                    height: 1,
                                                    thickness: 1,
                                                  )
                                                : const SizedBox.shrink(),
                                          ],
                                        );
                                      },
                                    )
                                  : Container(
                                      child: Center(
                                        child: Text(
                                          "Không tìm thấy Barber.\nVui lòng thử lại.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Logic
  @override
  void initState() {
    super.initState();
    getBranchesByCity();
    cityController = "Thành Phố/Tỉnh";

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Khi scroll tới dưới cùng
        checkLoadMore();
      }
    });
  }

  bool _isDisposed = false;
  bool isLoading = true;
  @override
  void dispose() {
    focusNode.dispose();
    _isDisposed = true;
    super.dispose();
  }

  String image = "assets/images/branch1.png";
  BranchesModel? branchesByCityModel = BranchesModel();
  List<BranchModel>? branchesForCity = [];
  String? cityController; // dropdown chọn city
  List<String> cities = [];
  String? city1;
  String? city2;
  final ScrollController _scrollController = ScrollController();

  Future<void> getBranchesByCity() async {
    if (!_isDisposed && mounted) {
      try {
        BranchService branchService = BranchService();
        final result = await branchService.getBranchesByCity();
        if (result['statusCode'] == 200) {
          branchesByCityModel = result['data'] as BranchesModel;
          try {
            if (branchesByCityModel != null) {
              for (BranchesValuesModel branch in branchesByCityModel!.values!) {
                count = count + branch.branch!;
                if (city1 == null) {
                  city1 = utf8.decode(branch.city.toString().runes.toList());
                }
                if (city2 == null) {
                  city2 = utf8.decode(branch.city.toString().runes.toList());
                }
              }
              if (cityController != null) {
                getBranches(cityController!, false);
              }

              cities.add("Thành Phố/Tỉnh");
              if (branchesByCityModel?.values != null) {
                for (var values in branchesByCityModel!.values!) {
                  cities.add(utf8
                      .decode(values.city.toString().runes.toList())
                      .toString());
                }
              }
            }
          } on Exception catch (e) {
            print(e);
          }
          if (!_isDisposed && mounted) {
            setState(() {
              cities;

              count;
              city1;
              city2;
            });
          }
        } else {
          print("$result['statusCode'] : $result['error']");
        }
      } on Exception catch (e) {
        print(e.toString());
        print("Error: $e");
      }
      searchBranches('', null, false);
      setState(() {
        isLoading = false;
      });
    }
  }

// get branch by city
  getBranches(String search, bool callBack) async {
    if (!_isDisposed && mounted) {
      if (!_isDisposed && mounted) {
        setState(() {
          isLoading = true;
        });
      }
      branchesForCity = [];
      try {
        BranchService branchService = BranchService();
        final result = await branchService.getBranches(search, callBack);
        if (result['statusCode'] == 200) {
          // currentResult = result['current'];
          // totalPages = result['totalPages'];
          for (var branch in result['data'].values!) {
            branchesForCity = branch.branchList;
          }
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
          for (BranchModel branch in branchesForCity!) {
            try {
              var reference = storage.ref('${branch.thumbnailUrl}');
              branch.branchDisplayList![0].url =
                  await reference.getDownloadURL();
            } catch (e) {
              final random = Random();
              var randomUrl = random.nextInt(urlList.length);
              var reference = storage.ref('branch/${urlList[randomUrl]}');
              if (branch.branchDisplayList != null) {
                branch.branchDisplayList![0].url =
                    await reference.getDownloadURL();
              } else {
                branch.branchDisplayList = [];
                BranchDisplayListUrl branchDisplayListUrl =
                    BranchDisplayListUrl();
                branchDisplayListUrl.url = await reference.getDownloadURL();
                branch.branchDisplayList!.add(branchDisplayListUrl);
              }
            }
          }
          if (!_isDisposed && mounted) {
            setState(() {
              branchesForCity;
              isLoading = false;
            });
          }
        } else if (result['statusCode'] == 403) {
          if (callBack == false) {
            callBack = true;
            getBranches(search, callBack);
          } else {
            print(result);
          }
        } else {
          print("$result['statusCode'] : $result['error']");
        }
        if (!_isDisposed && mounted) {
          setState(() {
            isLoading = false;
          });
        }
      } on Exception catch (e) {
        print(e.toString());
        print("Error: $e");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  FocusScopeNode focusScopeNode = FocusScopeNode();

// get branch by search
  Future<void> searchBranches(
      String query, FocusNode? focusNode, bool callBack) async {
    if (!_isDisposed) {
      setState(() {
        isLoading = true;
      });
      try {
        BranchService branchService = BranchService();
        final result = await branchService.getSearchBranches(query, 5, current);
        if (result['statusCode'] == 200) {
          branchesForCity = [];
          branchesForCity = result['data'] as List<BranchModel>;
          currentResult = result['current'];
          totalPages = result['totalPages'];
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
          for (BranchModel branch in branchesForCity!) {
            try {
              var reference = storage.ref('${branch.thumbnailUrl}');
              branch.branchDisplayList![0].url =
                  await reference.getDownloadURL();
            } catch (e) {
              final random = Random();
              var randomUrl = random.nextInt(urlList.length);
              var reference = storage.ref('branch/${urlList[randomUrl]}');
              branch.branchDisplayList![0].url =
                  await reference.getDownloadURL();
            }
          }
          setState(() {
            branchesForCity;
            isSearching = true;
            if (focusNode != null) {
              focusNode.unfocus();
            }
          });
        } else if (result['statusCode'] == 403) {
          if (callBack == false) {
            callBack = true;
            searchBranches(query, focusNode, callBack);
          }
        } else {
          print("$result['statusCode'] : $result['error']");
        }
      } on Exception catch (e) {
        print(e.toString());
        print("Error: $e");
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isFindBranchNear = false;
// Tim chi nhanh gan anh
  Future<void> searchBranchesWithLocation() async {
    if (!_isDisposed && mounted) {
      if (!_isDisposed && mounted && !isCheckLoadMore && !isFindBranchNear) {
        setState(() {
          isLoading = true;
          current = 1;
        });
      }
      final locationPermission =
          await SharedPreferencesService.getLocationPermission();
      if (!locationPermission) {
        await locationService.getUserCurrentLocation();
      }
      try {
        BranchService branchService = BranchService();
        final result = await branchService.getSearchBranches(null, 3, current);
        if (result['statusCode'] == 200) {
          if (isCheckLoadMore || isFindBranchNear) {
            branchesForCity!.addAll(result['data'] as List<BranchModel>);
          } else {
            branchesForCity = [];
            branchesForCity!.addAll(result['data'] as List<BranchModel>);
          }

          currentResult = result['current'];
          totalPages = result['totalPages'];
          branchesForCity!.removeWhere((branch) {
            String distanceText = branch.distanceKilometer!
                .substring(branch.distanceKilometer!.indexOf(" ") + 1);
            double distanceValue = double.parse(
                branch.distanceKilometer!.replaceAll(RegExp(r'[^0-9.]'), ''));

            if (distanceText == 'm') {
              return false;
            } else if (distanceValue <= 5) {
              return false;
            } else {
              return true;
            }
          });
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
          for (BranchModel branch in branchesForCity!) {
            try {
              var reference = storage.ref('${branch.thumbnailUrl}');
              branch.branchDisplayList![0].url =
                  await reference.getDownloadURL();
            } catch (e) {
              final random = Random();
              var randomUrl = random.nextInt(urlList.length);
              var reference = storage.ref('branch/${urlList[randomUrl]}');
              branch.branchDisplayList![0].url =
                  await reference.getDownloadURL();
            }
          }

          if (branchesForCity!.length < 3) {
            current = currentResult;
            current = current + 1;
            if (current <= totalPages) {
              isFindBranchNear = true;
              searchBranchesWithLocation();
            } else {
              isFindBranchNear = false;
            }
          } else {
            isFindBranchNear = false;
            isCheckLoadMore = false;
          }
          if (!_isDisposed && mounted) {
            setState(() {
              branchesForCity;
              isLoading = false;
            });
          }
        } else {
          print("$result['statusCode'] : $result['error']");
        }
      } on Exception catch (e) {
        print(e.toString());
        print("Error: $e");
        isFindBranchNear = false;
        isCheckLoadMore = false;
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  IconButton? buildSuffixIcon(controller, focusNode) {
    return isSearching || focusNode.hasFocus
        ? IconButton(
            onPressed: () {
              setState(() {
                controller.clear();
                isSearching = false;
              });
            },
            icon: const Icon(Icons.clear),
          )
        : null;
  }

  String displayStringForOption(BranchModel branch) =>
      utf8.decode(branch.address!.runes.toList());
  Iterable<BranchModel>? options;
  BranchModel branchModel = BranchModel();
  BranchesModel branchesModel = BranchesModel();

  BranchModel selectedBranch = BranchModel();

  LocationService locationService = LocationService();
  Position? position;

  final storage = FirebaseStorage.instance;
  List<String> urlList = [
    "barber1.jpg",
    "barber2.jpg",
    "barber3.jpg",
  ];

// Button "Chọn" call API get branch by ID
  Future<void> getBranchById(
      int? branchId, ChangeNotifierServices selectedProvider) async {
    if (!_isDisposed && mounted) {
      try {
        BranchService branchService = BranchService();
        final result = await branchService.getBranchId(branchId!, true);
        if (result['statusCode'] == 200) {
          selectedBranch = result['data'] as BranchModel;

          setState(() {
            selectedBranch;
            selectedProvider.updateSelectedBranch(selectedBranch);
            Navigator.pop(context, selectedBranch);
          });
        } else {
          print("$result['statusCode'] : $result['error']");
        }
      } on Exception catch (e) {
        print(e.toString());
        print("Error: $e");
      }
    }
  }

  int current = 1;
  int currentResult = 0;
  int totalPages = 0;
  bool isCheckLoadMore = false;
  void checkLoadMore() async {
    isCheckLoadMore = true;
    current = currentResult;
    current = current + 1;
    if (current <= totalPages) {
      await searchBranchesWithLocation();
    }
  }

  int count = 0;
}
