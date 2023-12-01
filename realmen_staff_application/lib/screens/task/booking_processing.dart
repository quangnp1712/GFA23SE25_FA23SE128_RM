import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realmen_staff_application/screens/history_booking/history_booking_screen.dart';
import 'package:realmen_staff_application/screens/task/component/history_customer.dart';

class BookingProcessingTab extends StatefulWidget {
  const BookingProcessingTab({super.key});

  @override
  State<BookingProcessingTab> createState() => _BookingProcessingTabState();
}

class _BookingProcessingTabState extends State<BookingProcessingTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Đơn cắt:  Thứ 2, 27/11/2023  12:00",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  child: const Text(
                    "Khách hàng: ",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  child: const Text(
                    " Le Anh Tuan  -  Lv 1",
                    maxLines: 2,
                    textAlign: TextAlign.left,
                    style: TextStyle(
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
                Container(
                  width: 100,
                  child: const Text(
                    "Số điện thoại: ",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  child: const Text(
                    "xxxxxx1487",
                    textAlign: TextAlign.left,
                    maxLines: 1,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.to(HistoryCustomerScreen());
                },
                child: const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Xem lịch sử",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.blueAccent,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.solid),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Dịch Vụ: ",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
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
              // padding: EdgeInsets.all(12.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1, // The number of items in the list
                itemBuilder: (context, index) {
                  // Return a Card widget for each item in the list
                  return ExpansionTile(
                    backgroundColor: Colors.transparent,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Cắt tóc",
                          style: TextStyle(fontSize: 20),
                        ),
                        Container(
                          width: 100,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                            // color: Color(0xff207A20),
                            color: isDone == false
                                ? Colors.white
                                : const Color(0xff207A20),
                            border: Border.all(
                                color: Colors.black54,
                                style: BorderStyle.solid),
                          ),
                          child: Center(
                            child: Text(
                              isDone == false ? "ĐANG LÀM" : "HOÀN THÀNH",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                // color: Colors.white,
                                color: isDone == false
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(minHeight: 100),
                          child: Column(
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: _selectedImage != null
                                      ? Image.file(
                                          _selectedImage!,
                                          height: 200,
                                          width: 200,
                                          fit: BoxFit.cover,
                                        )
                                      : Container(),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black54,
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.all(10),
                                      child: TextButton(
                                        onPressed: () {
                                          _pickImageFromCamera();
                                        },
                                        child: const Center(
                                          child: Text(
                                            "Chụp ảnh",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black54,
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.all(10),
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            isDone = true;
                                          });
                                        },
                                        child: const Center(
                                          child: Text(
                                            "Xác nhận",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
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
                onPressed: () {},
                child: Center(
                  child: Text(
                    "Hoàn Thành".toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool isDone = false;
  @override
  bool get wantKeepAlive => true;

  File? _selectedImage;
  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}
