// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realmen_customer_application/models/account/account_info_model.dart';
import 'package:realmen_customer_application/models/booking/booking_model.dart';
import 'package:realmen_customer_application/models/branch/branch_model.dart';

class ChooseStylist extends StatefulWidget {
  final void Function(AccountInfoModel? stylist) onStylistSelected;
  final void Function(AccountInfoModel? stylistSelected) updateSelectedStylist;
  final List<AccountInfoModel>? accountStaffList;

  // option OTO
  final bool? oneToOne;

  // hàm add stylist vào post booking
  final void Function(BookingServiceModel serviceOTO)? onAddStylistOTO;

  // data service - stylist
  final BranchServiceModel? service;

  const ChooseStylist({
    super.key,
    required this.onStylistSelected,
    required this.updateSelectedStylist,
    this.accountStaffList,
    this.oneToOne,
    this.onAddStylistOTO,
    this.service,
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

                          if (widget.oneToOne != null) {
                            if (widget.oneToOne!) {
                              BookingServiceModel newBookingServiceModel =
                                  BookingServiceModel(
                                serviceId: widget.service!.serviceId,
                                staffId: 0,
                                serviceName: widget.service!.serviceName,
                                servicePrice:
                                    widget.service!.branchServicePrice ??
                                        widget.service!.price,
                                staffName: "REALMEN sẽ chọn hộ bạn",
                                bookingServiceType: "PICKUP_STYLIST",
                              );
                              widget.onAddStylistOTO!(newBookingServiceModel);
                            }
                          }
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
                                "REALMEN sẽ chọn hộ bạn ",
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
                                                      child: CachedNetworkImage(
                                                        imageUrl: stylist
                                                            .thumbnailUrl!,
                                                        placeholder: (context,
                                                                url) =>
                                                            const CircularProgressIndicator(),
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
              _selectedStylist.accountId != null &&
                      _selectedStylist.accountId != null
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
                            const SizedBox(
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
                                  style: const ButtonStyle(
                                      padding: MaterialStatePropertyAll(
                                          EdgeInsets.zero)),
                                  child: const Text(
                                    "",
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
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

  @override
  void didUpdateWidget(ChooseStylist oldWidget) {
    // thay đổi service -> reset lại chọn stylist - date - timeslot
    if (!listEquals(oldWidget.accountStaffList, widget.accountStaffList)) {
      if (!widget.accountStaffList!.any((accountStaff) =>
          accountStaff.staff!.accountId == _selectedStylist.accountId)) {
        Future.delayed(Duration.zero, () {
          if (mounted) {
            setState(() {
              _selectedStylist = AccountInfoModel();
              isDefaultSelected = true;
              widget.onStylistSelected(null);
              widget.updateSelectedStylist(null);
              if (widget.oneToOne != null) {
                if (widget.oneToOne!) {
                  BookingServiceModel newBookingServiceModel =
                      BookingServiceModel(
                    serviceId: widget.service!.serviceId,
                    staffId: 0,
                    serviceName: widget.service!.serviceName,
                    servicePrice: widget.service!.branchServicePrice ??
                        widget.service!.price,
                    staffName: "REALMEN sẽ chọn hộ bạn",
                    bookingServiceType: "PICKUP_STYLIST",
                  );
                  widget.onAddStylistOTO!(newBookingServiceModel);
                }
              }
            });
          }
        });
      }
    }
    build(context);
    super.didUpdateWidget(oldWidget);
  }

  AccountInfoModel _selectedStylist = AccountInfoModel();
  bool isDefaultSelected = true;

  // khi chọn Stylist
  // data = chọn stylist - stylist
  // hàm add data vào post booking
  void _onStylistSelected(AccountInfoModel stylist) {
    // trường hợp ấn 1 stylist 2 lần -> random
    if (stylist.accountId == _selectedStylist.accountId) {
      _selectedStylist = AccountInfoModel();
      isDefaultSelected = true;
      widget.onStylistSelected(null);
      widget.updateSelectedStylist(null);

      if (widget.oneToOne != null) {
        if (widget.oneToOne!) {
          BookingServiceModel newBookingServiceModel = BookingServiceModel(
            serviceId: widget.service!.serviceId,
            staffId: 0,
            serviceName: widget.service!.serviceName,
            servicePrice:
                widget.service!.branchServicePrice ?? widget.service!.price,
            staffName: "REALMEN sẽ chọn hộ bạn",
            bookingServiceType: "PICKUP_STYLIST",
          );
          widget.onAddStylistOTO!(newBookingServiceModel);
        }
      }
    } else {
      // gán data stylist vừa chọn
      _selectedStylist = stylist;

      widget.onStylistSelected(_selectedStylist);
      widget.updateSelectedStylist(_selectedStylist);
      isDefaultSelected = false;

      // nếu option là ONE TO ONE
      // add vào post booking
      if (widget.oneToOne != null) {
        if (widget.oneToOne!) {
          BookingServiceModel newBookingServiceModel = BookingServiceModel(
            serviceId: widget.service!.serviceId,
            staffId: _selectedStylist.staff!.staffId,
            serviceName: widget.service!.serviceName,
            servicePrice:
                widget.service!.branchServicePrice ?? widget.service!.price,
            staffName:
                "${_selectedStylist.firstName} ${_selectedStylist.lastName}",
            bookingServiceType: "CHOSEN_STYLIST",
          );
          widget.onAddStylistOTO!(newBookingServiceModel);
        }
      }
    }
    setState(() {
      _selectedStylist;
      isDefaultSelected;
    });
  }

  @override
  void initState() {
    super.initState();
    setImage();
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  final storage = FirebaseStorage.instance;

  List<String> urlList = [
    "1.jpg",
    "2.jpg",
    "3.jpg",
    "4.jpg",
  ];
  Future<void> setImage() async {
    if (!_isDisposed && mounted) {
      try {
        for (var staff in widget.accountStaffList!) {
          try {
            if (staff.accountId == 2) {
              staff.thumbnailUrl = "1.jpg";
            } else if (staff.accountId == 7) {
              staff.thumbnailUrl = "2.jpg";
            } else if (staff.accountId == 8) {
              staff.thumbnailUrl = "3.jpg";
            }
            var reference = storage.ref('stylist/${staff.thumbnailUrl}');
            staff.thumbnailUrl = await reference.getDownloadURL();
          } catch (e) {
            final random = Random();
            var randomUrl = random.nextInt(urlList.length);
            var reference = storage.ref('stylist/${urlList[randomUrl]}');
            staff.thumbnailUrl = await reference.getDownloadURL();
          }
        }
      } on Exception catch (e) {
        print(e.toString());
        print("Error: $e");
      }
    }
  }
}
