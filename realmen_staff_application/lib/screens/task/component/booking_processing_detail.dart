import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:realmen_staff_application/models/account/account_info_model.dart';
import 'package:realmen_staff_application/models/booking/booking_model.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/screens/task/booking_processing.dart';
import 'package:realmen_staff_application/screens/task/component/add_more_service_screen.dart';
import 'package:realmen_staff_application/screens/task/component/history_customer_processing.dart';
import 'package:realmen_staff_application/screens/task/component/popup_confirm.dart';
import 'package:realmen_staff_application/screens/task/service_booking_processing.dart';
import 'package:realmen_staff_application/service/account/account_info_service.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';
import 'package:timeline_tile/timeline_tile.dart';

class BookingProcessingDetail extends StatefulWidget {
  final BookingContent booking;
  const BookingProcessingDetail({required this.booking, super.key});

  @override
  State<BookingProcessingDetail> createState() =>
      _BookingProcessingDetailState();
}

class _BookingProcessingDetailState extends State<BookingProcessingDetail>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return isLoading
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
        : Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Đơn cắt:  ${widget.booking.bookingCode}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Ngày:  ${widget.booking.appointmentDate}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Giờ:  ${widget.booking.bookingServices!.first.startAppointment}",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 120,
                            child: const Text(
                              "Khách hàng: ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              utf8.decode(widget.booking.bookingOwnerName
                                  .toString()
                                  .runes
                                  .toList()),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
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
                            width: 120,
                            child: const Text(
                              "Số điện thoại: ",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 200,
                            child: Text(
                              phone,
                              textAlign: TextAlign.left,
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
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
                                      decorationStyle:
                                          TextDecorationStyle.solid),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Dịch vụ: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
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
                                  Get.to(() => AddMoreServiceScreen(
                                      widget.booking.bookingServices!));
                                });
                              },
                              child: const Center(
                                child: Text(
                                  " + Thêm dịch vụ ",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
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
                      masseurServices.isNotEmpty
                          ? Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(minHeight: 40),
                                  color: Colors.grey.shade300,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 245),
                                        child: Text(
                                          "Massuer:  ${utf8.decode(masseurServices.first.staffName!.toString().runes.toList())} ",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1),
                                        ),
                                      ),

                                      // status tổng dành cho massa
                                      Center(
                                        child: Container(
                                          width: 100,
                                          height: 30,
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          decoration: BoxDecoration(
                                            // color: Color(0xff207A20),
                                            color: isMasseurServicesDone ==
                                                    "CHƯA LÀM"
                                                ? Colors.white
                                                : (isMasseurServicesDone ==
                                                        "ĐANG LÀM"
                                                    ? Colors.amberAccent
                                                    : const Color(0xff207A20)),
                                            border: Border.all(
                                                color: Colors.black54,
                                                style: BorderStyle.solid),
                                          ),
                                          child: Center(
                                            child: Text(
                                              isMasseurServicesDone!,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                // color: Colors.white,
                                                color: isMasseurServicesDone !=
                                                        "HOÀN THÀNH"
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
                                          color: index + 1 !=
                                                  masseurServices.length
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
                                            color: masseurServices[index]
                                                        .bookingServiceStatus ==
                                                    "ONGOING"
                                                ? Colors.grey.shade300
                                                : (masseurServices[index]
                                                            .bookingServiceStatus ==
                                                        "PROCESSING"
                                                    ? Colors.amberAccent
                                                    : const Color(0xff207A20)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                  color: masseurServices[index]
                                                              .bookingServiceStatus ==
                                                          "FINISHED"
                                                      ? Colors.white
                                                      : Colors.black,
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
                                            top: 10, right: 0, left: 10),
                                        constraints:
                                            const BoxConstraints(minHeight: 80),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 194),
                                              child: Text(
                                                utf8.decode(
                                                    masseurServices[index]
                                                        .serviceName
                                                        .toString()
                                                        .runes
                                                        .toList()),
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              width: 106,
                                              height: 40,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                // color: Color(0xff207A20),
                                                color: masseurServices[index]
                                                            .bookingServiceStatus ==
                                                        "ONGOING"
                                                    ? Colors.white
                                                    : (masseurServices[index]
                                                                .bookingServiceStatus ==
                                                            "PROCESSING"
                                                        ? Colors.amberAccent
                                                        : const Color(
                                                            0xff207A20)),
                                                border: Border.all(
                                                    color: Colors.black54,
                                                    style: BorderStyle.solid),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  masseurServices[index]
                                                              .bookingServiceStatus ==
                                                          "ONGOING"
                                                      ? "CHƯA LÀM"
                                                      : (masseurServices[index]
                                                                  .bookingServiceStatus ==
                                                              "PROCESSING"
                                                          ? "ĐANG LÀM"
                                                          : "HOÀN THÀNH"),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    // color: Colors.white,
                                                    color: masseurServices[
                                                                    index]
                                                                .bookingServiceStatus ==
                                                            "FINISHED"
                                                        ? Colors.white
                                                        : Colors.black,
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
                      stylistServices.isNotEmpty
                          ? Column(
                              children: [
                                Container(
                                  constraints: BoxConstraints(minHeight: 40),
                                  color: Colors.grey.shade300,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        constraints:
                                            BoxConstraints(maxWidth: 245),
                                        child: Text(
                                          "Stylist: ${utf8.decode(stylistServices.first.staffName!.toString().runes.toList())}",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          width: 100,
                                          height: 30,
                                          margin:
                                              const EdgeInsets.only(right: 5),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          decoration: BoxDecoration(
                                            // color: Color(0xff207A20),
                                            color: isStylistServicesDone ==
                                                    "CHƯA LÀM"
                                                ? Colors.white
                                                : (isStylistServicesDone ==
                                                        "ĐANG LÀM"
                                                    ? Colors.amberAccent
                                                    : const Color(0xff207A20)),
                                            border: Border.all(
                                                color: Colors.black54,
                                                style: BorderStyle.solid),
                                          ),
                                          child: Center(
                                            child: Text(
                                              isStylistServicesDone!,
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                // color: Colors.white,
                                                color: isStylistServicesDone ==
                                                        "CHƯA LÀM"
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
                                          color: index + 1 !=
                                                  stylistServices.length
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
                                            color: stylistServices[index]
                                                        .bookingServiceStatus ==
                                                    "ONGOING"
                                                ? Colors.grey.shade300
                                                : (stylistServices[index]
                                                            .bookingServiceStatus ==
                                                        "PROCESSING"
                                                    ? Colors.amberAccent
                                                    : const Color(0xff207A20)),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "${index + 1}",
                                              style: TextStyle(
                                                  color: stylistServices[index]
                                                              .bookingServiceStatus ==
                                                          "FINISHED"
                                                      ? Colors.white
                                                      : Colors.black,
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
                                            top: 10, right: 0, left: 10),
                                        constraints:
                                            const BoxConstraints(minHeight: 80),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              constraints:
                                                  BoxConstraints(maxWidth: 194),
                                              child: Text(
                                                utf8.decode(
                                                    stylistServices[index]
                                                        .serviceName!
                                                        .toString()
                                                        .runes
                                                        .toList()),
                                                style: const TextStyle(
                                                    fontSize: 20),
                                              ),
                                            ),
                                            Container(
                                              width: 106,
                                              height: 40,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                // color: Color(0xff207A20),
                                                color: stylistServices[index]
                                                            .bookingServiceStatus ==
                                                        "ONGOING"
                                                    ? Colors.white
                                                    : (stylistServices[index]
                                                                .bookingServiceStatus ==
                                                            "PROCESSING"
                                                        ? Colors.amberAccent
                                                        : const Color(
                                                            0xff207A20)),
                                                border: Border.all(
                                                    color: Colors.black54,
                                                    style: BorderStyle.solid),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  stylistServices[index]
                                                              .bookingServiceStatus ==
                                                          "ONGOING"
                                                      ? "CHƯA LÀM"
                                                      : (stylistServices[index]
                                                                  .bookingServiceStatus ==
                                                              "PROCESSING"
                                                          ? "ĐANG LÀM"
                                                          : "HOÀN THÀNH"),
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    // color: Colors.white,
                                                    color: stylistServices[
                                                                    index]
                                                                .bookingServiceStatus ==
                                                            "FINISHED"
                                                        ? Colors.white
                                                        : Colors.black,
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
                        btn,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    setDataBooking();
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  // @override
  // void didUpdateWidget(BookingProcessingDetail oldWidget) {
  //   setDataBooking();
  //   super.didUpdateWidget(oldWidget);
  // }

  List<BookingServiceModel> masseurServices = [];

  List<BookingServiceModel> stylistServices = [];

  Future<void> _popup() async {
    if (!_isDisposed && mounted) {
      int index = 0;
      if (!checkServiceBookingIsProcessing) {
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
            if (professional == "MASSEUR") {
              for (var service in masseurServices) {
                if (service.bookingServiceStatus == "ONGOING") {
                  index = masseurServices.indexOf(service) + 1;
                  return PopUpConfirm(
                    service: service,
                    index: index,
                    bookingId: widget.booking.bookingId,
                  );
                }
              }
            } else if (professional == "STYLIST") {
              for (var service in stylistServices) {
                if (service.bookingServiceStatus == "ONGOING") {
                  index = stylistServices.indexOf(service) + 1;
                  return PopUpConfirm(
                    service: service,
                    index: index,
                    bookingId: widget.booking.bookingId,
                  );
                }
              }
            }
            return Container(
              width: 0,
              height: 0,
            );
          },
        );
      } else {
        if (professional == "MASSEUR") {
          for (var service in masseurServices) {
            if (service.bookingServiceStatus == "PROCESSING") {
              index = masseurServices.indexOf(service) + 1;
            }
          }
        } else if (professional == "STYLIST") {
          for (var service in stylistServices) {
            if (service.bookingServiceStatus == "PROCESSING") {
              index = stylistServices.indexOf(service) + 1;
            }
          }
        }
        Get.to(() => ServiceBookingProcessingScreen(
              bookingId: widget.booking.bookingId,
              professional: professional,
              index: index,
            ));
      }
    }
  }

  String phone = '';
  String? isMasseurServicesDone;
  String? isStylistServicesDone;
  bool isLoading = true;
  bool checkServiceBookingIsProcessing = false;
  bool checkBookingIsDone = false;
  List<Map<String, dynamic>> btnStatus = [
    {"key": 1, "value": "bắt đầu phục vụ".toUpperCase()},
    {"key": 2, "value": "tiếp tục".toUpperCase()},
    {"key": 3, "value": "hoàn tất, chuyển qua stylist".toUpperCase()},
    {"key": 4, "value": "hoàn tất, chuyển qua MASSEUR".toUpperCase()},
    {"key": 4, "value": "Thanh toán".toUpperCase()},
  ];
  Map<String, dynamic> btn = btnStatus[0];
  Future<void> setDataBooking() async {
    try {
      isLoading = true;

      // professional
      professional = await SharedPreferencesService.getProfessional();
      // date
      DateTime appointmentDate =
          DateTime.parse(widget.booking.appointmentDate!);
      widget.booking.appointmentDate = formatDate(appointmentDate);

      // phone
      phone = widget.booking.bookingOwnerPhone!;
      phone = "x" * (phone.length - 3) + phone.substring(phone.length - 3);

      // masseurServices + stylistServices
      for (var bookingService in widget.booking.bookingServices!) {
        if (bookingService.professional == "MASSEUR") {
          masseurServices.add(bookingService);
        } else if (bookingService.professional == "STYLIST") {
          stylistServices.add(bookingService);
        }
      }
      if (masseurServices.isNotEmpty) {
        for (var service in masseurServices) {
          if (service.bookingServiceStatus == "ONGOING") {
            isMasseurServicesDone = "CHƯA LÀM";
          } else if (service.bookingServiceStatus == "PROCESSING") {
            isMasseurServicesDone = "ĐANG LÀM";
          } else if (service.bookingServiceStatus == "FINISHED") {
            isMasseurServicesDone = "HOÀN THÀNH";
          }
        }
      }
      if (stylistServices.isNotEmpty) {
        for (var service in stylistServices) {
          if (service.bookingServiceStatus == "ONGOING") {
            isStylistServicesDone = "CHƯA LÀM";
          } else if (service.bookingServiceStatus == "PROCESSING") {
            isStylistServicesDone = "ĐANG LÀM";
          } else if (service.bookingServiceStatus == "FINISHED") {
            isStylistServicesDone = "HOÀN THÀNH";
          }
        }
      }

      // checkServiceBookingIsProcessing
      checkServiceBookingIsProcessing = widget.booking.bookingServices!
          .any((service) => service.bookingServiceStatus == "PROCESSING");

      // checkBookingIsDone
      if (isStylistServicesDone == "HOÀN THÀNH" &&
          isMasseurServicesDone == "HOÀN THÀNH") {
        checkBookingIsDone = true;
      } else {
        checkBookingIsDone = false;
      }
      // checkServiceBookingIsProcessing = true ? "tiếp tục" : "bắt đầu phục vụ"
      // isStylistServicesDone or isMasseurServicesDone == "HOÀN THÀNH"
      //kiểm tra dv của staff đó đã xong chưa
      // checkBookingIsDone = true kiểm tra cả đơn đó xong chưa

      if (checkServiceBookingIsProcessing) {
        btn = "tiếp tục".toUpperCase();
      } else {
        if (professional == "MASSEUR" &&
            isMasseurServicesDone == "HOÀN THÀNH" &&
            isStylistServicesDone != "HOÀN THÀNH") {
          btn = "hoàn tất, chuyển qua stylist".toUpperCase();
        } else if (professional == "STYLIST" &&
            isMasseurServicesDone != "HOÀN THÀNH" &&
            isStylistServicesDone == "HOÀN THÀNH") {
          btn = "hoàn tất, chuyển qua MASSEUR".toUpperCase();
        } else if (isMasseurServicesDone == "HOÀN THÀNH" &&
            isStylistServicesDone == "HOÀN THÀNH") {
          btn = "Thanh toán".toUpperCase();
        } else {
          btn = "bắt đầu phục vụ".toUpperCase();
        }
      }

      if (!_isDisposed && mounted) {
        setState(() {
          isLoading = false;
          professional;
        });
      }
    } on Exception catch (e) {
      print(e.toString());
      isLoading = true;
    }
  }

  String professional = '';

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

  formatDate(DateTime date) {
    String day = DateFormat('EEEE').format(date);
    day = formatDay(day);
    return "$day, ${DateFormat('dd/MM/yyyy').format(date)}";
  }

  String formatDay(String day) {
    return dayNames[day.toLowerCase()] ?? day;
  }

  final Map<String, String> dayNames = {
    'monday': 'Thứ hai',
    'tuesday': 'Thứ ba',
    'wednesday': 'Thứ tư',
    'thursday': 'Thứ năm',
    'friday': 'Thứ sáu',
    'saturday': 'Thứ bảy',
    'sunday': 'Chủ nhật'
  };
}

class BtnStatus {
  int? key;
  String? value;
  BtnStatus({this.key, this.value});
}
