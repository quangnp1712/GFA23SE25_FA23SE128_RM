import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realmen_customer_application/screens/main_bottom_bar/main_screen.dart';
import 'package:realmen_customer_application/screens/message/success_screen.dart';
import 'package:realmen_customer_application/service/booking/booking_service.dart';

class PopUpConfirm extends StatefulWidget {
  int? bookingId;
  PopUpConfirm({
    super.key,
    this.bookingId,
  });

  @override
  State<PopUpConfirm> createState() => _PopUpConfirmState();
}

class _PopUpConfirmState extends State<PopUpConfirm> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "hủy đặt lịch".toUpperCase(),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              color: Colors.grey.shade700,
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "Các bạn stylist massuer đã sẵn sàng phục vụ anh, anh chắc chắn muốn hủy lịch chứ?",
                style: TextStyle(fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 140,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Center(
                      child: Text(
                        "quay lại".toUpperCase(),
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.redAccent, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  margin: const EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: cancelBooking,
                    child: const Center(
                      child: Text(
                        "Chắc chắn hủy lịch",
                        style: TextStyle(fontSize: 21, color: Colors.redAccent),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> cancelBooking() async {
    if (mounted) {
      try {
        final result = await BookingService().cancelBooking(widget.bookingId!);
        if (result['statusCode'] == 200) {
          _successMessage("Huỷ lịch thành công");
          Get.toNamed(MainScreen.MainScreenRoute);
        } else if (result['statusCode'] == 500) {
          Get.back();
          _errorMessage(result['error']);
        } else {
          Get.back();
          _errorMessage("Hủy lịch thất bại");
          print(result);
        }
      } catch (e) {
        Get.back();
        _errorMessage("Hủy lịch thất bại");
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

  void _successMessage(String? message) {
    try {
      ShowSnackBar.SuccessSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }
}
