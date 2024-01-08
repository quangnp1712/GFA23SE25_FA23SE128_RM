import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import 'package:realmen_staff_application/models/booking/booking_model.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ServiceBookingProcessingScreen extends StatefulWidget {
  final BookingServiceModel? service;
  final int? index;
  String? bookingCode;
  String? appointmentDate;
  String? startAppointment;
  String? bookingOwnerName;
  String? phone;
  ServiceBookingProcessingScreen({
    Key? key,
    this.service,
    this.index,
    this.bookingCode,
    this.appointmentDate,
    this.startAppointment,
    this.bookingOwnerName,
    this.phone,
  }) : super(key: key);

  @override
  State<ServiceBookingProcessingScreen> createState() =>
      _ServiceBookingProcessingScreenState();
  static const String ServiceBookingProcessingScreenRoute =
      "/history-customer-processing-screen";
}

class _ServiceBookingProcessingScreenState
    extends State<ServiceBookingProcessingScreen> {
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
                    padding: const EdgeInsets.only(top: 15, left: 0),
                    width: 90.w,
                    height: 90.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 7),
                            child: Center(
                              child: Stack(
                                // mainAxisAlignment: MainAxisAlignment.center,
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
                                        Get.back();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "đang phục vụ".toUpperCase(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Đơn cắt:  ${widget.bookingCode}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Ngày:  ${widget.appointmentDate}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Giờ:  ${widget.startAppointment}",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
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
                                        widget.bookingOwnerName!,
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
                                        widget.phone!,
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
                                const SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Dịch Vụ đang phục vụ: ".toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
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
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: TimelineTile(
                                    // false la hien thanh

                                    isLast: false,
                                    beforeLineStyle: LineStyle(
                                        color: Colors.transparent,
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
                                          color: Colors.grey.shade300,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${widget.index! + 1}",
                                            style: TextStyle(
                                                color: Colors.black,
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
                                              utf8.decode(widget
                                                  .service!.serviceName!
                                                  .toString()
                                                  .runes
                                                  .toList()),
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "thời gian phục vụ: ".toUpperCase(),
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
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
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    10,
                                                child: Icon(
                                                  Icons.timer,
                                                  size: 24,
                                                ),
                                              ),
                                              Container(
                                                color: Colors.amberAccent,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Text(
                                                  "Thời gian tiêu chuẩn:",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Container(
                                                color: Colors.purpleAccent,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                child: Text(
                                                  widget.startAppointment!,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    10,
                                                child: Icon(
                                                  Icons.schedule,
                                                  size: 24,
                                                  color: Color(0xff207A20),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Text(
                                                  "Thời gian đã làm:",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xff207A20)),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                child: Center(
                                                  child: StreamBuilder(
                                                    stream: Stream.periodic(
                                                        Duration(seconds: 1)),
                                                    builder:
                                                        (context, snapshot) {
                                                      DateTime now =
                                                          DateTime.now();
                                                      DateTime elevenAM =
                                                          startTime;
                                                      Duration difference = now
                                                          .difference(elevenAM);
                                                      int seconds =
                                                          difference.inSeconds %
                                                              60;
                                                      int minutes = (difference
                                                                  .inSeconds ~/
                                                              60) %
                                                          60;
                                                      int hours =
                                                          difference.inHours;
                                                      return Text(
                                                          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}');
                                                    },
                                                  ),
                                                ),
                                                // Text(
                                                //   widget.startAppointment!,
                                                //   style: TextStyle(
                                                //       fontSize: 20,
                                                //       fontWeight:
                                                //           FontWeight.bold,
                                                //       color: Color(0xff207A20)),
                                                // ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black45,
                                      border: Border.all(
                                        color: Colors.black54,
                                        width: 1,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.all(10),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Center(
                                      child: Text(
                                        "hoàn thành".toUpperCase(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 25),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

  DateTime startTime = DateTime.now();
}
