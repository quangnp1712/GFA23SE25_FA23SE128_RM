import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopUpConfirm extends StatefulWidget {
  const PopUpConfirm({
    super.key,
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
                    onPressed: () {},
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
}
