import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realmen_staff_application/screens/task/component/popup_accept_guests.dart';

class BookingWaitingTab extends StatefulWidget {
  const BookingWaitingTab({super.key});

  @override
  State<BookingWaitingTab> createState() => _BookingWaitingTabState();
}

class _BookingWaitingTabState extends State<BookingWaitingTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisSize: MainAxisSize
              .min, // Điều này sẽ giúp Column co lại con của nó thay vì mở rộng
          crossAxisAlignment: CrossAxisAlignment
              .stretch, // Đảm bảo các con của Column sẽ căng đều theo chiều ngang
          children: [
            Container(
              height: 35,
              color: Colors.black,
              child: const Center(
                child: Text(
                  "Thứ 2, 27/11/2023 ",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2, // The number of items in the list
              itemBuilder: (context, index) {
                // Return a Card widget for each item in the list
                return ExpansionTile(
                  tilePadding: EdgeInsets.all(0),
                  backgroundColor: Colors.transparent,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${index + 1}. Anh Tuấn",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      Text(
                        "Giờ book: 12:00",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      )
                    ],
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(minHeight: 100),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                                      " Le Anh Tuan",
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
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Dich Vu: ",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
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
                                  itemCount:
                                      1, // The number of items in the list
                                  itemBuilder: (context, index) {
                                    // Return a Card widget for each item in the list
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Text(
                                        "${index + 1}.  Cắt tóc",
                                        style: const TextStyle(fontSize: 20),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.all(10),
                                      child: TextButton(
                                        onPressed: () {},
                                        child: Center(
                                          child: Text(
                                            "Chuyển khách",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          border: Border.all(
                                            color: Colors.black54,
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.all(10),
                                      child: TextButton(
                                        onPressed: () {
                                          _popup();
                                        },
                                        child: Center(
                                          child: Text(
                                            "Nhận khách",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> _popup() async {
    if (!_isDisposed) {
      return showModalBottomSheet(
        enableDrag: true,
        isDismissible: true,
        isScrollControlled: false,
        context: context,
        backgroundColor: Colors.white,
        barrierColor: const Color(0x8c111111),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) => PopUpAcceptGuest(),
      );
    }
  }
}
