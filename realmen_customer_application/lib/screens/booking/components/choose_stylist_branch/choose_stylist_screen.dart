import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:realmen_customer_application/service/change_notifier_provider/change_notifier_provider_service.dart';
import 'package:sizer/sizer.dart';

class ChooseStylistScreen extends StatefulWidget {
  const ChooseStylistScreen({super.key});

  @override
  State<ChooseStylistScreen> createState() => _ChooseStylistScreenState();
  static const String ChooseStylistScreenRoute = "/choose-stylist-screen";
}

class _ChooseStylistScreenState extends State<ChooseStylistScreen> {
  @override
  Widget build(BuildContext context) {
    var selectedProvider = Provider.of<ChangeNotifierServices>(context);
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
                    height: 90.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: ListView(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 7),
                          child: Center(
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: IconButton(
                                    alignment: Alignment.centerLeft,
                                    color: Colors.black,
                                    iconSize: 22,
                                    icon: const Icon(Icons.keyboard_arrow_left),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      "chọn stylist".toUpperCase(),
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
                        const SizedBox(
                          height: 30,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: TextField(
                            decoration: InputDecoration(
                              labelText: "Tìm kiếm tên Stylist",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 170,
                                padding: const EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    alignment: Alignment.centerLeft,
                                    value: _selectedOption,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedOption = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Stylist theo lịch sử cắt',
                                      'Stylist gần đây nhất',
                                      'Stylist được cắt nhiều nhất',
                                      'Tất cả stylist',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: 160,
                                      width: 170,
                                      // padding: EdgeInsets.only(right: 5),
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(14),
                                        color: Colors.grey.shade200,
                                      ),
                                      offset: const Offset(-5, -2),
                                      scrollbarTheme: ScrollbarThemeData(
                                        // radius: const Radius.circular(40),
                                        // thickness: MaterialStateProperty.all(6),
                                        thumbVisibility:
                                            MaterialStateProperty.all(true),
                                      ),
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 40,
                                      padding:
                                          EdgeInsets.only(left: 10, right: 14),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        buildStylistList(stylistHistoryData, _selectedOption,
                            selectedProvider),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget buildStylistList(List<Map<String, dynamic>> stylistDataList,
      String _selectedOption, var selectedProvider) {
    return Column(
      children: stylistDataList.map((stylistData) {
        return Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      child: CircleAvatar(
                        radius: 30,
                        child: ClipOval(
                          child: Image.asset(
                            stylistData['avatar']!,
                            scale: 1,
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: RichText(
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
                                      text: stylistData['name'],
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
                            ),
                            SizedBox(
                              height: 5,
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
                                    text: stylistData['specialization']
                                        .join(', ')
                                        .toString(),
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
                            SizedBox(
                              height: 5,
                            ),
                            RichText(
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Chi nhánh: ",
                                    style: GoogleFonts.ebGaramond(
                                      textStyle: const TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  TextSpan(
                                    text: stylistData['branch'],

                                    //  "Cắt",
                                    // utf8.decode(_selectedStylist!.name
                                    //     .toString()
                                    //     .runes
                                    //     .toList()),
                                    style: GoogleFonts.ebGaramond(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                _selectedOption != 'Tất cả stylist'
                    ? Column(
                        children: [
                          const Divider(
                            color: Colors.black,
                            thickness: 1.0,
                            height: 16.0,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Lịch Sử Cắt",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    RichText(
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "Chi nhánh:  ",
                                            style: GoogleFonts.ebGaramond(
                                              textStyle: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          TextSpan(
                                            text: stylistData['branch'],

                                            //  "Cắt",
                                            // utf8.decode(_selectedStylist!.name
                                            //     .toString()
                                            //     .runes
                                            //     .toList()),
                                            style: GoogleFonts.ebGaramond(
                                              textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    // Các phần khác của Widget Column
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          stylistData['services'] != null
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Dịch Vụ:",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    const SizedBox(width: 8.0),
                                    ...List.generate(
                                      stylistData['services'].length,
                                      (index) => Container(
                                        margin: const EdgeInsets.only(
                                            right:
                                                8.0), // Khoảng cách giữa các border
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Color(0xff888888),
                                            width:
                                                1.0, // Độ rộng của đường viền
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(4.0)),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6.0,
                                          vertical: 3.0,
                                        ),
                                        child: Text(
                                            stylistData['services'][index]),
                                      ),
                                    ).toList(),
                                  ],
                                )
                              : Container(),
                          const SizedBox(height: 10),
                        ],
                      )
                    : Container(),
                stylistData['images'] != null
                    ? SizedBox(
                        height: 120,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...List.generate(
                                stylistData['images'].length,
                                (index) => Row(
                                      children: [
                                        Container(
                                          width: 105,
                                          height: 75,
                                          margin: const EdgeInsets.only(
                                              left: 0, right: 5),
                                          child: Image.asset(
                                            stylistData['images'][index],
                                            width: 105.0,
                                            height: 105.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    )),
                          ],
                        ),
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          selectedProvider.updateSelectedStylist(stylistData);
                          Navigator.pop(context, stylistData);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          side: const BorderSide(
                            width: 2.0,
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                          ),
                        ),
                        child: const Text("Chọn"),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    _selectedOption != 'Tất cả stylist'
                        ? Container(
                            width: 100,
                            child: ElevatedButton(
                              onPressed: () {
                                // Define the action for the "Xem thêm" button
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                                onPrimary: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    20.0,
                                  ),
                                ),
                              ),
                              child: const Text("Xem thêm"),
                            ),
                          )
                        : Container(width: 100),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // Logic
  @override
  void initState() {
    super.initState();
  }

  String _selectedOption = 'Stylist theo lịch sử cắt'; // Giá trị mặc định

  // Sample stylist history data
  List<Map<String, dynamic>> stylistHistoryData = [
    {
      'avatar': 'assets/images/s1.jpg',
      'name': 'Anh Tuấn',
      'specialization': ['Cắt tóc', 'Uốn tóc', 'Nhuộm tóc'],
      'branch': '411 Nguyễn Văn Tăng, P. Long Thạnh, Q.9, TP.Hồ Chí Minh',
      'services': ['Cắt gọi 10 bước', 'Massage Cao Cấp'],
      'images': [
        'assets/images/3.png',
        'assets/images/5.jpg',
        'assets/images/image1.png',
        'assets/images/image2.png',
      ],
    },
    {
      'avatar': 'assets/images/s2.jpg',
      'name': 'Phương Quang',
      'specialization': ['Cắt tóc', 'Uốn tóc'],
      'branch': '270 Nghĩa Phát, Phường 6, Tân Bình, Hồ Chí Minh',
      'images': [
        'assets/images/5.jpg',
        'assets/images/image1.png',
        'assets/images/3.png',
        'assets/images/image2.png',
        'assets/images/5.jpg',
      ],
    },
    {
      'avatar': 'assets/images/s3.jpg',
      'name': 'Quang Minh',
      'specialization': ['Cắt tóc', 'Nhuộm tóc', 'Uốn tóc'],
      'branch': '590 Cách Mạng Tháng 8, Phường 11, Quận 3, Hồ Chí Minh',
      'services': ['Cắt tóc', 'Ráy tai'],
      'images': [
        'assets/images/image1.png',
        'assets/images/image2.png',
        'assets/images/5.jpg',
        'assets/images/3.png',
        'assets/images/image2.png',
      ],
    },
    {
      'avatar': 'assets/images/s4.jpg',
      'name': 'Anh Quân',
      'specialization': ['Cắt tóc', 'Uốn tóc'],
      'branch': '203 Nguyễn Thượng Hiền, Phường 6, Bình Thạnh, Hồ Chí Minh',
      'images': [
        'assets/images/3.png',
        'assets/images/image2.png',
        'assets/images/image1.png',
        'assets/images/5.jpg',
        'assets/images/image2.png',
      ],
    },
    // Add more stylist history data as needed
  ];
}
