import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realmen_staff_application/screens/task/booking_processing.dart';

class PopUpConfirm extends StatefulWidget {
  const PopUpConfirm({super.key, required this.service, required this.index});
  final serviceDemoModel? service;
  final int? index;
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
                "xác nhận bắt đầu phục vụ".toUpperCase(),
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
            widget.service != null
                ? Center(
                    child: Text.rich(TextSpan(children: [
                      WidgetSpan(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Container(
                            height: 23,
                            width: 25,
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
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      WidgetSpan(
                        child: SizedBox(
                          width: 5,
                        ),
                      ),
                      TextSpan(
                        text: widget.service!.name.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          color: Colors.black,
                        ),
                      )
                    ])),
                  )
                : Container(),
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
                  margin: EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Center(
                      child: Text(
                        "quay lại".toUpperCase(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.black54,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        "bắt đầu phục vụ".toUpperCase(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
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
