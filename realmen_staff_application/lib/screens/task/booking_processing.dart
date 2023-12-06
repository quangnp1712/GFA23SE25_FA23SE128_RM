import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realmen_staff_application/screens/task/component/add_more_service_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:realmen_staff_application/screens/history_booking/history_booking_screen.dart';
import 'package:realmen_staff_application/screens/task/component/history_customer_processing.dart';
import 'package:realmen_staff_application/screens/task/component/popup_confirm.dart';

class BookingProcessingTab extends StatefulWidget {
  const BookingProcessingTab({super.key});

  @override
  State<BookingProcessingTab> createState() => _BookingProcessingTabState();
}

class _BookingProcessingTabState extends State<BookingProcessingTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Đơn cắt:  Thứ 2, 27/11/2023  12:00",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      child: const Text(
                        "Khách hàng: ",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      child: const Text(
                        " Le Anh Tuan  -  Lv 1",
                        maxLines: 2,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      child: const Text(
                        "Số điện thoại: ",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                      child: const Text(
                        "xxxxxx1487",
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Get.to(const HistoryCustomerProcessingScreen());
                    },
                    child: const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Xem lịch sử",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.blueAccent,
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Dịch vụ: ",
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black54,
                          border: Border.all(
                            color: Colors.black54,
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      // margin: const EdgeInsets.all(10),
                      child: TextButton(
                        style: const ButtonStyle(
                          alignment: Alignment.center,
                          padding: MaterialStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 5),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            Get.to(() => AddMoreServiceScreen(bookingServices));
                          });
                        },
                        child: const Center(
                          child: Text(
                            " + Thêm dịch vụ ",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Divider(
                    color: Colors.black,
                    height: 2,
                    thickness: 1,
                  ),
                ),
                // Container(
                //   // padding: EdgeInsets.all(12.0),
                //   child: ListView.builder(
                //     shrinkWrap: true,
                //     physics: const NeverScrollableScrollPhysics(),
                //     itemCount: 1, // The number of items in the list
                //     itemBuilder: (context, index) {
                //       // Return a Card widget for each item in the list
                //       return ExpansionTile(
                //         backgroundColor: Colors.transparent,
                //         initiallyExpanded: true,
                //         onExpansionChanged: (expanded) {
                //           expanded = false;
                //         },
                //         title: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             const Text(
                //               "Cắt tóc",
                //               style: TextStyle(fontSize: 20),
                //             ),
                //             Container(
                //               width: 100,
                //               padding: const EdgeInsets.symmetric(
                //                   horizontal: 5, vertical: 5),
                //               decoration: BoxDecoration(
                //                 // color: Color(0xff207A20),
                //                 color: isDone == false
                //                     ? Colors.white
                //                     : const Color(0xff207A20),
                //                 border: Border.all(
                //                     color: Colors.black54,
                //                     style: BorderStyle.solid),
                //               ),
                //               child: Center(
                //                 child: Text(
                //                   isDone == false ? "ĐANG LÀM" : "HOÀN THÀNH",
                //                   style: TextStyle(
                //                     fontSize: 14,
                //                     fontWeight: FontWeight.w700,
                //                     // color: Colors.white,
                //                     color: isDone == false
                //                         ? Colors.black
                //                         : Colors.white,
                //                   ),
                //                 ),
                //               ),
                //             )
                //           ],
                //         ),
                //         children: [
                //           ClipRRect(
                //             borderRadius: BorderRadius.circular(10),
                //             child: Container(
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(10),
                //               ),
                //               constraints: const BoxConstraints(minHeight: 100),
                //               child: Column(
                //                 children: [
                //                   Container(
                //                     child: ClipRRect(
                //                       borderRadius: BorderRadius.circular(10),
                //                       child: _selectedImage != null
                //                           ? Image.file(
                //                               _selectedImage!,
                //                               height: 200,
                //                               width: 200,
                //                               fit: BoxFit.cover,
                //                             )
                //                           : Container(),
                //                     ),
                //                   ),
                //                   Row(
                //                     mainAxisAlignment:
                //                         MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Expanded(
                //                         child: Container(
                //                           decoration: BoxDecoration(
                //                               border: Border.all(
                //                                 color: Colors.black54,
                //                                 width: 1,
                //                                 style: BorderStyle.solid,
                //                               ),
                //                               borderRadius:
                //                                   BorderRadius.circular(10)),
                //                           margin: const EdgeInsets.all(10),
                //                           child: TextButton(
                //                             onPressed: () {
                //                               _pickImageFromCamera();
                //                             },
                //                             child: const Center(
                //                               child: Text(
                //                                 "Chụp ảnh",
                //                                 style: TextStyle(fontSize: 20),
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                       Expanded(
                //                         child: Container(
                //                           decoration: BoxDecoration(
                //                               border: Border.all(
                //                                 color: Colors.black54,
                //                                 width: 1,
                //                                 style: BorderStyle.solid,
                //                               ),
                //                               borderRadius:
                //                                   BorderRadius.circular(10)),
                //                           margin: const EdgeInsets.all(10),
                //                           child: TextButton(
                //                             onPressed: () {
                //                               setState(() {
                //                                 isDone = true;
                //                               });
                //                             },
                //                             child: const Center(
                //                               child: Text(
                //                                 "Xác nhận",
                //                                 style: TextStyle(fontSize: 20),
                //                               ),
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           )
                //         ],
                //       );
                //     },
                //   ),
                // ),
                masseurServices != null && masseurServices.length > 0
                    ? Column(
                        children: [
                          Container(
                            height: 40,
                            color: Colors.grey.shade300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Massuer: Điều Thuyền ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
                                ),
                                Center(
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    margin: const EdgeInsets.only(right: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                      // color: Color(0xff207A20),
                                      color: isDone == false
                                          ? Colors.white
                                          : const Color(0xff207A20),
                                      border: Border.all(
                                          color: Colors.black54,
                                          style: BorderStyle.solid),
                                    ),
                                    child: Center(
                                      child: Text(
                                        isDone == false
                                            ? "ĐANG LÀM"
                                            : "HOÀN THÀNH",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          // color: Colors.white,
                                          color: isDone == false
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: masseurServices.length,
                            itemBuilder: (context, index) {
                              return TimelineTile(
                                // false la hien thanh

                                isLast: false,
                                beforeLineStyle: LineStyle(
                                    color: index + 1 != masseurServices.length
                                        ? Colors.black
                                        : Colors.transparent,
                                    thickness: 2),

                                // icon
                                indicatorStyle: IndicatorStyle(
                                  width: 35,
                                  height: 40,
                                  padding: const EdgeInsets.only(
                                      top: 4, bottom: 4, right: 5),
                                  indicator: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          masseurServices[index].status == false
                                              ? Colors.grey.shade300
                                              : const Color(0xff207A20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                            color:
                                                masseurServices[index].status ==
                                                        false
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  indicatorXY: 0.0,
                                ),

                                // content
                                endChild: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 15, left: 10),
                                  constraints:
                                      const BoxConstraints(minHeight: 80),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        masseurServices[index].name!,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Container(
                                        width: 110,
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        decoration: BoxDecoration(
                                          // color: Color(0xff207A20),
                                          color:
                                              masseurServices[index].status ==
                                                      false
                                                  ? Colors.white
                                                  : const Color(0xff207A20),
                                          border: Border.all(
                                              color: Colors.black54,
                                              style: BorderStyle.solid),
                                        ),
                                        child: Center(
                                          child: Text(
                                            masseurServices[index].status ==
                                                    false
                                                ? "ĐANG LÀM"
                                                : "HOÀN THÀNH",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              // color: Colors.white,
                                              color: masseurServices[index]
                                                          .status ==
                                                      false
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(
                  height: 15,
                ),
                stylistServices != null && stylistServices.length > 0
                    ? Column(
                        children: [
                          Container(
                            height: 40,
                            color: Colors.grey.shade300,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Stylist: Phương Quang",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
                                ),
                                Center(
                                  child: Container(
                                    width: 100,
                                    height: 30,
                                    margin: const EdgeInsets.only(right: 5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 5),
                                    decoration: BoxDecoration(
                                      // color: Color(0xff207A20),
                                      color: isDone == false
                                          ? Colors.white
                                          : const Color(0xff207A20),
                                      border: Border.all(
                                          color: Colors.black54,
                                          style: BorderStyle.solid),
                                    ),
                                    child: Center(
                                      child: Text(
                                        isDone == false
                                            ? "ĐANG LÀM"
                                            : "HOÀN THÀNH",
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          // color: Colors.white,
                                          color: isDone == false
                                              ? Colors.black
                                              : Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: stylistServices.length,
                            itemBuilder: (context, index) {
                              return TimelineTile(
                                // false la hien thanh

                                isLast: false,
                                beforeLineStyle: LineStyle(
                                    color: index + 1 != stylistServices.length
                                        ? Colors.black
                                        : Colors.transparent,
                                    thickness: 2),

                                // icon
                                indicatorStyle: IndicatorStyle(
                                  width: 35,
                                  height: 40,
                                  padding: const EdgeInsets.only(
                                      top: 4, bottom: 4, right: 5),
                                  indicator: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          stylistServices[index].status == false
                                              ? Colors.grey.shade300
                                              : const Color(0xff207A20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${index + 1}",
                                        style: TextStyle(
                                            color:
                                                stylistServices[index].status ==
                                                        false
                                                    ? Colors.black
                                                    : Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  indicatorXY: 0.0,
                                ),

                                // content
                                endChild: Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 15, left: 10),
                                  constraints:
                                      const BoxConstraints(minHeight: 80),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        stylistServices[index].name!,
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                      Container(
                                        width: 110,
                                        height: 40,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 5),
                                        decoration: BoxDecoration(
                                          // color: Color(0xff207A20),
                                          color:
                                              stylistServices[index].status ==
                                                      false
                                                  ? Colors.white
                                                  : const Color(0xff207A20),
                                          border: Border.all(
                                              color: Colors.black54,
                                              style: BorderStyle.solid),
                                        ),
                                        child: Center(
                                          child: Text(
                                            stylistServices[index].status ==
                                                    false
                                                ? "ĐANG LÀM"
                                                : "HOÀN THÀNH",
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700,
                                              // color: Colors.white,
                                              color: stylistServices[index]
                                                          .status ==
                                                      false
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //       color: Colors.black45,
                //       border: Border.all(
                //         color: Colors.black54,
                //         width: 1,
                //         style: BorderStyle.solid,
                //       ),
                //       borderRadius: BorderRadius.circular(10)),
                //   margin: const EdgeInsets.all(10),
                //   child: TextButton(
                //     onPressed: () {},
                //     child: Center(
                //       child: Text(
                //         "chuyển Massuer".toUpperCase(),
                //         style: const TextStyle(color: Colors.white, fontSize: 25),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: Colors.black54,
                  width: 1,
                  style: BorderStyle.solid,
                ),
                borderRadius: BorderRadius.circular(10)),
            // margin: const EdgeInsets.all(10),
            child: TextButton(
              onPressed: () {
                _popup();
              },
              child: Center(
                child: Text(
                  "tiếp tục".toUpperCase(),
                  style: const TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool isDone = false;
  @override
  bool get wantKeepAlive => true;

  File? _selectedImage;
  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> _popup() async {
    if (!_isDisposed) {
      return showModalBottomSheet(
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: false,
        context: context,
        backgroundColor: Colors.white,
        barrierColor: const Color(0x8c111111),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) {
          for (var service in masseurServices) {
            if (service.status == false) {
              return PopUpConfirm(
                  service: service, index: masseurServices.indexOf(service));
            }
          }
          return const PopUpConfirm(
            service: null,
            index: null,
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    masseurServices =
        bookingServices.where((service) => service.role == 1).toList();
    print(masseurServices);
    stylistServices =
        bookingServices.where((service) => service.role == 2).toList();
  }

  List<serviceDemoModel> masseurServices = [];

  List<serviceDemoModel> stylistServices = [];

  List<serviceDemoModel> bookingServices = [
    serviceDemoModel(name: "Cắt tóc", role: 2, status: false),
    serviceDemoModel(name: "Uốn", role: 2, status: true),
    serviceDemoModel(name: "Gội đầu", role: 1, status: false),
    serviceDemoModel(name: "Cạo mặt", role: 1, status: true),
    serviceDemoModel(name: "Massage", role: 1, status: false),
    serviceDemoModel(name: "Ráy tai", role: 1, status: true),
  ];
}

class serviceDemoModel {
  String? name;
  int? role;
  bool? status;
  serviceDemoModel({
    this.name,
    this.role,
    this.status,
  });
}
