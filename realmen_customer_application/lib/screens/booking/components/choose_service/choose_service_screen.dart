import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:realmen_customer_application/models/branch/branch_model.dart';
import 'package:realmen_customer_application/models/categoryservice/category_service.dart';
import 'package:realmen_customer_application/service/categoryservice/category_services_service.dart';
import 'package:sizer/sizer.dart';

import 'package:realmen_customer_application/service/change_notifier_provider/change_notifier_provider_service.dart';

class ChooseServiceBookingScreen extends StatefulWidget {
  @override
  _ChooseServiceBookingScreenState createState() =>
      _ChooseServiceBookingScreenState();
  static const String ChooseServiceBookingScreenRoute =
      "/choose-service-booking-screen";
  final selectedServices;
  final List<BranchServiceModel> branchServiceList;

  ChooseServiceBookingScreen(
      {required this.selectedServices, required this.branchServiceList});
}

class _ChooseServiceBookingScreenState
    extends State<ChooseServiceBookingScreen> {
  List<String> selectedServices = [];

  @override
  void initState() {
    super.initState();
    // var selectedServicesProvider =
    //     Provider.of<ChangeNotifierServices>(context, listen: false);
    // selectedServices = selectedServicesProvider.selectedServices;
    if (widget.selectedServices != null) {
      selectedServices = widget.selectedServices;
    }

    getServices();
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  void updateSelectedServiceCount(bool isSelected, String serviceName) {
    if (!_isDisposed && mounted) {
      setState(() {
        if (isSelected) {
          selectedServices.add(serviceName);
        } else {
          selectedServices.remove(serviceName);
        }
      });
      print(selectedServices);
    }
  }

  List<ServiceCategoryTile> serviceCategoryTileList = [];

  Future getServices() async {
    if (!_isDisposed && mounted) {
      serviceCategoryTileList = [];
      CategoryServices categoryServices = CategoryServices();
      try {
        final result = await categoryServices.getCategoryServiceList();
        if (result['statusCode'] == 200) {
          final List<CategoryModel> categoryList = result['data'].values;

          for (var caterogy in categoryList) {
            List<SubServiceModel> serviceList = [];
            if (caterogy.serviceList != null) {
// lấy branchservice so sánh vs service trong category
              List<SubServiceTile> serviceLists = [];
              for (var branchService in widget.branchServiceList) {
                bool check = caterogy.serviceList!.any(
                    (service) => service.serviceId! == branchService.serviceId);
                if (caterogy.serviceList!.any((service) =>
                        service.serviceId! == branchService.serviceId) ==
                    true) {
                  SubServiceTile subServiceTile = SubServiceTile(
                    selectedServices: selectedServices,
                    onSelect: (bool isSelected) {
                      updateSelectedServiceCount(
                          isSelected, branchService.serviceName!);
                    },
                    branchService: branchService,
                  );
                  serviceLists.add(subServiceTile);
                }
              }
              if (serviceLists.length > 0) {
                serviceCategoryTileList.add(ServiceCategoryTile(
                    title: caterogy.title!,
                    serviceLists: serviceLists,
                    isGridView: true));
              }
            }
          }
          setState(() {
            serviceCategoryTileList;
          });
        } else {
          print("${result['statusCode']}  ${result['error']}");
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var selectedServicesProvider = Provider.of<ChangeNotifierServices>(context);
    NumberFormat formatter = NumberFormat("#,##0");
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
                  bottom: 70,
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
                                        "chọn dịch vụ".toUpperCase(),
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
                              SubServiceTile(
                                selectedServices: selectedServices,
                                title: 'Combo Cắt 9 bước',
                                price: formatter.format(100000),
                                image: 'assets/images/3.png',
                                onSelect: (bool isSelected) {
                                  updateSelectedServiceCount(
                                      isSelected, 'Combo Cắt 9 bước');
                                },
                              ),
                              SubServiceTile(
                                selectedServices: selectedServices,
                                title: 'Combo Massage Cao Cấp',
                                price: formatter.format(200000),
                                image: 'assets/images/massage.jpg',
                                onSelect: (bool isSelected) {
                                  updateSelectedServiceCount(
                                      isSelected, 'Combo Massage Cao Cấp');
                                },
                              ),
                            ],
                            isGridView: false,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: serviceCategoryTileList.length,
                              itemBuilder: (context, index) {
                                return ServiceCategoryTile(
                                  title: utf8
                                      .decode(serviceCategoryTileList[index]
                                          .title
                                          .toString()
                                          .runes
                                          .toList())
                                      .toUpperCase(),
                                  serviceLists: serviceCategoryTileList[index]
                                      .serviceLists,
                                  isGridView: true,
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12.0,
                  left: 20.0,
                  right: 20.0,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        selectedServicesProvider
                            .updateSelectedServices(selectedServices);
                        Navigator.pop(context, selectedServices);
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.black),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8.0), // Độ bo tròn cho nút
                          ),
                        ),
                      ),
                      child: Text(
                        selectedServices.isEmpty
                            ? 'Chọn dịch vụ'.toUpperCase()
                            : 'Chọn ${selectedServices.length} dịch vụ'
                                .toUpperCase(),
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
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
  final List<SubServiceTile> serviceLists;
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
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 4,
            ),
            decoration: const BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: Colors.black,
                  width: 8,
                ),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        isGridView
            ? GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Thay đổi giá trị này nếu cần
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 2 / 3.4,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: serviceLists.length,
                itemBuilder: (context, index) {
                  return serviceLists[index];
                },
              )
            : Column(
                children: serviceLists,
              ),
      ],
    );
  }
}

class SubServiceTile extends StatefulWidget {
  final String? title;
  final String? price;
  final String? image;
  final Function(bool) onSelect; // Hàm callback
  final List<String> selectedServices;
  final BranchServiceModel? branchService;

  SubServiceTile({
    Key? key,
    this.title,
    this.price,
    this.image,
    required this.onSelect,
    required this.selectedServices,
    this.branchService,
  }) : super(key: key);

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
    // selectedServicesProvider =
    //     Provider.of<ChangeNotifierServices>(context, listen: false);
    // isSelected =
    //     selectedServicesProvider.selectedServices.contains(widget.title);
    if (widget.title != null) {
      isSelected = widget.selectedServices.contains(widget.title);
    } else {
      isSelected =
          widget.selectedServices.contains(widget.branchService!.serviceName);
    }
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
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(8),
              topLeft: Radius.circular(8),
            ),
            child: Image.asset(
              // widget.image != null
              //     ? widget.image!
              //     : widget.branchService!.thumbnailUrl!,
              'assets/images/massage.jpg',
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title != null
                      ? widget.title!
                      : utf8.decode(widget.branchService!.serviceName
                          .toString()
                          .runes
                          .toList()),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  widget.price != null
                      ? ' ${widget.price} VNĐ'
                      : ' ${widget.branchService!.price} VNĐ',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Container(
            width: 400,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: ElevatedButton(
              onPressed: () {
                _isSelected();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  isSelected ? Colors.red : Colors.white,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8.0), // Độ bo tròn cho nút
                  ),
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

  _isSelected() {
    setState(() {
      isSelected = !isSelected;
      widget.onSelect(isSelected);
    });
  }
}
