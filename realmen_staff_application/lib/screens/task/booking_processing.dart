// ignore_for_file: unused_field, unused_element, sized_box_for_whitespace, avoid_print, camel_case_types

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:realmen_staff_application/models/booking/booking_model.dart';
import 'package:realmen_staff_application/screens/message/success_screen.dart';
import 'package:realmen_staff_application/screens/task/component/add_more_service_screen.dart';
import 'package:realmen_staff_application/screens/task/component/booking_processing_detail.dart';
import 'package:realmen_staff_application/service/booking/booking_service.dart';
import 'package:realmen_staff_application/service/share_prreference/share_prreference.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

import 'package:realmen_staff_application/screens/task/component/history_customer_processing.dart';
import 'package:realmen_staff_application/screens/task/component/popup_confirm.dart';

class BookingProcessingTab extends StatefulWidget {
  const BookingProcessingTab({super.key});

  @override
  State<BookingProcessingTab> createState() => _BookingProcessingTabState();
}

class _BookingProcessingTabState extends State<BookingProcessingTab>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        : tabs.length > 1
            ? DefaultTabController(
                length: tabs.length,
                child: Column(
                  children: [
                    TabBar(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      labelColor: Colors.black,
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                      indicator: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black,
                            width: 2.0,
                          ),
                        ),
                      ),
                      tabs: tabs,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      // color: Colors.amber,
                      // width: 400,
                      height: 65.h,
                      child: TabBarView(
                        controller: _tabController,
                        children: bookingViews,
                      ),
                    ),
                  ],
                ),
              )
            : bookingViews.first;
  }

  bool isDone = false;
  @override
  bool get wantKeepAlive => true;

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getBooking(1);
  }

  bool isLoading = true;
  int current = 0;
  int currentResult = 0;
  int totalPages = 0;

  List<Tab> tabs = [];
  late TabController _tabController;
  List<BookingProcessingDetail> bookingViews = [];

  // get booking
  Future<void> getBooking(int current) async {
    if (!_isDisposed && mounted) {
      do {
        try {
          int accountId = await SharedPreferencesService.getAccountId();
          if (accountId != 0) {
            BookingModel bookingModel = BookingModel();
            final result =
                await BookingService().getBooking(accountId, current, 10);
            if (result['statusCode'] == 200) {
              bookingModel = result['data'] as BookingModel;
              currentResult = result['current'];
              totalPages = result['totalPages'];
              BookingContent bookingContent;

              if (bookingModel.content!.isNotEmpty) {
                for (var content in bookingModel.content!) {
                  DateTime dateTimeContent =
                      DateTime.parse(content.appointmentDate!);
                  DateTime nowWithTime = DateTime.now();
                  DateTime now = DateTime(
                      nowWithTime.year, nowWithTime.month, nowWithTime.day);
                  if (dateTimeContent.compareTo(now) == 0 &&
                      content.bookingStatus == "PROCESSING") {
                    content.bookingServices!.sort((a, b) =>
                        a.bookingServiceId!.compareTo(b.bookingServiceId!));
                    bookingContent = content;
                    bookingViews
                        .add(BookingProcessingDetail(booking: bookingContent));
                  }
                }

                tabs = [];
                for (var booking in bookingViews) {
                  Tab tab = Tab(
                    child: Text(
                      '${bookingViews.indexOf(booking) + 1}',
                      style: GoogleFonts.quicksand(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                  tabs.add(tab);
                }
                if (!_isDisposed && mounted) {
                  setState(() {
                    isLoading = false;
                    bookingViews;
                    tabs;
                    _tabController =
                        TabController(length: tabs.length, vsync: this);
                    // current;
                  });
                }
              } else {
                if (!_isDisposed && mounted) {
                  setState(() {
                    // current;
                  });
                }
              }
            } else if (result['statusCode'] == 500) {
              _errorMessage(result['error']);
            } else if (result['statusCode'] == 403) {
              _errorMessage(result['error']);
              // AuthenticateService authenticateService = AuthenticateService();
              // authenticateService.logout();
            } else {
              print("$result");
            }
          }
        } on Exception catch (e) {
          print(e.toString());
          print("Error: $e");
        }
      } while (current <= totalPages);
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
