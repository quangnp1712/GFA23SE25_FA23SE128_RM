// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/models/booking/booking_model.dart';

import 'package:realmen_customer_application/screens/history_booking/detail_history_hair_cut_screen.dart';
import 'package:realmen_customer_application/screens/message/success_screen.dart';
import 'package:realmen_customer_application/service/authentication/authenticate_service.dart';
import 'package:realmen_customer_application/service/booking/booking_service.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';
import 'package:sizer/sizer.dart';

class HistoryBookingScreen extends StatefulWidget {
  const HistoryBookingScreen({super.key});

  @override
  State<HistoryBookingScreen> createState() => _HistoryBookingScreenState();
  static const String HistoryBookingScreenRoute = "/history-booking-screen";
}

class _HistoryBookingScreenState extends State<HistoryBookingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
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
                  child: ListView(
                    controller: _scrollController,
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
                                  icon: const Icon(Icons.keyboard_arrow_left),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 50,
                                child: Center(
                                  child: Text(
                                    "Lịch sử đặt lịch".toUpperCase(),
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
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 85.8.h,
                                    child: ListView.builder(
                                      // controller: _scrollController,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: bookings
                                          .length, // Số lượng thẻ lịch sử cắt tóc
                                      itemBuilder: (context, index) {
                                        return Card(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                          Icons.home,
                                                          color: Colors.red,
                                                          size: 26,
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  utf8.decode(bookings[
                                                                          index]
                                                                      .branchName
                                                                      .toString()
                                                                      .runes
                                                                      .toList()),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 2),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      bookings[index]
                                                                              .appointmentDate ??
                                                                          "",
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          color:
                                                                              Colors.black54),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    Text(
                                                                        bookings[index]
                                                                            .bookingServices!
                                                                            .first
                                                                            .startTime
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                16,
                                                                            color:
                                                                                Colors.black54)),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          "assets/images/admin.png",
                                                          height: 170,
                                                          width: 140,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(9),
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  // Text(
                                                                  //     "Code: ${bookings[index].bookingCode} "),
                                                                  // const SizedBox(
                                                                  //     height:
                                                                  //         10),
                                                                  Row(
                                                                    children: [
                                                                      const Text(
                                                                          "Stylist:"),
                                                                      const SizedBox(
                                                                          width:
                                                                              2),
                                                                      Text(
                                                                          stylist)
                                                                    ],
                                                                  ),

                                                                  const SizedBox(
                                                                      height:
                                                                          10),

                                                                  Row(
                                                                    children: [
                                                                      const Text(
                                                                          "Massuer:"),
                                                                      const SizedBox(
                                                                          width:
                                                                              2),
                                                                      Text(
                                                                          massuer)
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          10),

                                                                  Row(
                                                                    children: [
                                                                      const Text(
                                                                          "Tổng hóa đơn:"),
                                                                      const SizedBox(
                                                                          width:
                                                                              2),
                                                                      totals[index]['bookingId'] ==
                                                                              bookings[index].bookingId
                                                                          ? Text(
                                                                              formatter.format(totals[index]['total']),
                                                                            )
                                                                          : Text("0"),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      height:
                                                                          25),
                                                                  ElevatedButton(
                                                                    onPressed: () =>
                                                                        Get.to(() =>
                                                                            DetailHistoryBookingScreen(booking: bookings[index])),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          Colors
                                                                              .black,
                                                                    ),
                                                                    child:
                                                                        const Text(
                                                                      'Xem chi tiết ->',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ))
      ],
    )

        //  SingleChildScrollView(
        //   child: Column(
        //     children: [
        //       Container(
        //         child: const Padding(
        //           padding: EdgeInsets.all(16.0),
        //           child: CardHistoryHairCut(),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }

  @override
  void initState() {
    super.initState();
    checkLoadMore();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // Khi scroll tới dưới cùng
        checkLoadMore();
      }
    });
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void didUpdateWidget(HistoryBookingScreen oldWidget) {
    setState(() {
      build(context);
      current;
    });

    super.didUpdateWidget(oldWidget);
  }

  NumberFormat formatter = NumberFormat("#,##0");
  double total = 0;

  bool isLoading = true;
  List<BookingContent> bookings = [];
  String stylist = 'Đang đợi update APi';
  String massuer = 'Đang đợi update APi';
  int current = 0;
  int currentResult = 0;
  int totalPages = 0;

  Future<void> getBookingPending(int current) async {
    if (!_isDisposed && mounted) {
      try {
        int accountId = await SharedPreferencesService.getAccountId();
        if (accountId != 0) {
          BookingModel bookingModel = BookingModel();

          final result =
              await BookingService().getBooking(accountId, current, 2);
          if (result['statusCode'] == 200) {
            bookingModel = result['data'] as BookingModel;
            currentResult = result['current'];
            totalPages = result['totalPages'];
            if (bookingModel.content!.isNotEmpty) {
              for (var content in bookingModel.content!) {
                bookings.add(content);
              }
              for (var booking in bookings) {
                total = 0;
                try {
                  DateTime date = DateTime.parse(booking.appointmentDate!);
                  booking.appointmentDate = formatDate(date);
                  if (booking.bookingServices != null) {
                    for (var service in booking.bookingServices!) {
                      if (service.servicePrice != null) {
                        total += double.parse(service.servicePrice.toString());
                      } else {
                        total = 0;
                      }
                    }
                    totals
                        .add({'bookingId': booking.bookingId, 'total': total});
                  } else {
                    total = 0;
                    totals
                        .add({'bookingId': booking.bookingId, 'total': total});
                  }
                } on Exception catch (e) {
                  // TODO
                  totals.add({'bookingId': 0, 'total': 0});
                }
              }

              if (!_isDisposed && mounted) {
                setState(() {
                  bookings;
                  totals;
                  isLoading = false;
                  // current;
                });
              }
            } else {
              if (!_isDisposed && mounted) {
                setState(() {
                  bookings;
                  // current;
                });
              }
            }
          } else if (result['statusCode'] == 500) {
            _errorMessage(result['error']);
          } else if (result['statusCode'] == 403) {
            _errorMessage(result['error']);
            AuthenticateService authenticateService = AuthenticateService();
            authenticateService.logout();
          } else {
            print("$result");
          }
        }
      } on Exception catch (e) {
        print(e.toString());
        print("Error: $e");
      }
    }
  }

  void checkLoadMore() async {
    current = currentResult;
    current = current + 1;
    if (totalPages == 0) {
      await getBookingPending(current);
    } else {
      if (current <= totalPages) {
        await getBookingPending(current);
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
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> totals = [];
}
