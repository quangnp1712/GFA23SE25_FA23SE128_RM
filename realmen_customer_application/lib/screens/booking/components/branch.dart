import 'package:flutter/material.dart';
import 'package:realmen_customer_application/screens/booking/components/on_off_switch.dart';
import 'package:realmen_customer_application/screens/booking/components/time_slot.dart';

class BranchOptionBooking extends StatefulWidget {
  const BranchOptionBooking({super.key});

  @override
  State<BranchOptionBooking> createState() => _BranchOptionBookingState();
}

class _BranchOptionBookingState extends State<BranchOptionBooking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stepper(
        currentStep: _index,
        onStepTapped: (int index) {
          setState(() {
            _index = index;
          });
        },
        steps: <Step>[
          Step(
            title: const Text('Chọn chi nhánh'),
            content: Column(
              children: [
                // Container(
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.black),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: Row(
                //     children: [
                //       CircleAvatar(
                //         backgroundColor: Colors.white,
                //         radius: 20,
                //         child: Image.asset(
                //           "assets/images/admin.png",
                //           height: 50,
                //         ),
                //       ),
                //       const SizedBox(width: 10),
                //       const Expanded(
                //         child: Text(
                //           'Đầu tiên anh <name> chọn “Xem tất cả chi nhánh REALMEN” ở ngay bên dưới để tìm Chi nhánh thuận tiện nhất nhé!',
                //           style: TextStyle(fontSize: 12, color: Colors.black),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý chuyển trang khi nhấn nút
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => YourNextScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.grey,
                    side: const BorderSide(color: Colors.grey),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text('Xem tất cả danh sách chi nhánh RealMen'),
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Chọn dịch vụ'),
            content: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Image.asset(
                          "assets/images/admin.png",
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Anh <name> chọn “Xem tất cả dịch vụ” bên dưới để chúng em chuẩn bị chu đáo ạ.',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý chuyển trang khi nhấn nút
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => YourNextScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.grey,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text('Xem tất cả danh sách dịch vụ'),
                ),
                const SizedBox(height: 10),
                Wrap(
                  children: textContainers,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Tổng số tiền anh cần thanh toán: 500.000.000 VNĐ",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          Step(
            title: const Text('Chọn stylist, ngày và giờ'),
            content: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Image.asset(
                          "assets/images/admin.png",
                          height: 50,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Text(
                          'Anh <name> hãy chọn “Stylist” tốt nhất và các yêu cầu khác trong lần đến REALMEN này.',
                          style: TextStyle(fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                ExpansionTile(
                  title: const Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Colors.black,
                        size: 16,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Chọn Stylist",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  children: [
                    SizedBox(
                      height: 70,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 20,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Stylist 1"),
                            ],
                          ),
                          SizedBox(width: 10),
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.blue,
                                radius: 20,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Stylist 2"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ExpansionTile(
                  title: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(6),
                        // width: 220,
                        height: 40,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              color: Colors.black,
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Row(
                              children: [
                                const Text(
                                  "HN, T3 (07/11)",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Container(
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                  child: const Text(
                                    "Ngày Thường",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Text("Ngày 1"),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Text("Ngày 2"),
                    ),
                    // TimeSlotScreen(),
                    const SizedBox(height: 10),
                    Container(
                      height: 200,
                      child: TimeSlot(),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 16,
                                ),
                                const Text(
                                  "Yêu Cầu Tư Vấn",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 50),
                                OnOffSwitch(),
                              ],
                            ),
                            const Text(
                              "Anh không cho phép các em giới thiệu về chương trình khuyến mãi, dịch vụ tốt nhất dành cho anh.",
                              style: TextStyle(fontSize: 12),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 16,
                                ),
                                const Text(
                                  "Chụp Hình Sau Khi Cắt",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                OnOffSwitch(),
                              ],
                            ),
                            const Text(
                              "Anh cho phép các em chụp hình lưu lại kiểu tóc, để lần sau không phải mô tả lại cho thợ khác.",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Xử lý chuyển trang khi nhấn nút
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => YourNextScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black12,
                        onPrimary: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        minimumSize: const Size(300, 50),
                      ),
                      child: const Text(
                        'Hoàn Thành',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
        controlsBuilder: (BuildContext context, ControlsDetails details) {
          return Container();
        },
      ),
    );
  }

  // Logic
  int _index = 0;

  List<Widget> textContainers = [
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'REALMEN Combo cắt gọi 100 bước ',
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'Cắt gọi 100 bước ',
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'Cắt gọi 100 bước ',
        style: TextStyle(fontSize: 12, color: Colors.black),
      ),
    ),
  ];
}
