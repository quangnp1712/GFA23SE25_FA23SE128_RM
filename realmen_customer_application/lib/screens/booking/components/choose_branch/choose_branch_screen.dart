import 'dart:convert';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:realmen_customer_application/models/branch/branch_model.dart';
import 'package:realmen_customer_application/screens/message/success_screen.dart';
import 'package:realmen_customer_application/service/branch/branch_service.dart';
import 'package:realmen_customer_application/service/change_notifier_provider/change_notifier_provider_service.dart';
import 'package:realmen_customer_application/service/location/location_service.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';
import 'package:sizer/sizer.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

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
                                        "chọn chi nhánh".toUpperCase(),
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
                          const SizedBox(
                            height: 30,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "HỆ THỐNG CHI NHÁNH CỦA REALMEN",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      "Tính đến hiện tại, chuỗi barber tóc nam RealMen có 99 barber tại những vị trí đắc địa nhất TP. Hồ Chí Minh, Hà Nội và các tỉnh lân cận. Hãy tìm đến barber RealMen gần bạn nhất để tận hưởng trải nghiệm cắt tóc nam đỉnh cao!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
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
                                  _searchingWithQuery = textEditingValue.text;
                                  if (textEditingValue.text.isEmpty ||
                                      textEditingValue.text == '') {
                                    return const Iterable.empty();
                                  }
                                  if (cityController == "Thành Phố/Tỉnh") {
                                    final value = await BranchService()
                                        .getSearchBranches(
                                            textEditingValue.text, 5);
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
                                          ?.add(address);
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
                                        searchBranches(value, focusNode);
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
                                        hintText:
                                            "Tìm kiếm tên chi nhánh và địa điểm",
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
                                      offset: Offset(0,
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
                                        "Tìm chi nhánh gần anh",
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
                                    items: cities != null && cities.length != 0
                                        ? cities!
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

                                      getBranches(city);
                                    }),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 160,
                                      width: 160,
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
                          branchesForCity != null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: branchesForCity?.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      // height: 210,
                                      // width: double.infinity,
                                      child: Column(
                                        children: [
                                          FutureBuilder(
                                            future: getImageFB(
                                                branchesForCity![index]),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<Widget>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.done) {
                                                if (snapshot.hasData) {
                                                  return Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            minHeight: 140),
                                                    child: snapshot.data!,
                                                  ); // Return the widget when the future is complete
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
                                                            color: Colors.black
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
                                              padding:
                                                  const EdgeInsets.only(top: 4),
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
                                                color: Color(0xffE3E3E3),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(4),
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .shade800, // Màu của bóng
                                                    offset: Offset(0,
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
                                                style: ElevatedButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  shape: RoundedRectangleBorder(
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
                                          (index != branchesForCity!.length - 1)
                                              ? const Divider(
                                                  color: Color(0x73444444),
                                                  height: 1,
                                                  thickness: 1,
                                                )
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                    );
                                  },
                                )
                              : Container(),
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
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    focusNode.dispose();
    _isDisposed = true;
    super.dispose();
  }

  String image = "assets/images/branch1.png";
  BranchesModel? branchesByCityModel = BranchesModel();
  List<BranchModel>? branchesForCity;
  String? cityController;
  List<String> cities = [];
  Future<void> getBranchesByCity() async {
    if (!_isDisposed) {
      try {
        BranchService branchService = BranchService();
        final result = await branchService.getBranchesByCity();
        if (result['statusCode'] == 200) {
          branchesByCityModel = result['data'] as BranchesModel;
          try {
            if (branchesByCityModel != null) {
              if (cityController != null) {
                getBranches(cityController!);
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
          if (!_isDisposed) {
            setState(() {
              cities;
            });
          }
        } else {
          print("$result['statusCode'] : $result['error']");
        }
      } on Exception catch (e) {
        print(e.toString());
        print("Error: $e");
      }
    }
  }

  getBranches(String search) async {
    if (!_isDisposed) {
      branchesForCity = [];
      try {
        BranchService branchService = BranchService();
        final result = await branchService.getBranches(search, 10);
        if (result['statusCode'] == 200) {
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
        }

        setState(() {
          branchesForCity;
        });
      } on Exception catch (e) {
        print(e.toString());
        print("Error: $e");
      }
    }
  }

  bool isSearching = false;
  FocusNode focusNode = FocusNode();
  FocusScopeNode focusScopeNode = FocusScopeNode();

  Future<void> searchBranches(String query, FocusNode focusNode) async {
    if (!_isDisposed) {
      try {
        BranchService branchService = BranchService();
        final result = await branchService.getSearchBranches(query, 10);
        if (result['statusCode'] == 200) {
          branchesForCity = [];
          branchesForCity = result['data'] as List<BranchModel>;

          setState(() {
            branchesForCity;
            isSearching = true;
            focusNode.unfocus();
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

  Future<void> searchBranchesWithLocation() async {
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
          print("$result['statusCode'] : $result['error']");
        }
      } on Exception catch (e) {
        print(e.toString());
        print("Error: $e");
      }
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
  String? _searchingWithQuery;
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
  Future<Widget> getImageFB(BranchModel branch) async {
    try {
      var reference = storage.ref('branch/${branch!.thumbnailUrl}');
      return Image.network(
        await reference.getDownloadURL(),
        scale: 1,
        width: MediaQuery.of(context).size.width / 1.2,
        height: 140,
        fit: BoxFit.cover,
      );
    } catch (e) {
      final _random = new Random();
      var randomUrl = _random.nextInt(urlList.length);
      var reference = storage.ref('branch/${urlList[randomUrl]}');
      return Image.network(
        await reference.getDownloadURL(),
        scale: 1,
        width: MediaQuery.of(context).size.width / 1.2,
        height: 140,
        fit: BoxFit.cover,
      );
    }
  }

// Button "Chọn" call API get branch by ID
  Future<void> getBranchById(
      int? branchId, ChangeNotifierServices selectedProvider) async {
    if (!_isDisposed && mounted) {
      try {
        BranchService branchService = BranchService();
        final result = await branchService.getBranchId(branchId!);
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
}
