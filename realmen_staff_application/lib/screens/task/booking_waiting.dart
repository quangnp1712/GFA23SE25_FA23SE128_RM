import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5, // The number of items in the list
          itemBuilder: (context, index) {
            // Return a Card widget for each item in the list
            return ExpansionTile(
              backgroundColor: Colors.transparent,
              title: Text(
                "Thứ 2, 27/11/2023  12:30",
                style: TextStyle(fontSize: 20),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: BoxConstraints(minHeight: 100),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
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
                                child: Text(
                                  " Le Anh Tuan",
                                  maxLines: 2,
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
                          SizedBox(
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
                                child: Text(
                                  "0917901487",
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
                          SizedBox(
                            height: 20,
                          ),
                          Text(
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
                              itemCount: 5, // The number of items in the list
                              itemBuilder: (context, index) {
                                // Return a Card widget for each item in the list
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    "${index + 1}.  Cắt tóc",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
