import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:realmen_customer_application/service/change_notifier_provider/change_notifier_provider_service.dart';
import 'package:sizer/sizer.dart';

class ChooseServiceBookingScreen extends StatefulWidget {
  @override
  _ChooseServiceBookingScreenState createState() =>
      _ChooseServiceBookingScreenState();
  static const String ChooseServiceBookingScreenRoute =
      "/choose-service-booking-screen";
}

class _ChooseServiceBookingScreenState
    extends State<ChooseServiceBookingScreen> {
  List<String> selectedServices = [];

  @override
  void initState() {
    super.initState();
    var selectedServicesProvider =
        Provider.of<ChangeNotifierServices>(context, listen: false);
    selectedServices = selectedServicesProvider.selectedServices;
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void updateSelectedServiceCount(bool isSelected, String serviceName) {
    if (!_isDisposed) {
      setState(() {
        if (isSelected) {
          selectedServices.add(serviceName);
        } else {
          selectedServices.remove(serviceName);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var selectedServicesProvider = Provider.of<ChangeNotifierServices>(context);

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
                  bottom: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.only(top: 15, left: 0),
                      width: 90.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: ListView(
                        children: <Widget>[
                          Container(
                            color: Colors.transparent,
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
                                      icon:
                                          const Icon(Icons.keyboard_arrow_left),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "đặt lịch giữ chỗ".toUpperCase(),
                                        style: TextStyle(
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Dịch vụ đã chọn: ${selectedServices.length}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          ServiceCategoryTile(
                            title: 'RealMen Combo',
                            serviceLists: [
                              [
                                SubServiceTile(
                                  title: 'Combo 1',
                                  price: '20',
                                  image: 'assets/images/admin.png',
                                  onSelect: (bool isSelected) {
                                    updateSelectedServiceCount(
                                        isSelected, 'Combo 1');
                                  },
                                ),
                                SubServiceTile(
                                  title: 'Combo 2',
                                  price: '25',
                                  image: 'assets/images/admin.png',
                                  onSelect: (bool isSelected) {
                                    updateSelectedServiceCount(
                                        isSelected, 'Combo 2');
                                  },
                                ),
                              ],
                            ],
                            isGridView: false,
                          ),
                          ServiceCategoryTile(
                            title: 'Spa Services',
                            serviceLists: [
                              [
                                SubServiceTile(
                                  title: 'Facial',
                                  price: '30',
                                  image: 'assets/images/admin.png',
                                  onSelect: (bool isSelected) {
                                    updateSelectedServiceCount(
                                        isSelected, 'Facial');
                                  },
                                ),
                                SubServiceTile(
                                  title: 'Manicure',
                                  price: '15',
                                  image: 'assets/images/admin.png',
                                  onSelect: (bool isSelected) {
                                    updateSelectedServiceCount(
                                        isSelected, 'Manicure');
                                  },
                                ),
                              ],
                            ],
                            isGridView: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16.0,
                  left: 16.0,
                  right: 16.0,
                  child: ElevatedButton(
                    onPressed: () {
                      selectedServicesProvider
                          .updateSelectedServices(selectedServices);
                      Navigator.pop(context, selectedServices);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                    ),
                    child: Text(
                      selectedServices.isEmpty
                          ? 'Chọn dịch vụ'
                          : 'Chọn ${selectedServices.length} dịch vụ',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceCategoryTile extends StatelessWidget {
  final String title;
  final List<List<SubServiceTile>> serviceLists;
  final bool isGridView;

  ServiceCategoryTile({
    required this.title,
    required this.serviceLists,
    required this.isGridView,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(
              8.0), // Điều chỉnh khoảng cách xung quanh tiêu đề
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        for (var services in serviceLists)
          isGridView
              ? GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Thay đổi giá trị này nếu cần
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 2 / 3.3,
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    return services[index];
                  },
                )
              : Column(
                  children: services,
                ),
      ],
    );
  }
}

class SubServiceTile extends StatefulWidget {
  final String title;
  final String price;
  final String image;
  final Function(bool) onSelect; // Hàm callback

  SubServiceTile({
    required this.title,
    required this.price,
    required this.image,
    required this.onSelect,
  });

  @override
  State<SubServiceTile> createState() => _SubServiceTileState();
}

class _SubServiceTileState extends State<SubServiceTile> {
  bool isSelected = false;
  var selectedServicesProvider;

  @override
  void initState() {
    super.initState();
    // Khởi tạo trạng thái isSelected từ danh sách dịch vụ đã chọn
    selectedServicesProvider =
        Provider.of<ChangeNotifierServices>(context, listen: false);
    isSelected =
        selectedServicesProvider.selectedServices.contains(widget.title);
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(widget.image,
              width: double.infinity, height: 150, fit: BoxFit.cover),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  ' ${widget.price} VNĐ',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            width: 400,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isSelected = !isSelected;
                });
                widget.onSelect(isSelected);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  isSelected ? Colors.red : Colors.white,
                ),
              ),
              child: Text(
                isSelected ? 'Hủy' : 'Chọn',
                style: TextStyle(
                  fontSize: 18,
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
