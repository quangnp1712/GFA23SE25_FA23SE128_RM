// ignore_for_file: constant_identifier_names, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, avoid_print

import 'dart:convert';

// import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:realmen_customer_application/models/account/account_info_model.dart';
import 'package:realmen_customer_application/screens/message/success_screen.dart';
import 'package:realmen_customer_application/service/account/account_service.dart';
import 'package:realmen_customer_application/service/change_notifier_provider/change_notifier_provider_service.dart';
import 'package:sizer/sizer.dart';

class ChooseStylistScreen extends StatefulWidget {
  const ChooseStylistScreen({super.key});

  @override
  State<ChooseStylistScreen> createState() => _ChooseStylistScreenState();
  static const String ChooseStylistScreenRoute = "/choose-stylist-screen";
}

class _ChooseStylistScreenState extends State<ChooseStylistScreen> {
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
                                    icon: const Icon(Icons.keyboard_arrow_left),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      "chọn stylist".toUpperCase(),
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
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Tìm kiếm tên Stylist",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(10.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       Container(
                        //         height: 40,
                        //         width: 190,
                        //         padding: const EdgeInsets.only(left: 5),
                        //         decoration: BoxDecoration(
                        //           border: Border.all(
                        //             color: Colors.black,
                        //           ),
                        //           borderRadius: BorderRadius.circular(4.0),
                        //         ),
                        //         child: DropdownButtonHideUnderline(
                        //           child: DropdownButton2<String>(
                        //             isExpanded: true,
                        //             alignment: Alignment.centerLeft,
                        //             value: _selectedOption,
                        //             onChanged: (String? newValue) {
                        //               setState(() {
                        //                 _selectedOption = newValue!;
                        //               });
                        //             },
                        //             items: <String>[
                        //               'Stylist theo lịch sử cắt',
                        //               'Stylist gần đây nhất',
                        //               'Stylist được cắt nhiều nhất',
                        //               'Tất cả stylist',
                        //             ].map<DropdownMenuItem<String>>(
                        //                 (String value) {
                        //               return DropdownMenuItem<String>(
                        //                 value: value,
                        //                 child: Padding(
                        //                   padding: const EdgeInsets.all(8.0),
                        //                   child: Text(
                        //                     value,
                        //                     style: const TextStyle(
                        //                         fontSize: 17,
                        //                         color: Colors.black,
                        //                         fontWeight: FontWeight.w400),
                        //                   ),
                        //                 ),
                        //               );
                        //             }).toList(),
                        //             dropdownStyleData: DropdownStyleData(
                        //               maxHeight: 160,
                        //               width: 170,
                        //               // padding: EdgeInsets.only(right: 5),
                        //               decoration: BoxDecoration(
                        //                 // borderRadius: BorderRadius.circular(14),
                        //                 color: Colors.grey.shade200,
                        //               ),
                        //               offset: const Offset(-5, -2),
                        //               scrollbarTheme: ScrollbarThemeData(
                        //                 // radius: const Radius.circular(40),
                        //                 // thickness: MaterialStateProperty.all(6),
                        //                 thumbVisibility:
                        //                     MaterialStateProperty.all(true),
                        //               ),
                        //             ),
                        //             menuItemStyleData: const MenuItemStyleData(
                        //               height: 40,
                        //               padding:
                        //                   EdgeInsets.only(left: 10, right: 14),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
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
                            : buildStylistList(staffList, selectedProvider),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget buildStylistList(
      List<AccountInfoModel> stylistDataList, var selectedProvider) {
    return Column(
      children: stylistDataList.map((stylistData) {
        return Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // anh avatar
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: CircleAvatar(
                        radius: 30,
                        child: ClipOval(
                          child: Image.asset(
                            // stylistData.thumbnailUrl!,
                            'assets/images/s1.jpg',
                            scale: 1,
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // tên stylist
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Stylist: ",
                                  style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "${utf8.decode(stylistData.firstName.toString().runes.toList())} ${utf8.decode(stylistData.lastName.toString().runes.toList())}",
                                  style: GoogleFonts.quicksand(
                                    textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //  rate
                          stylistData.staff!.averageRating != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Đánh giá: ",
                                            style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          TextSpan(
                                            text: stylistData
                                                .staff!.averageRating!
                                                .toString(),
                                            style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),

                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                stylistData.branch != null
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 1.0,
                            height: 16.0,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RichText(
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Chi nhánh:  ",
                                            style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          TextSpan(
                                            text: utf8.decode(stylistData
                                                .branch!.branchName
                                                .toString()
                                                .runes
                                                .toList()),
                                            style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 10),
                                    RichText(
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Địa chỉ:  ",
                                            style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          TextSpan(
                                            text: utf8.decode(stylistData
                                                .branch!.address
                                                .toString()
                                                .runes
                                                .toList()),
                                            style: GoogleFonts.quicksand(
                                              textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    // Các phần khác của Widget Column
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                        ],
                      )
                    : Container(),
                // _selectedOption != 'Tất cả stylist'
                //     ? Column(
                //         children: [
                //           const Divider(
                //             color: Colors.black,
                //             thickness: 1.0,
                //             height: 16.0,
                //           ),
                //           const SizedBox(
                //             height: 5,
                //           ),
                //           Row(
                //             children: [
                //               Expanded(
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   mainAxisAlignment: MainAxisAlignment.start,
                //                   children: [
                //                     const Text(
                //                       "Lịch Sử Cắt",
                //                       style: TextStyle(
                //                         fontSize: 18,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                     const SizedBox(height: 10),
                //                     RichText(
                //                       maxLines: 3,
                //                       overflow: TextOverflow.ellipsis,
                //                       text: TextSpan(
                //                         children: [
                //                           TextSpan(
                //                             text: "Chi nhánh:  ",
                //                             style: GoogleFonts.quicksand(
                //                               textStyle: const TextStyle(
                //                                   fontSize: 17,
                //                                   color: Colors.black,
                //                                   fontWeight: FontWeight.w400),
                //                             ),
                //                           ),
                //                           TextSpan(
                //                             text: stylistData['branch'],

                //                             //  "Cắt",
                //                             // utf8.decode(_selectedStylist!.name
                //                             //     .toString()
                //                             //     .runes
                //                             //     .toList()),
                //                             style: GoogleFonts.quicksand(
                //                               textStyle: const TextStyle(
                //                                   fontSize: 18,
                //                                   color: Colors.black,
                //                                   fontWeight: FontWeight.w400),
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                     ),
                //                     const SizedBox(height: 5),
                //                     // Các phần khác của Widget Column
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           ),
                //           const SizedBox(height: 5),
                //           stylistData['services'] != null
                //               ? Row(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     const Text(
                //                       "Dịch Vụ:",
                //                       style: TextStyle(
                //                           fontSize: 17,
                //                           color: Colors.black,
                //                           fontWeight: FontWeight.w400),
                //                     ),
                //                     const SizedBox(width: 8.0),
                //                     ...List.generate(
                //                       stylistData['services'].length,
                //                       (index) => Container(
                //                         margin: const EdgeInsets.only(
                //                             right:
                //                                 8.0), // Khoảng cách giữa các border
                //                         decoration: BoxDecoration(
                //                           border: Border.all(
                //                             color: Color(0xff888888),
                //                             width:
                //                                 1.0, // Độ rộng của đường viền
                //                           ),
                //                           borderRadius: const BorderRadius.all(
                //                               Radius.circular(4.0)),
                //                         ),
                //                         padding: const EdgeInsets.symmetric(
                //                           horizontal: 6.0,
                //                           vertical: 3.0,
                //                         ),
                //                         child: Text(
                //                             stylistData['services'][index]),
                //                       ),
                //                     ).toList(),
                //                   ],
                //                 )
                //               : Container(),
                //           const SizedBox(height: 10),
                //         ],
                //       )
                //     : Container(),
                // stylistData['images'] != null
                //     ? SizedBox(
                //         height: 120,
                //         child: ListView(
                //           scrollDirection: Axis.horizontal,
                //           children: [
                //             ...List.generate(
                //                 stylistData['images'].length,
                //                 (index) => Row(
                //                       children: [
                //                         Container(
                //                           width: 105,
                //                           height: 75,
                //                           margin: const EdgeInsets.only(
                //                               left: 0, right: 5),
                //                           child: Image.asset(
                //                             stylistData['images'][index],
                //                             width: 105.0,
                //                             height: 105.0,
                //                             fit: BoxFit.cover,
                //                           ),
                //                         ),
                //                       ],
                //                     )),
                //           ],
                //         ),
                //       )
                //     : Container(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 6,
                      child: ElevatedButton(
                        onPressed: () {
                          selectedProvider.updateSelectedStylist(stylistData);
                          Navigator.pop(context, stylistData);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          side: const BorderSide(
                            width: 2.0,
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Chọn",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    // const SizedBox(width: 20),
                    //  Expanded(
                    //         flex: 3,
                    //         child: Container(
                    //           // width: 100,

                    //           child: ElevatedButton(
                    //             onPressed: () {
                    //               // Define the action for the "Xem thêm" button
                    //             },
                    //             style: ElevatedButton.styleFrom(
                    //               foregroundColor: Colors.white,
                    //               backgroundColor: Colors.white,
                    //               shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(
                    //                   20.0,
                    //                 ),
                    //               ),
                    //             ),
                    //             child: const Text(
                    //               "Xem thêm",
                    //               style: TextStyle(color: Colors.black),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Logic
  @override
  void initState() {
    super.initState();
    getStaff();
  }

  // String _selectedOption = 'Stylist theo lịch sử cắt'; // Giá trị mặc định
  bool isLoading = true;
  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  List<AccountInfoModel> staffList = [];

  Future<void> getStaff() async {
    if (!_isDisposed && mounted) {
      try {
        int current = 1;
        int totalPages = 0;
        do {
          AccountService accountService = AccountService();
          staffList = [];
          final result = await accountService.getStaff(10, current, null);
          if (result['statusCode'] == 200) {
            staffList = result['data'] as List<AccountInfoModel>;
            current = result['current'];
            totalPages = result['totalPages'];
            staffList
                .removeWhere((staff) => staff.staff!.professional == 'MASSEUR');
            if (!_isDisposed && mounted) {
              setState(() {
                staffList;
                isLoading = false;
              });
            }
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

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }
}
