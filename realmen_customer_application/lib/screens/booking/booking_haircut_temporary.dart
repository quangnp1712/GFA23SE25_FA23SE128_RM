// ignore_for_file: must_be_immutable, constant_identifier_names, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/screens/main_bottom_bar/main_screen.dart';
import 'package:realmen_customer_application/service/account/account_service.dart';
import 'package:sizer/sizer.dart';

import 'package:realmen_customer_application/models/account/account_info_model.dart';
import 'package:realmen_customer_application/models/booking/booking_model.dart';
import 'package:realmen_customer_application/models/branch/branch_model.dart';
import 'package:realmen_customer_application/models/categoryservice/category_model.dart';
import 'package:realmen_customer_application/screens/message/success_screen.dart';
import 'package:realmen_customer_application/service/booking/booking_service.dart';
import 'package:realmen_customer_application/service/categoryservice/category_services_service.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';

class BookingHaircutTemporary extends StatefulWidget {
  Function? callback;
  BranchModel? branch;
  List<BranchServiceModel>? service; //List<String>
  AccountInfoModel? stylist;
  dynamic date;
  dynamic time;

  BookingHaircutTemporary({
    Key? key,
    this.callback,
    this.branch,
    this.service,
    this.stylist,
    this.date,
    this.time,
  }) : super(key: key);

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
                                    _buildInfoUser(
                                        widget.branch,
                                        widget.stylist,
                                        widget.date,
                                        widget.time),
                                    _buildService(widget.service!),
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
                date ?? " ",
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
                time != null ? "$time" : "",
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
        ],
      ),
    );
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
                  Container(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: Expanded(
                      child: Text(
                        service != []
                            ? utf8.decode(service[index]
                                .serviceName
                                .toString()
                                .runes
                                .toList())
                            : "",
                        maxLines: 2,
                        style: const TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                  Text(
                    formatter.format(service[index].price),
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
                "Tổng Hóa Đơn::",
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
        onPressed: submitBooking,
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

  @override
  void initState() {
    super.initState();
    widget.stylist; // null
    getTotal();
    getMassuerIdList();
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  int total = 0;
  getTotal() {
    for (var element in widget.service!) {
      total += element.price!;
    }
    setState(() {
      total;
    });
  }

  bool isLoading = true;
  List<BookingServiceModel> bookingServices = [];
  NumberFormat formatter = NumberFormat("#,##0");
  BookingModel postBooking = BookingModel();

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

  void _successMessage(String? message) {
    try {
      ShowSnackBar.SuccessSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

  List<int> massuerIdList = [];
  List<int> stylistIdList = [];

  Future getMassuerIdList() async {
    if (!_isDisposed && mounted) {
      try {
        int current = 1;
        int totalPages = 0;
        do {
          AccountService accountService = AccountService();
          final int branchId = widget.branch!.branchId!;
          final result = await accountService.getStaff(10, current, branchId);
          if (result['statusCode'] == 200) {
            final List<AccountInfoModel> accounts =
                result['data'] as List<AccountInfoModel>;
            current = result['current'];
            totalPages = result['totalPages'];

            for (var account in accounts) {
              if (account.staff != null &&
                  account.staff!.professional != null) {
                if (account.staff!.professional == "MASSEUR") {
                  massuerIdList.add(account.staff!.staffId!);
                }
              }
            }
            if (!_isDisposed && mounted) {
              setState(() {
                massuerIdList;
                getStylistIdList();
              });
            }
            current++;
          } else if (result['statusCode'] == 500) {
            _errorMessage(result['error']);
            break;
          } else {
            print("$result['statusCode'] : $result['error']");
            break;
          }
        } while (current <= totalPages);
      } on Exception catch (e) {
        print(e.toString());
        print("Error: $e");
      }
    }
  }

  Future getStylistIdList() async {
    if (!_isDisposed && mounted) {
      try {
        int current = 1;
        int totalPages = 0;
        do {
          AccountService accountService = AccountService();
          final int branchId = widget.branch!.branchId!;
          final result = await accountService.getStaff(10, current, branchId);
          if (result['statusCode'] == 200) {
            final List<AccountInfoModel> accounts =
                result['data'] as List<AccountInfoModel>;
            current = result['current'];
            totalPages = result['totalPages'];

            for (var account in accounts) {
              if (account.staff != null &&
                  account.staff!.professional != null) {
                if (account.staff!.professional == "STYLIST") {
                  stylistIdList.add(account.staff!.staffId!);
                }
              }
            }
            if (!_isDisposed && mounted) {
              setState(() {
                stylistIdList;
                setInforBooking();
              });
            }
            current++;
          } else if (result['statusCode'] == 500) {
            _errorMessage(result['error']);
            break;
          } else {
            print("$result['statusCode'] : $result['error']");
            break;
          }
        } while (current <= totalPages);
      } on Exception catch (e) {
        print(e.toString());
        print("Error: $e");
      }
    }
  }

  DateFormat format = DateFormat.Hm();
  Future setInforBooking() async {
    if (!_isDisposed && mounted) {
      CategoryServices categoryServices = CategoryServices();
      String selectedTime = "${widget.time}:00";
      String startTime = "";
      String endTime = '';
      int staffId = 0;
      int staffIdNull = 0;
      if (widget.stylist == null) {
        final random = Random();
        staffIdNull = stylistIdList[random.nextInt(stylistIdList.length)];
      }

      try {
        final result = await categoryServices.getCategoryServiceList();
        if (result['statusCode'] == 200) {
          final List<CategoryModel> categoryList = result['data'].values;

          for (var caterogy in categoryList) {
            if (caterogy.serviceList != null) {
              // lấy widget.service so sánh vs service trong category
              for (var service in widget.service!) {
                if (caterogy.serviceList!.any((cateService) =>
                        cateService.serviceId! == service.serviceId) ==
                    true) {
                  if (caterogy.categoryId == 1) {
                    final random = Random();
                    staffId =
                        massuerIdList[random.nextInt(massuerIdList.length)];
                  } else {
                    if (widget.stylist != null) {
                      staffId = widget.stylist!.staff!.staffId!;
                    } else {
                      staffId = staffIdNull;
                    }
                  }
                  // start Time
                  startTime = selectedTime;

                  // end Time
                  int duration = 30;
                  DateTime time = format.parse(startTime);
                  endTime =
                      format.format(time.add(Duration(minutes: duration)));
                  endTime = "$endTime:00";

                  // newBookingService
                  BookingServiceModel newBookingService = BookingServiceModel(
                    serviceId: service.serviceId,
                    staffId: staffId,
                    startTime: startTime,
                    endTime: endTime,
                  );

                  // List BookingService add newBookingService
                  bookingServices.add(newBookingService);

                  // startTime sau sẽ là EndTime trước
                  selectedTime = endTime;
                }
              }
            }
          }
          bookingServices;
          if (!_isDisposed && mounted) {
            setState(() {
              bookingServices;
              isLoading = false;
            });
          }
        } else {
          print("${result['statusCode']}  ${result['error']}");
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future<void> submitBooking() async {
    if (!_isDisposed && mounted) {
      try {
        String selectedDate = widget.date.split(', ')[1];
        DateTime date = DateFormat("dd/MM/yyyy", "vi").parse(selectedDate);
        String appointmentDate = DateFormat("yyyy-MM-dd").format(date);
        int branchId = widget.branch!.branchId!;
        int accountId = await SharedPreferencesService.getAccountId();
        // ignore: unnecessary_null_comparison
        if (bookingServices != null && bookingServices.isNotEmpty) {
          postBooking = BookingModel(
              appointmentDate: appointmentDate,
              branchId: branchId,
              accountId: accountId,
              bookingServices: bookingServices);
          try {
            final result = await BookingService().postBooking(postBooking);
            if (result['statusCode'] == 200) {
              _successMessage("Đặt lịch thành công");
              Get.toNamed(MainScreen.MainScreenRoute);
            } else if (result['statusCode'] == 500) {
              _errorMessage(result['error']);
            } else {
              _errorMessage("Đặt lịch thất bại");
              print(result);
            }
          } catch (e) {
            _errorMessage("Đặt lịch thất bại");
          }
        } else {
          _errorMessage("Đặt lịch thất bại");
        }
      } catch (e) {
        print(e.toString());
        _errorMessage("Đặt lịch thất bại");
      }
    }
  }

  // Future<void> submitBooking() async {
  //   massuerIdList;
  //   stylistIdList;
  //   Get.toNamed(MainScreen.MainScreenRoute);
  // }
}
