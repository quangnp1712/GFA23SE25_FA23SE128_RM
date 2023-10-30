import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class ListBranchScreen extends StatefulWidget {
  const ListBranchScreen({super.key});

  @override
  State<ListBranchScreen> createState() => _ListBranchScreenState();
  static const String ListBranchScreenRoute = "/list-branch-screen";
}

class _ListBranchScreenState extends State<ListBranchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
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
                  height: 90.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.only(left: 7),
                        child: Center(
                          child: Stack(
                            // mainAxisAlignment: MainAxisAlignment.center,
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
                                    "hệ thống chi nhánh".toUpperCase(),
                                    style: GoogleFonts.quicksand(
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
                      // Combo
                      const SizedBox(
                        height: 30,
                      ),
                      Stack(
                        children: [
                          Container(
                              height: 180,
                              decoration:
                                  const BoxDecoration(color: Colors.black)),
                          Image.asset(
                            "assets/images/Logo-White-NoBG-O-15.png",
                            width: 360,
                            height: 180,
                          ),
                          Container(
                            height: 180,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "HỆ THỐNG CHI NHÁNH CỦA REALMEN",
                                  style: GoogleFonts.quicksand(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "Tính đến hiện tại, chuỗi barber tóc nam RealMen có 99 barber tại những vị trí đắc địa nhất TP. Hồ Chí Minh, Hà Nội và các tỉnh lân cận. Hãy tìm đến barber RealMen gần bạn nhất để tận hưởng trải nghiệm cắt tóc nam đỉnh cao!",
                                  style: GoogleFonts.quicksand(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: branches.length,
                        itemBuilder: (context, index) {
                          return ExpansionTile(
                            title: Text(branches[index].city),
                            subtitle: Text(
                                'Số lượng chi nhánh: ${branches.length - 1}'),
                            children: [
                              SizedBox(
                                height: 200,
                                width: double.infinity,
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      branches[index].image,
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Text(branches[index].name),
                                subtitle: Text(branches[index].address),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    // Xử lý sự kiện khi nhấn nút đặt lịch
                                  },
                                  child: const Text('Đặt lịch'),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ))
      ],
    ));
  }

  final List<HairSalonBranch> branches = [
    HairSalonBranch(
      city: 'Hà Nội',
      address: '123 Đường ABC, Quận XYZ',
      name: 'Chi nhánh Hà Nội',
      image: 'assets/images/branch1.png',
    ),
    HairSalonBranch(
      city: 'Hồ Chí Minh',
      address: '456 Đường DEF, Quận UVW',
      name: 'Chi nhánh Hồ Chí Minh',
      image: 'assets/images/branch1.png',
    ),
    HairSalonBranch(
      city: 'Đà Nẵng',
      address: '789 Đường GHI, Quận JKL',
      name: 'Chi nhánh Đà Nẵng',
      image: 'assets/images/branch1.png',
    ),
  ];
}

class HairSalonBranch {
  final String city;
  final String address;
  final String name;
  final String image;

  HairSalonBranch({
    required this.city,
    required this.address,
    required this.name,
    required this.image,
  });
}
