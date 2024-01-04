// ignore_for_file: constant_identifier_names, must_be_immutable

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/models/booking/booking_model.dart';
import 'package:sizer/sizer.dart';

class DetailHistoryBookingScreen extends StatefulWidget {
  BookingContent? booking;
  DetailHistoryBookingScreen({this.booking, super.key});

  @override
  State<DetailHistoryBookingScreen> createState() =>
      _DetailHistoryBookingScreenState();
  static const String DetailHistoryBookingScreenRoute =
      "/detail-history-booking-screen";
}

class _DetailHistoryBookingScreenState
    extends State<DetailHistoryBookingScreen> {
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
                      child: ListView(
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
                                        "chi tiết hóa đơn".toUpperCase(),
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
                                    _buildInfoUser(),
                                    _buildService(),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      child: Divider(
                                        color: Colors.black,
                                        height: 2,
                                        thickness: 1,
                                      ),
                                    ),
                                    // _buildButton(),
                                    _buildTotalMoney(),
                                  ],
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

      //
    );
  }

  Widget _buildInfoUser() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ngày và giờ
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  "Ngày: ",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Text(
                widget.booking!.appointmentDate ?? " ",
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
            ],
          ),

          // Giờ
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  "Giờ booking: ",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              Text(
                widget.booking!.bookingServices!.first.startTime ?? "",
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              ),
            ],
          ),
          //Stylist
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  "Stylist: ",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: Text(
                  stylist,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  "Massuer: ",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: Text(
                  stylist,
                  textAlign: TextAlign.left,
                  maxLines: 1,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          // Barber Shop:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  "Barber Shop: ",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: Text(
                  utf8.decode(
                      widget.booking!.branchAddress.toString().runes.toList()),
                  maxLines: 3,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildService() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dich Vu: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Divider(
            color: Colors.black,
            height: 2,
            thickness: 1,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: widget.booking!.bookingServices!
              .length, // The number of items in the list
          itemBuilder: (context, index) {
            // Return a Card widget for each item in the list
            return Padding(
              padding:
                  const EdgeInsets.only(top: 7, bottom: 7, left: 12, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: Expanded(
                      child: Text(
                        utf8.decode(widget
                            .booking!.bookingServices![index].serviceName
                            .toString()
                            .runes
                            .toList()),
                        style: const TextStyle(fontSize: 17),
                        maxLines: 2,
                      ),
                    ),
                  ),
                  Text(
                    widget.booking!.bookingServices![index].servicePrice != null
                        ? formatter.format(widget
                            .booking!.bookingServices![index].servicePrice)
                        : '0',
                    style: const TextStyle(fontSize: 17),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTotalMoney() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tổng Tiền:",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              // SizedBox(width: 140),
              Text(
                formatter.format(total),
                style: const TextStyle(fontSize: 17),
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tổng Giảm Giá:",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              // SizedBox(width: 140),
              Text(
                "0",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tổng Hóa Đơn:",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SizedBox(width: 140),
              Text(
                formatter.format(total),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 7,
          ),
        ],
      ),
    );
  }

  bool isLoading = true;
  String stylist = 'Đang đợi update APi';
  NumberFormat formatter = NumberFormat("#,##0");
  double total = 0;
  calTotal() {
    if (widget.booking!.bookingServices != null) {
      for (var service in widget.booking!.bookingServices!) {
        if (service.servicePrice != null) {
          total += double.parse(service.servicePrice.toString());
        } else {
          total = 0;
        }
      }
    } else {
      total = 0;
    }
    setState(() {
      total;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    calTotal();
  }
}

class ServiceList {
  String? name;
  double? price;
  ServiceList({
    this.name,
    this.price,
  });
}
