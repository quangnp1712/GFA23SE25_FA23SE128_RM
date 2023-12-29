// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DetailHistoryBookingScreen extends StatefulWidget {
  const DetailHistoryBookingScreen({super.key});

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
                          Column(
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
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ngày: ",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(height: 12),
              Text(
                "Giờ booking: ",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(height: 12),
              Text(
                "Stylist: ",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(height: 12),
              Text(
                "Skinner: ",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(height: 12),
              Text(
                "PTTT: ",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(height: 12),
              Text(
                "Barber Shop: ",
                style: TextStyle(fontSize: 17),
              ),
            ],
          ),
          SizedBox(
            width: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Thứ 6, 01/12/2023",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              SizedBox(height: 12),
              Text(
                "12:30",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              SizedBox(height: 12),
              Text(
                "Le Anh Tuan",
                maxLines: 1,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              SizedBox(height: 12),
              Text(
                "Be Dep",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              SizedBox(height: 12),
              Text(
                "The",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 17),
              ),
              SizedBox(height: 12),
              SizedBox(
                width: 220,
                child: Text(
                  "590 Cách Mạng Tháng 8, Phường 11, Quận 3, Hồ Chí Minh",
                  maxLines: 3,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Dich Vu: ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: const Text(
                  "Đặt lại dịch vụ",
                  style: TextStyle(color: Colors.white),
                ),
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
          itemCount: serviceList.length, // The number of items in the list
          itemBuilder: (context, index) {
            // Return a Card widget for each item in the list
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceList[index].name.toString(),
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(width: 140),
                  Text(
                    formatter.format(serviceList[index].price),
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

  NumberFormat formatter = NumberFormat("#,##0");
  double total = 0;
  calTotal() {
    for (var service in serviceList) {
      total += service.price as double;
    }
    setState(() {
      total;
    });
  }

  List<ServiceList> serviceList = [
    ServiceList(name: "Cắt tóc", price: 70000),
    ServiceList(name: "Massage đầu", price: 50000),
    ServiceList(name: "Cạo Mặt", price: 30000),
    ServiceList(name: "Ráy tai", price: 30000),
  ];
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
