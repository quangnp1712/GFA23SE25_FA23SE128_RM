import 'package:flutter/material.dart';
import 'package:realmen_customer_application/screens/booking/components/on_off_switch.dart';
import 'package:realmen_customer_application/screens/booking/components/choose_stylist_date_time/time-slot/time_slot.dart';

class StylistOptionBooking extends StatefulWidget {
  const StylistOptionBooking({super.key});

  @override
  State<StylistOptionBooking> createState() => _StylistOptionBookingState();
}

class _StylistOptionBookingState extends State<StylistOptionBooking> {
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
            title: const Text('Chọn Stylist'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Xử lý chuyển trang khi nhấn nút
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => YourNextScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    side: const BorderSide(color: Colors.white),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.person, size: 16),
                      SizedBox(width: 5),
                      Text(
                        "Xem Stylist",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(width: 150),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
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
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Stylist: Phương Quang"),
                          SizedBox(height: 5),
                          Text("Chuyên môn: Cắt tóc, uốn tóc, nhuộm"),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Chi Nhánh Theo Stylist",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 400),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment
                              .topLeft, // Adjust the alignment as needed
                          child: Image.asset(
                            "assets/images/branch1.png",
                            height: 100,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment:
                                MainAxisAlignment.start, // Added this line
                            children: [
                              Text(
                                "Nguyễn Văn Tăng",
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5),
                              Text(
                                  "411 Nguyễn Văn Tăng, P. Long Thạnh, Q.9, TP.Hồ Chí Minh"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
            title: const Text("Chọn Ngày Và Giờ"),
            content: Column(
              children: [
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
                      child: TimeSlot(type: "d"),
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
    const SizedBox(
      width: 5,
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
    const SizedBox(width: 5),
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
