import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realmen_customer_application/models/account/account_info_model.dart';

import '../stylist_date_time_booking_choose.dart';

class ChooseStylist extends StatefulWidget {
  final void Function(AccountInfoModel? stylist) onStylistSelected;
  final void Function(AccountInfoModel? stylistSelected) updateSelectedStylist;
  final List<AccountInfoModel>? accountStaffList;

  ChooseStylist({
    super.key,
    required this.onStylistSelected,
    required this.updateSelectedStylist,
    this.accountStaffList,
  });

  @override
  State<ChooseStylist> createState() => _ChooseStylistState();
}

class _ChooseStylistState extends State<ChooseStylist> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      shape: const Border(bottom: BorderSide.none),
      title: Row(
        children: [
          const Icon(
            Icons.person,
            color: Colors.black,
            size: 16,
          ),
          const SizedBox(width: 10),
          Text(
            _selectedStylist.accountId != null
                ? utf8.decode(
                    ("${_selectedStylist.firstName!.substring(_selectedStylist.firstName!.lastIndexOf(" ") + 1)} ${_selectedStylist.lastName!}")
                        .runes
                        .toList())
                : "Chọn Stylist",
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (_selectedStylist.accountId != null) {
                          isDefaultSelected = true;
                          _selectedStylist = AccountInfoModel();

                          widget.onStylistSelected(null);
                          widget.updateSelectedStylist(null);
                        } else {
                          isDefaultSelected = true;
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 5, bottom: 0, left: 0, right: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 72,
                                height: 72,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isDefaultSelected
                                        ? Colors.black
                                        : Colors.transparent,
                                    width: 1,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(2),
                                child: Center(
                                  child: Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.black,
                                    ),
                                    padding: const EdgeInsets.all(3),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 20,
                                      child: ClipOval(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            "assets/images/logo-no-text.png",
                                            scale: 1,
                                            fit: BoxFit.fitHeight,
                                            width: 70,
                                            height: 70,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              isDefaultSelected
                                  ? Positioned(
                                      bottom: 1,
                                      right: 4,
                                      child: Container(
                                        height: 22,
                                        width: 22,
                                        // color: Colors.white,
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.black,
                                          child: ClipOval(
                                            child: Icon(
                                              Icons.done,
                                              size: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                              constraints: const BoxConstraints(maxWidth: 76),
                              child: const Text(
                                "REALMEN Chọn hộ anh Phuong Quang",
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  widget.accountStaffList != null
                      ? SizedBox(
                          width: 245,
                          height: 142,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.only(left: 0),
                              itemCount: widget.accountStaffList!.length,
                              itemBuilder: (context, index) {
                                final stylist = widget.accountStaffList![index];
                                final isSelected = stylist == _selectedStylist;

                                return GestureDetector(
                                  onTap: () {
                                    _onStylistSelected(stylist);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 5, bottom: 0, left: 0, right: 5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Stack(
                                          children: [
                                            Container(
                                              width: 72,
                                              height: 72,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: isSelected
                                                      ? Colors.black
                                                      : Colors.transparent,
                                                  width: 1,
                                                  style: BorderStyle.solid,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.white,
                                              ),
                                              padding: const EdgeInsets.all(2),
                                              child: Center(
                                                child: Container(
                                                  width: 70,
                                                  height: 70,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: Colors.black,
                                                      width: 1,
                                                      style: BorderStyle.solid,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.black,
                                                  ),
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    radius: 20,
                                                    child: ClipOval(
                                                      child: Image.asset(
                                                        stylist.thumbnailUrl !=
                                                                null
                                                            ? stylist
                                                                .thumbnailUrl!
                                                            : "assets/images/s4.jpg",
                                                        scale: 1,
                                                        fit: BoxFit.cover,
                                                        width: 70,
                                                        height: 70,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            isSelected
                                                ? Positioned(
                                                    bottom: 1,
                                                    right: 4,
                                                    child: Container(
                                                      height: 22,
                                                      width: 22,
                                                      // color: Colors.white,
                                                      child: const CircleAvatar(
                                                        backgroundColor:
                                                            Colors.black,
                                                        child: ClipOval(
                                                          child: Icon(
                                                            Icons.done,
                                                            size: 18,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 76),
                                            child: Text(
                                              utf8.decode(
                                                  ("${stylist.firstName!.substring(stylist.firstName!.lastIndexOf(" ") + 1)} ${stylist.lastName!}")
                                                      .runes
                                                      .toList()),
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )),
                                        isSelected
                                            ? const Icon(
                                                Icons.keyboard_arrow_up,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Container(),
                ],
              ),
              _selectedStylist != null && _selectedStylist.accountId != null
                  ? Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            width: 1,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Stylist: ",
                                    style: GoogleFonts.quicksand(
                                      textStyle: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  TextSpan(
                                    text: utf8.decode(
                                        ("${_selectedStylist.firstName!} ${_selectedStylist.lastName!}")
                                            .toString()
                                            .runes
                                            .toList()),
                                    //  "Cắt",
                                    // utf8.decode(_selectedStylist!.name
                                    //     .toString()
                                    //     .runes
                                    //     .toList()),
                                    style: GoogleFonts.quicksand(
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Đánh giá: ",
                                    style: GoogleFonts.quicksand(
                                      textStyle: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  TextSpan(
                                    text: "",
                                    style: GoogleFonts.quicksand(
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Xem thêm",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      padding: MaterialStatePropertyAll(
                                          EdgeInsets.zero)),
                                ),
                              ],
                            ),

                            // Hình ảnh sản phẩm cắt
                            // _selectedStylist.images != null
                            //     ? SizedBox(
                            //         height: 120,
                            //         child: ListView.builder(
                            //             scrollDirection: Axis.horizontal,
                            //             itemCount:
                            //                 _selectedStylist.images!.length,
                            //             itemBuilder: (context, index) {
                            //               return Row(
                            //                 children: [
                            //                   Container(
                            //                     width: 105,
                            //                     height: 75,
                            //                     margin: const EdgeInsets.only(
                            //                         left: 0, right: 5),
                            //                     child: Image.asset(
                            //                       _selectedStylist
                            //                           .images![index],
                            //                       fit: BoxFit.cover,
                            //                     ),
                            //                   ),
                            //                 ],
                            //               );
                            //             }),
                            //       )
                            //     : Container(),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }

  AccountInfoModel _selectedStylist = AccountInfoModel();
  bool isDefaultSelected = true;
  void _onStylistSelected(AccountInfoModel stylist) {
    setState(() {
      if (stylist.accountId == _selectedStylist.accountId) {
        _selectedStylist = AccountInfoModel();
        isDefaultSelected = true;
        widget.onStylistSelected(null);
        widget.updateSelectedStylist(null);
      } else {
        _selectedStylist = stylist;
        String name = _selectedStylist.firstName!
                .substring(_selectedStylist.firstName!.lastIndexOf(" ") + 1) +
            _selectedStylist.lastName!;
        widget.onStylistSelected(_selectedStylist);
        widget.updateSelectedStylist(_selectedStylist);
        isDefaultSelected = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
