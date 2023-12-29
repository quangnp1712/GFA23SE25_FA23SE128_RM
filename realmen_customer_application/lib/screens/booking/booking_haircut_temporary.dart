// ignore_for_file: must_be_immutable, constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:realmen_customer_application/models/branch/branch_model.dart';
import 'package:sizer/sizer.dart';

class BookingHaircutTemporary extends StatefulWidget {
  BookingHaircutTemporary({super.key});
  Map<String, dynamic> params = Get.arguments;

  dynamic branch = Get.arguments['branch'];
  List<BranchServiceModel> service = Get.arguments['service']; //List<String>
  dynamic stylist = Get.arguments['stylist'];
  dynamic date = Get.arguments['date'];
  dynamic time = Get.arguments['time'];

  @override
  State<BookingHaircutTemporary> createState() =>
      BookingHaircutTemporaryState();
  static const String BookingHaircutTemporaryScreenRoute =
      "/booking-temporary-screen";
}

class BookingHaircutTemporaryState extends State<BookingHaircutTemporary> {
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
                                        "hóa đơn lịch đặt".toUpperCase(),
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
                          Column(
                            children: [
                              _buildInfoUser(widget.branch, widget.stylist,
                                  widget.date, widget.time),
                              _buildService(widget.service),
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
                              _buildButton(),
                              const SizedBox(
                                height: 10,
                              )
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
    );
  }

  Widget _buildInfoUser(
      dynamic branch, dynamic stylist, dynamic date, dynamic time) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  "Salon: ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: Text(
                  utf8.decode(branch.address.toString().runes.toList()),
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
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  "Stylist: ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                width: 220,
                child: Text(
                  stylist != null && stylist.accountId != null
                      ? utf8.decode(("${stylist.firstName} ${stylist.lastName}")
                          .toString()
                          .runes
                          .toList())
                      : "REALMEN sẽ chọn giúp anh",
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
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                width: 130,
                child: Text(
                  "Ngày và giờ hẹn: ",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                children: [
                  Text(
                    date ?? " ",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 17),
                  ),
                  // const SizedBox(width: 5),
                  Text(
                    time != null ? ",  $time" : "",
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  int total = 0;
  getTotal() {
    for (var element in widget.service) {
      total += element.price!;
    }
    setState(() {
      total;
    });
  }

  @override
  void initState() {
    super.initState();
    getTotal();
  }

  Widget _buildService(List<BranchServiceModel> service) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Dịch vụ: ",
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
          itemCount: service != []
              ? service.length
              : 1, // The number of items in the list
          itemBuilder: (context, index) {
            // Return a Card widget for each item in the list
            return Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, left: 10, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(service != []
                      ? utf8.decode(
                          service[index].serviceName.toString().runes.toList())
                      : ""),
                  Text(formatter.format(service[index].price)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  NumberFormat formatter = NumberFormat("#,##0");
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // SizedBox(width: 140),
              Text(
                formatter.format(total),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      width: 81.w,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff302E2E),
              Color(0xe6444141),
              Color(0x8c484646),
              Color(0x26444141),
            ]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: const Text(
          "Xác Nhận",
          style: TextStyle(
              fontSize: 24, color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
