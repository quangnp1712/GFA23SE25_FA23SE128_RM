import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../stylist_date_time_booking_choose.dart';

class ChooseStylist extends StatefulWidget {
  const ChooseStylist({super.key});

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
            _selectedStylist.id != null
                ? _selectedStylist.name!
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
                        if (_selectedStylist.id != null) {
                          isDefaultSelected = true;
                          _selectedStylist = StylistModel();
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
                  stylists != null
                      ? SizedBox(
                          width: 245,
                          height: 142,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.only(left: 0),
                              itemCount: stylists.length,
                              itemBuilder: (context, index) {
                                final stylist = stylists[index];
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
                                                        stylist.avatar!,
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
                                              stylist.name!,
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
              _selectedStylist != null && _selectedStylist.id != null
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
                            Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Stylist: ",
                                          style: GoogleFonts.ebGaramond(
                                            textStyle: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        TextSpan(
                                          text: _selectedStylist!.name,
                                          //  "Cắt",
                                          // utf8.decode(_selectedStylist!.name
                                          //     .toString()
                                          //     .runes
                                          //     .toList()),
                                          style: GoogleFonts.ebGaramond(
                                            textStyle: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      "Xem thêm",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Chuyên môn: ",
                                    style: GoogleFonts.ebGaramond(
                                      textStyle: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  TextSpan(
                                    text: _selectedStylist!.specialties!
                                        .join(', ')
                                        .toString(),
                                    //  _selectedStylist!.specialties != null
                                    //     ? utf8.decode(_selectedStylist!
                                    //         .specialties!
                                    //         .join(', ')
                                    //         .toString()
                                    //         .runes
                                    //         .toList())
                                    //     : "",
                                    style: GoogleFonts.ebGaramond(
                                      textStyle: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _selectedStylist.images != null
                                ? SizedBox(
                                    height: 120,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount:
                                            _selectedStylist.images!.length,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Container(
                                                width: 105,
                                                height: 75,
                                                margin: const EdgeInsets.only(
                                                    left: 0, right: 5),
                                                child: Image.asset(
                                                  _selectedStylist
                                                      .images![index],
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                  )
                                : Container(),
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

  StylistModel _selectedStylist = StylistModel();
  bool isDefaultSelected = true;
  void _onStylistSelected(StylistModel stylist) {
    setState(() {
      if (stylist.id == _selectedStylist.id) {
        _selectedStylist = StylistModel();
        isDefaultSelected = true;
      } else {
        _selectedStylist = stylist;
        isDefaultSelected = false;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    stylists;
  }

  final List<StylistModel> stylists = [
    StylistModel(
      id: 1,
      name: 'Phương Quang',
      avatar: 'assets/images/admin.png',
      specialties: ['Cắt', 'Uốn', 'Nhuộm'],
      images: [
        'assets/images/image1.png',
        'assets/images/image2.png',
        'assets/images/image1.png',
        'assets/images/image1.png',
        'assets/images/image2.png',
      ],
    ),
    StylistModel(
      id: 2,
      name: 'Anh Tuấn',
      avatar: 'assets/images/admin.png',
      specialties: ['Cắt', 'Uốn', 'Nhuộm'],
      images: [
        'assets/images/image1.png',
        'assets/images/image2.png',
        'assets/images/image1.png',
        'assets/images/image1.png',
        'assets/images/image2.png',
      ],
    ),
    StylistModel(
      id: 3,
      name: 'Quang Minh',
      avatar: 'assets/images/admin.png',
      specialties: ['Cắt', 'Uốn', 'Nhuộm'],
      images: [
        'assets/images/image1.png',
        'assets/images/image2.png',
        'assets/images/image1.png',
        'assets/images/image1.png',
        'assets/images/image2.png',
      ],
    ),
    StylistModel(
      id: 4,
      name: 'Anh Quân',
      avatar: 'assets/images/admin.png',
      specialties: ['Cắt', 'Uốn', 'Nhuộm'],
      images: [
        'assets/images/image1.png',
        'assets/images/image2.png',
        'assets/images/image1.png',
        'assets/images/image1.png',
        'assets/images/image2.png',
      ],
    ),
    StylistModel(
      id: 5,
      name: 'Mike Tyson',
      avatar: 'assets/images/admin.png',
      specialties: ['Cắt', 'Uốn', 'Nhuộm'],
      images: [
        'assets/images/image1.png',
        'assets/images/image2.png',
        'assets/images/image1.png',
        'assets/images/image1.png',
        'assets/images/image2.png',
      ],
    ),
  ];
}

class StylistModel {
  int? id;
  String? name;
  String? avatar;
  List<String>? specialties;
  List<String>? images;
  StylistModel({
    this.id,
    this.name,
    this.avatar,
    this.specialties,
    this.images,
  });
}
