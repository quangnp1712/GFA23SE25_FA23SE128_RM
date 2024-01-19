// ignore_for_file: must_be_immutable, avoid_unnecessary_containers, avoid_print

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/models/account/account_info_model.dart';
import 'package:realmen_customer_application/models/booking/booking_model.dart';
import 'package:realmen_customer_application/models/branch/branch_model.dart';
import 'package:realmen_customer_application/models/categoryservice/category_model.dart';

import 'package:realmen_customer_application/screens/booking/components/choose_stylist_date_time/time-slot/time_slot.dart';
// ignore: unused_import
import 'package:realmen_customer_application/screens/booking/components/on_off_switch.dart';
import 'package:realmen_customer_application/service/categoryservice/category_services_service.dart';

import 'stylist/choose_stylist.dart';

class ChooseStylistAndDateTimeBooking extends StatefulWidget {
  final void Function(AccountInfoModel? stylist) onStylistSelected;
  final void Function(dynamic date) onDateSelected;
  final void Function(dynamic time) onTimeSelected;
  final List<BranchServiceModel> selectedService;

  List<AccountInfoModel>? accountStaffList;
  final void Function(List<BookingServiceModel> postBooking)
      onUpdatePostBooking;
  final void Function(bool oneToOne) onUpdateOption;

  ChooseStylistAndDateTimeBooking({
    super.key,
    required this.onStylistSelected,
    required this.onDateSelected,
    required this.onTimeSelected,
    required this.selectedService,
    required this.onUpdatePostBooking,
    required this.onUpdateOption,
    this.accountStaffList,
  });

  @override
  State<ChooseStylistAndDateTimeBooking> createState() =>
      _ChooseStylistAndDateTimeBookingState();
}

class _ChooseStylistAndDateTimeBookingState
    extends State<ChooseStylistAndDateTimeBooking> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, right: 15),
      constraints: const BoxConstraints(minHeight: 120),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "3. Chọn stylist & ngày, giờ ",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          stylistService.length >= 2
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.only(
                        left: 10, right: 0, top: 1, bottom: 1),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 1.5),
                          blurRadius: 1,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        hint: Text(
                          'Chọn stylist cho Tất cả dịch vụ',
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        alignment: Alignment.center,
                        value: optionController,
                        items: options != [] && options.isNotEmpty
                            ? options
                                .map((option) => DropdownMenuItem<String>(
                                      value: option,
                                      child: Text(
                                        option,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ))
                                .toList()
                            : [],
                        onChanged: (option) => setState(() {
                          optionController = option!;
                          print(optionController);
                          setData();
                          if (optionController ==
                              'Chọn stylist cho Tất cả dịch vụ') {
                            widget.onUpdateOption(false);
                          } else {
                            widget.onUpdateOption(true);
                          }
                          isChangeOptional = true;
                          // getBranches(option, false);
                        }),
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 200,
                          width: 325,
                          padding: const EdgeInsets.all(0),
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(14),
                            color: Colors.grey.shade200,
                          ),
                          offset: const Offset(-10, -6),
                          scrollbarTheme: ScrollbarThemeData(
                            // radius: const Radius.circular(40),
                            // thickness: MaterialStateProperty.all(6),
                            thumbVisibility: MaterialStateProperty.all(true),
                          ),
                        ),
                        menuItemStyleData: const MenuItemStyleData(
                          height: 40,
                          padding: EdgeInsets.only(left: 35, right: 24),
                        ),
                        buttonStyleData: const ButtonStyleData(
                          padding: EdgeInsets.all(0),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(),
          isLoading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      height: 50,
                      width: 50,
                      child: const CircularProgressIndicator(),
                    )
                  ],
                )
              : optionController == 'Chọn stylist cho Mỗi dịch vụ'
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children:
                                stylistService.asMap().entries.map((item) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),

                                  // Service
                                  Text(
                                    "${item.key + 1}.${utf8.decode(item.value.serviceName.toString().runes.toList())}"
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),

                                  // Chọn Stylist
                                  ChooseStylist(
                                    // chon 1 stylist -> booking home -> Bỏ
                                    onStylistSelected: widget.onStylistSelected,

                                    // data stylist hiện thị cho One To One
                                    // lần đầu full
                                    // chọn 1 lần hiện thị lại staff có cùng lại ca làm
                                    accountStaffList: accountStaffBranchList,
                                    updateSelectedStylist:
                                        updateSelectedStylist,

                                    // One by One
                                    oneToOne: true,

                                    // hàm add stylist vào post booking
                                    onAddStylistOTO: addStylistOTO,

                                    // data service ttrong service đc chọn
                                    service: item.value,

                                    //
                                    choseStylistUpdatePostBooking:
                                        choseStylistUpdatePostBooking,

                                    //
                                    updatePostBooking: updatePostBooking,
                                  ),
                                ],
                              );
                            }).toList()),
                        SizedBox(
                          height: 50,
                        ),

                        // Time Slot
                        ChooseDateAndTimeSlot(
                          // hàm trả ngày chọn
                          onDateSelected: widget.onDateSelected,

                          // hàm trả timeslot chọn
                          onTimeSelected: widget.onTimeSelected,

                          // thay bằng serviceOTOList
                          stylistSelected: null,
                          isChangeStylist: isChangeStylist,

                          // One by One
                          oneToOne: true,

                          // truyền service chỉ cho STYLIST
                          serviceOTOList: serviceOTOList,

                          // truyền stylist đã đc chọn để kiểm tra với post booking
                          staffOneToOne: staffOneToOne,

                          // truyền data staff cho One To One
                          accountStaffBranchList: accountStaffBranchList,

                          // Hàm để nhận data về thay đổi lịch là đổi ngi
                          onSetStylistShowOTO: setStylistShowOTO,

                          // lịch của 1 thg đại diện, dựa vào nó
                          // để làm drop dowwn
                          listDate: listDate,
                          isChangeOptional: isChangeOptional,

                          //
                          allowUpdateTimeslot: allowUpdateTimeslot,
                          updateStylistDone: updateStylistDone,

                          // change date
                          choseDateUpdateStylist: choseDateUpdateStylist,
                          isChangeDate: isChangeDate,
                          changeDateDone: changeDateDone,
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                  : // giữ nguyên cái cũ 1 - N
                  Column(
                      children: [
                        ChooseStylist(
                            onStylistSelected: widget.onStylistSelected,
                            accountStaffList: widget.accountStaffList,
                            updateSelectedStylist: updateSelectedStylist),
                        ChooseDateAndTimeSlot(
                          onDateSelected: widget.onDateSelected,
                          onTimeSelected: widget.onTimeSelected,
                          stylistSelected: stylistSelected,
                          isChangeStylist: isChangeStylist,
                          accountStaffList: widget.accountStaffList,
                          oneToOne: false,
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    stylistSelected;
    optionController = options.first;

    // gọi 1 lần
    setData();

    // kiểm tra staff chứa 3 ngày làm
    _validateWorkDateStylist();
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  void didUpdateWidget(ChooseStylistAndDateTimeBooking oldWidget) {
    if (optionController == options.first) {
      isChangeOptional = false;
      isChangeStylist = false;
    }
    isChangeOptional = false;
    // thay đổi service -> reset lại chọn stylist - date - timeslot
    if (!listEquals(oldWidget.selectedService, widget.selectedService)) {
      print("update option");
      optionController = options.first;
      setData();
    }

    // setData();
    // build(context);
    print("one to one: $optionController");
    super.didUpdateWidget(oldWidget);
  }

  bool isChangeOptional = false;
  bool isLoading = true;
  bool isChoseStylistDone = false;
  bool allowUpdateTimeslot = false;
  // Lấy staff cho time slot
  AccountInfoModel? stylistSelected = AccountInfoModel();
  String? optionController;
  List<String> options = [
    'Chọn stylist cho Tất cả dịch vụ',
    'Chọn stylist cho Mỗi dịch vụ'
  ];

  // kiểm tra staff chứa 1 trong 3 ngày làm
  // thay đổi widget.accountStaffList (data chọn stylist)
  _validateWorkDateStylist() {
    if (widget.accountStaffList != null) {
      // lấy account có lịch làm 3 ngày
      // lấy 1 staff ra để kiểm tra
      widget.accountStaffList = widget.accountStaffList!.where((staff) {
        DateTime now = DateTime.now();

        // giá trị cần lấy
        List<dynamic> listDate = [];

        // nếu staff kh có ca làm --> xóa
        if (staff.staff!.scheduleList == null ||
            staff.staff!.scheduleList!.isEmpty) {
          return false;
        } else {
          // kiểm tra có lịch làm trong 3 ngày kh
          // lấy ra lịch làm workingDate để kiểm tra
          staff.staff!.scheduleList!.asMap().entries.map((schedule) {
            // schedule của staff
            if (DateTime.parse(schedule.value.workingDate!) ==
                    DateTime(now.year, now.month, now.day, 0) ||
                (DateTime.parse(schedule.value.workingDate!).isAfter(now) &&
                    DateTime.parse(schedule.value.workingDate!)
                        .isBefore(now.add(const Duration(days: 2))))) {
              // giá trị cần lấy  listDate
              listDate.add(schedule.value);
            }
          }).toList();
          // có giá trị --> lấy
          if (listDate.isNotEmpty) {
            return true;
          } else {
            // -> remove
            return false;
          }
        }
      }).toList();
      setState(() {
        widget.accountStaffList;
      });
    }
  }

  bool isChangeStylist = false;
  void updateSelectedStylist(AccountInfoModel? stylistSelected) {
    setState(() {
      this.stylistSelected = stylistSelected;
      isChangeStylist = true;
      print(isChangeStylist);
    });
  }

  // lấy giá trị để truyền về booking tempora Pót booking
  List<BookingServiceModel> serviceOTOList = [];

  // lấy stylist đã được chọn để kiểm tra với post booking
  List<AccountInfoModel> staffOneToOne = [];

  // hàm lấy serviceOTO để thay đổi post booking
  // hàm lấy stylistSelected để thay đổi ?
  // xóa cũ thêm mới
  void addStylistOTO(BookingServiceModel serviceOTO) {
    // xóa cũ thêm mới
    if (serviceOTOList.isNotEmpty) {
      if (serviceOTOList.any(
          (serviceOTOs) => serviceOTOs.serviceId == serviceOTO.serviceId)) {
        serviceOTOList.removeWhere(
            (serviceOTOs) => serviceOTOs.serviceId == serviceOTO.serviceId);
        serviceOTOList.add(serviceOTO);
      }
    } else {
      serviceOTOList.add(serviceOTO);
    }
    widget.onUpdatePostBooking(serviceOTOList);

    // gán data vào staffOneToOne - stylist đã chọn
    // lấy staffId trong post booking để gán vào stylist đã chọn
    // reset data
    staffOneToOne = [];
    for (var serviceOTO in serviceOTOList) {
      if (serviceOTO.staffId != 0) {
        // lấy acc của branch để so sánh với stylist đã có trong post booking
        for (var accStaff in widget.accountStaffList!) {
          if (accStaff.staff!.staffId! == serviceOTO.staffId) {
            staffOneToOne.add(accStaff);
          }
        }
      }
    }
    // thay đổi data stylist hiển thị
    setStylistShowOTO(null);

    if (mounted) {
      setState(() {
        serviceOTOList;
        staffOneToOne;
        isChangeStylist = true;
      });
    }
  }

  List<Map<String, dynamic>> listDate = [];
  // lấy list date
  // lấy 3 ngày gần nhất so sánh với staff
  // rồi lấy staff so sánh vs các thằng còn lại
  // thay đổi data cho staff có cùng ca làm
  // chọn lịch đổi ngi
  void setStylistShowOTO(String? selectedDate) {
    try {
      // lấy 1 staff làm cột mốc
      if (staffOneToOne.length == 1) {
        if (selectedDate == null) {
          listDate = [];
          DateTime now = DateTime.now();
          // lấy từng acc để kiểm tra lịch làm

          // lấy từng lịch làm để kiểm tra
          staffOneToOne.first.staff!.scheduleList!
              .asMap()
              .entries
              .map((schedule) {
            // ktr lịch dropdown đã có data
            if (listDate.isNotEmpty) {
              // xóa trùng lịch
              listDate.removeWhere((date) =>
                  date['dateTime'] ==
                  "${DateTime.parse(schedule.value.workingDate!)}");
            }
            // ktr lịch làm của acc có hợp đk 3 ngày
            if (DateTime.parse(schedule.value.workingDate!) ==
                    DateTime(now.year, now.month, now.day, 0) ||
                (DateTime.parse(schedule.value.workingDate!).isAfter(now) &&
                    DateTime.parse(schedule.value.workingDate!)
                        .isBefore(now.add(const Duration(days: 2))))) {
              // add lịch dropdrown
              listDate.add({
                'id': schedule.key.toString(),
                'date': formatDate(
                    DateTime.parse(schedule.value.workingDate!))['date'],
                'type': formatDate(
                    DateTime.parse(schedule.value.workingDate!))['type'],
                'chosenDate': formatDate(
                    DateTime.parse(schedule.value.workingDate!))['chosenDate'],
                'start': schedule.value.startShift,
                'end': schedule.value.endShift,
                'dateTime': "${DateTime.parse(schedule.value.workingDate!)}",
              });
            }
          }).toList();
        }

        listDate.sort(((a, b) => a['dateTime'].compareTo(b['dateTime'])));

        // Timeslot
        // thay đổi data cho staff có cùng ca làm
        // khi chọn thg stylist đầu sẽ lấy nó làm mốc
        // lấy ngày chon ra ktr
        final String chosenDate;
        if (selectedDate != null) {
          chosenDate = selectedDate;
        } else {
          chosenDate = listDate.first['chosenDate'];
        }

        // reset data
        accountStaffBranchList =
            List<AccountInfoModel>.from(widget.accountStaffList!);
        //xóa
        // cùng ngày cùng ca
        accountStaffBranchList.removeWhere((accountStaff) {
          if (accountStaff.staff!.staffId ==
              staffOneToOne.first.staff!.staffId) {
            return false;
          }
          // lấy lịch làm của acc của branch
          for (var accountSchedule in accountStaff.staff!.scheduleList!) {
            // lấy lịch làm của stylist đã chọn đầu tiên
            for (var staffSchedule
                in staffOneToOne.first.staff!.scheduleList!) {
              // ktr ngày lich làm của cả 2 có = ngày đã chọn
              if (accountSchedule.workingDate == chosenDate &&
                  staffSchedule.workingDate == chosenDate) {
                // nếu 2 ca làm giống nhau -> kh xóa
                if (accountSchedule.shiftId == staffSchedule.shiftId) {
                  return false;
                }
              }
            } // ktra hết lịch làm của stylist đã chọn đầu tiên
            // vs 1 lịch làm của acc branch
          } // ktr hết
          // nếu chưa return là kh chứa -> xóa
          return true;
        });
      } else if (staffOneToOne.isEmpty) {
        accountStaffBranchList =
            List<AccountInfoModel>.from(widget.accountStaffList!);
        DateTime now = DateTime.now();
        listDate = [];
        for (int i = 0; i <= 2; i++) {
          listDate.add({
            'id': i.toString(),
            'date': formatDate(now.add(Duration(days: i)))['date'],
            'type': formatDate(now.add(Duration(days: i)))['type'],
            'chosenDate':
                "${formatDate(now.add(Duration(days: i)))['chosenDate']}",
          });
        }
      }
      if (mounted) {
        setState(() {
          listDate;
          accountStaffBranchList;
        });
      }
    } on Exception catch (e) {
      // _errorMessage("Vui lòng thử lại");
      print(e.toString());
    }
  }

  Map<String, dynamic> formatDate(DateTime date) {
    String day = DateFormat('EEEE').format(date);
    day = formatDay(day);
    return {
      'date': "$day, ${DateFormat('dd/MM/yyyy').format(date)}",
      'type':
          day == "Thứ bảy" || day == "Chủ nhật" ? "Cuối tuần" : "Ngày thường",
      'chosenDate': "${DateFormat('yyyy-MM-dd').format(date)}"
    };
  }

  String formatDay(String day) {
    return dayNames[day.toLowerCase()] ?? day;
  }

  final Map<String, String> dayNames = {
    'monday': 'Thứ hai',
    'tuesday': 'Thứ ba',
    'wednesday': 'Thứ tư',
    'thursday': 'Thứ năm',
    'friday': 'Thứ sáu',
    'saturday': 'Thứ bảy',
    'sunday': 'Chủ nhật'
  };

  // lấy giá trị để làm stylist - service (Listview.builder)
  List<BranchServiceModel> stylistService = [];
  List<BranchServiceModel> haircutService = [];
  List<BranchServiceModel> otherService = [];
  List<AccountInfoModel> accountStaffBranchList = [];
  // lấy data service cho optione ONE TO ONE
  // set data post booking cho random - chưa chọn stylist
  Future<void> setData() async {
    if (!_isDisposed && mounted && widget.selectedService.length > 1) {
      CategoryServices categoryServices = CategoryServices();
      stylistService = [];
      haircutService = [];
      otherService = [];
      serviceOTOList = [];
      isLoading = true;
      // optionController = options.first;
      try {
        accountStaffBranchList =
            List<AccountInfoModel>.from(widget.accountStaffList!);
        // lấy caterogy để kiểm tra service thuộc loại nào
        final result = await categoryServices.getCategoryServiceList();
        if (result['statusCode'] == 200) {
          final List<CategoryModel> categoryList = result['data'].values;

          // lấy 1 loại trong categoryList
          for (var category in categoryList) {
            // lấy 1 service trong service đc chọn
            for (var service in widget.selectedService) {
              // HAIR CUT
              if (category.categoryId == 2) {
                if (category.serviceList != null) {
                  if (category.serviceList!.any((cateService) =>
                      cateService.serviceId == service.serviceId)) {
                    haircutService.add(service);
                  }
                }
              }
              // OTHER UOONS NHUOM
              else if (category.categoryId == 3) {
                if (category.serviceList != null) {
                  if (category.serviceList!.any((cateService) =>
                      cateService.serviceId == service.serviceId)) {
                    otherService.add(service);
                  }
                }
              }
            }
          }
          stylistService.addAll(haircutService);
          stylistService.addAll(otherService);

          // lấy service của staff ra add vào post booking (serviceOTOList)
          for (var stylistServiceElement in stylistService) {
            BookingServiceModel newBookingServiceModel = BookingServiceModel(
              serviceId: stylistServiceElement.serviceId,
              staffId: 0,
              serviceName: stylistServiceElement.serviceName,
              servicePrice: stylistServiceElement.price ??
                  stylistServiceElement.branchServicePrice,
              staffName: "REALMEN sẽ chọn hộ bạn",
              bookingServiceType: "PICKUP_STYLIST",
            );
            serviceOTOList.add(newBookingServiceModel);
          }
          widget.onUpdatePostBooking(serviceOTOList);
        } else {
          // _errorMessage(result['message']);
          print(result);
        }
      } on Exception catch (e) {
        // _errorMessage("Vui lòng thử lại");
        print(e.toString());
      }
      print(stylistService.length);
      if (mounted) {
        setState(() {
          isLoading = false;
          serviceOTOList;
          stylistService;
          accountStaffBranchList;
        });
      }
    }
  }

  // CHƯA ADD VÀO CON STYLIST
  // hàm này khi chọn stylist
  void choseStylistUpdatePostBooking(BookingServiceModel serviceOTO) {
    // cập nhập lại postbooking
    // xóa cũ thêm mới
    if (serviceOTOList.isNotEmpty) {
      if (serviceOTOList.any(
          (serviceOTOs) => serviceOTOs.serviceId == serviceOTO.serviceId)) {
        serviceOTOList.removeWhere(
            (serviceOTOs) => serviceOTOs.serviceId == serviceOTO.serviceId);
        serviceOTOList.add(serviceOTO);
      }
    } else {
      serviceOTOList.add(serviceOTO);
    }
    widget.onUpdatePostBooking(serviceOTOList);

    // gán data vào staffOneToOne - stylist đã chọn
    // lấy staffId trong post booking để gán vào stylist đã chọn
    // reset data
    staffOneToOne = [];
    for (var serviceOTO in serviceOTOList) {
      if (serviceOTO.staffId != 0) {
        // lấy acc của branch để so sánh với stylist đã có trong post booking
        for (var accStaff in widget.accountStaffList!) {
          if (accStaff.staff!.staffId! == serviceOTO.staffId) {
            staffOneToOne.add(accStaff);
          }
        }
      }
    }

    // thay đổi data stylist hiển thị
    // lấy thg đầu ra ktr
    if (staffOneToOne.isEmpty) {
      accountStaffBranchList =
          List<AccountInfoModel>.from(widget.accountStaffList!);
      DateTime now = DateTime.now();
      listDate = [];
      for (int i = 0; i <= 2; i++) {
        listDate.add({
          'id': i.toString(),
          'date': formatDate(now.add(Duration(days: i)))['date'],
          'type': formatDate(now.add(Duration(days: i)))['type'],
          'chosenDate':
              "${formatDate(now.add(Duration(days: i)))['chosenDate']}",
        });
      }
    } else if (staffOneToOne.length == 1) {
      DateTime now = DateTime.now();
      // lấy từng acc để kiểm tra lịch làm

      listDate = [];
      // lấy từng lịch làm để kiểm tra
      staffOneToOne.first.staff!.scheduleList!.asMap().entries.map((schedule) {
        // ktr lịch dropdown đã có data
        if (listDate.isNotEmpty) {
          // xóa trùng lịch
          listDate.removeWhere((date) =>
              date['dateTime'] ==
              "${DateTime.parse(schedule.value.workingDate!)}");
        }
        // ktr lịch làm của acc có hợp đk 3 ngày
        if (DateTime.parse(schedule.value.workingDate!) ==
                DateTime(now.year, now.month, now.day, 0) ||
            (DateTime.parse(schedule.value.workingDate!).isAfter(now) &&
                DateTime.parse(schedule.value.workingDate!)
                    .isBefore(now.add(const Duration(days: 2))))) {
          // add lịch dropdrown
          listDate.add({
            'id': schedule.key.toString(),
            'date':
                formatDate(DateTime.parse(schedule.value.workingDate!))['date'],
            'type':
                formatDate(DateTime.parse(schedule.value.workingDate!))['type'],
            'chosenDate': formatDate(
                DateTime.parse(schedule.value.workingDate!))['chosenDate'],
            'start': schedule.value.startShift,
            'end': schedule.value.endShift,
            'dateTime': "${DateTime.parse(schedule.value.workingDate!)}",
          });
        }
      }).toList();

      listDate.sort(((a, b) => a['dateTime'].compareTo(b['dateTime'])));

      // Timeslot
      // thay đổi data cho staff có cùng ca làm
      // khi chọn thg stylist đầu sẽ lấy nó làm mốc
      // lấy ngày chon ra ktr
      final String chosenDate;

      chosenDate = listDate.first['chosenDate'];

      // reset data
      accountStaffBranchList =
          List<AccountInfoModel>.from(widget.accountStaffList!);
      //xóa
      // cùng ngày cùng ca
      accountStaffBranchList.removeWhere((accountStaff) {
        if (accountStaff.staff!.staffId == staffOneToOne.first.staff!.staffId) {
          return false;
        }
        // lấy lịch làm của acc của branch
        for (var accountSchedule in accountStaff.staff!.scheduleList!) {
          // lấy lịch làm của stylist đã chọn đầu tiên
          for (var staffSchedule in staffOneToOne.first.staff!.scheduleList!) {
            // ktr ngày lich làm của cả 2 có = ngày đã chọn
            if (accountSchedule.workingDate == chosenDate &&
                staffSchedule.workingDate == chosenDate) {
              // nếu 2 ca làm giống nhau -> kh xóa
              if (accountSchedule.shiftId == staffSchedule.shiftId) {
                return false;
              }
            }
          } // ktra hết lịch làm của stylist đã chọn đầu tiên
          // vs 1 lịch làm của acc branch
        } // ktr hết
        // nếu chưa return là kh chứa -> xóa
        return true;
      });

      if (mounted) {
        setState(() {
          // serviceOTOList; // kh thay data
          // staffOneToOne; //  kh thay data
          // listDate; // thay đổi UI Timeslot
          accountStaffBranchList; // thay đổi UI Stylist Timeslot
          isChangeStylist = true;
          allowUpdateTimeslot = false;
        });
      }
    }
  }

// sau khi thay đổi chọn stylist (CON STYLIST)
  void updatePostBooking(BookingServiceModel serviceOTO) {
// xóa cũ thêm mới
    if (serviceOTOList.isNotEmpty) {
      if (serviceOTOList.any(
          (serviceOTOs) => serviceOTOs.serviceId == serviceOTO.serviceId)) {
        serviceOTOList.removeWhere(
            (serviceOTOs) => serviceOTOs.serviceId == serviceOTO.serviceId);
        serviceOTOList.add(serviceOTO);
      }
    } else {
      serviceOTOList.add(serviceOTO);
    }
    widget.onUpdatePostBooking(serviceOTOList);

    staffOneToOne = [];
    for (var serviceOTO in serviceOTOList) {
      if (serviceOTO.staffId != 0) {
        // lấy acc của branch để so sánh với stylist đã có trong post booking
        for (var accStaff in widget.accountStaffList!) {
          if (accStaff.staff!.staffId! == serviceOTO.staffId) {
            staffOneToOne.add(accStaff);
          }
        }
      }
    }

    if (mounted) {
      setState(() {
        if (isChangeStylist) {
          serviceOTOList;
          staffOneToOne;
          listDate;
          allowUpdateTimeslot = true;
        } else if (isChangeDate) {
          allowUpdateTimeslot = true;
        }
      });
    }
  }

  void updateStylistDone() {
    if (mounted) {
      setState(() {
        allowUpdateTimeslot = false;
        isChangeStylist = false;
      });
    }
  }

  bool isChangeDate = false;
  void choseDateUpdateStylist(String selectedDate) {
    final String chosenDate = selectedDate;

    if (staffOneToOne.isEmpty) {
      accountStaffBranchList =
          List<AccountInfoModel>.from(widget.accountStaffList!);
      DateTime now = DateTime.now();
      listDate = [];
      for (int i = 0; i <= 2; i++) {
        listDate.add({
          'id': i.toString(),
          'date': formatDate(now.add(Duration(days: i)))['date'],
          'type': formatDate(now.add(Duration(days: i)))['type'],
          'chosenDate':
              "${formatDate(now.add(Duration(days: i)))['chosenDate']}",
        });
      }
    } else {
// reset data
      accountStaffBranchList =
          List<AccountInfoModel>.from(widget.accountStaffList!);
      //xóa
      // cùng ngày cùng ca
      accountStaffBranchList.removeWhere((accountStaff) {
        if (accountStaff.staff!.staffId == staffOneToOne.first.staff!.staffId) {
          return false;
        }
        // lấy lịch làm của acc của branch
        for (var accountSchedule in accountStaff.staff!.scheduleList!) {
          // lấy lịch làm của stylist đã chọn đầu tiên
          for (var staffSchedule in staffOneToOne.first.staff!.scheduleList!) {
            // ktr ngày lich làm của cả 2 có = ngày đã chọn
            if (accountSchedule.workingDate == chosenDate &&
                staffSchedule.workingDate == chosenDate) {
              // nếu 2 ca làm giống nhau -> kh xóa
              if (accountSchedule.shiftId == staffSchedule.shiftId) {
                return false;
              }
            }
          } // ktra hết lịch làm của stylist đã chọn đầu tiên
          // vs 1 lịch làm của acc branch
        } // ktr hết
        // nếu chưa return là kh chứa -> xóa
        return true;
      });
    }
    if (mounted) {
      setState(() {
        // listDate; // timeslot
        accountStaffBranchList; // sytlist timesslot
        allowUpdateTimeslot = false;
        isChangeDate = true;
        isChangeStylist = false;
      });
    }
  }

  void changeDateDone() {
    if (mounted) {
      setState(() {
        allowUpdateTimeslot = false;
        isChangeStylist = false;
        isChangeDate = false;
      });
    }
  }
}
