import 'package:flutter/material.dart';

class ChooseStylistBooking extends StatefulWidget {
  const ChooseStylistBooking({Key? key}) : super(key: key);

  @override
  State<ChooseStylistBooking> createState() => _ChooseStylistBookingState();
}

class _ChooseStylistBookingState extends State<ChooseStylistBooking> {
  String _selectedOption = 'Stylist theo lịch sử cắt'; // Giá trị mặc định

  // Sample stylist history data
  List<Map<String, dynamic>> stylistHistoryData = [
    {
      'name': 'Stylist: Anh Tuấn',
      'specialization': 'Chuyên Môn: Cắt tóc, Uốn tóc, Nhuộm tóc',
      'branch':
          'Chi Nhánh: 411 Nguyễn Văn Tăng, P. Long Thạnh, Q.9, TP.Hồ Chí Minh',
      'services': ['Cắt gọi 100 bước', 'Massage 1'],
      'images': ['assets/barber/1.png', 'assets/barber/2.png'],
    },
    // Add more stylist history data as needed
  ];

  // Sample data for "Tất cả stylist" dropdown option
  List<Map<String, dynamic>> allStylistData = [
    {
      'name': 'Stylist: John Doe',
      'specialization': 'Chuyên Môn: Cắt tóc, Uốn tóc',
      'branch': 'Chi Nhánh: 123 ABC Street, XYZ Ward, City',
      'images': ['assets/barber/3.png', 'assets/barber/4.png'],
    },
    // Add more stylist data for "Tất cả stylist"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tìm kiếm theo tên stylist"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Tìm kiếm tên Stylist",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: DropdownButton<String>(
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
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              if (_selectedOption == 'Stylist theo lịch sử cắt')
                buildStylistList(stylistHistoryData),
              if (_selectedOption == 'Tất cả stylist')
                buildStylistListAll(allStylistData),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildStylistList(List<Map<String, dynamic>> stylistDataList) {
    return Container(
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
          children: stylistDataList.map((stylistData) {
            return Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(stylistData['name']),
                          Text(stylistData['specialization']),
                          Text(
                            stylistData['branch'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1.0,
                  height: 16.0,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Stylist Theo Lịch Sử Cắt",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            stylistData['branch'], //theo chi nhánh shop
                          ),
                          // Các phần khác của Widget Column
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text("Dịch Vụ:"),
                    SizedBox(width: 8.0),
                    ...List.generate(
                      stylistData['services'].length,
                      (index) => Container(
                        margin: EdgeInsets.only(
                            right: 8.0), // Khoảng cách giữa các border
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0, // Độ rộng của đường viền
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 4.0,
                        ),
                        child: Text(stylistData['services'][index]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    ...List.generate(
                      stylistData['images'].length,
                      (index) => Image.asset(
                        stylistData['images'][index],
                        width: 100.0,
                        height: 100.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          // Define the action for the "Chọn" button
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          side: BorderSide(
                            width: 2.0,
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                          ),
                        ),
                        child: Text("Chọn"),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Container(
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
                        child: Text("Xem thêm"),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget buildStylistListAll(List<Map<String, dynamic>> stylistDataList) {
    return Container(
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
          children: stylistDataList.map((stylistData) {
            return Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/avatar.png'),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(stylistData['name']),
                          Text(stylistData['specialization']),
                          Text(
                            stylistData['branch'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    ...List.generate(
                      stylistData['images'].length,
                      (index) => Image.asset(
                        stylistData['images'][index],
                        width: 100.0,
                        height: 100.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          // Define the action for the "Chọn" button
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.black,
                          onPrimary: Colors.white,
                          side: BorderSide(
                            width: 2.0,
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              20.0,
                            ),
                          ),
                        ),
                        child: Text("Chọn"),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    Container(
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
                        child: Text("Xem thêm"),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
