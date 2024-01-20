// ignore_for_file: constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:realmen_customer_application/models/autocomplete/autocomplete_model.dart';
import 'package:realmen_customer_application/models/login_register/register_customer_model.dart';
import 'package:realmen_customer_application/screens/login/login_otp_screen.dart';
import 'package:realmen_customer_application/screens/message/success_screen.dart';
import 'package:realmen_customer_application/service/authentication/authenticate_service.dart';
import 'package:realmen_customer_application/service/autocomplete/autocomplete_service.dart';
import 'package:realmen_customer_application/service/share_prreference/share_prreference.dart';
import 'package:sizer/sizer.dart';
import 'dart:core';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static const String RegisterScreenRoute = "/register-screen";
  final bool isUnauth = Get.arguments as bool;
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100.h,
          child: Stack(
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
              Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: 30,
                    // bottom: 30,
                    // bottom: 10.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        width: 80.w,
                        height: null,
                        // constraints:
                        //     BoxConstraints(minHeight: 75.h, maxHeight: 80.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 3.h,
                                ),
                                Image.asset(
                                  'assets/images/logo.png',
                                  width: 257,
                                  // height: 59,
                                ),
                                SizedBox(
                                  height: 3.h,
                                ),
                                const Text(
                                  "ĐĂNG NHẬP",
                                  style: TextStyle(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xff444444),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                const Text(
                                  "Nhập thông tin",
                                  style: TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff444444),
                                  ),
                                ),
                                // Họ và tên
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  width: 70.w,
                                  // height: 40,
                                  child: TextFormField(
                                    controller: firstNameController,
                                    cursorColor: Colors.black,
                                    cursorWidth: 1,
                                    focusNode: _focusNodefirstName,
                                    // onTapOutside: (event) =>
                                    //     _focusNodefirstName.unfocus(),
                                    onEditingComplete: () =>
                                        _focusNodefirstName.unfocus(),
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                                      FilteringTextInputFormatter.allow(RegExp(
                                          r'[a-zA-Z\s]')), // Chỉ cho phép nhập chữ và khoảng trắng
                                      TextInputFormatter.withFunction(
                                          (oldValue, newValue) {
                                        if (newValue.text.isEmpty) {
                                          return newValue;
                                        }
                                        return TextEditingValue(
                                          text: newValue.text.replaceAllMapped(
                                              RegExp(r'\b\w'),
                                              (match) => match
                                                  .group(0)!
                                                  .toUpperCase()), // In hoa chữ cái đầu của từng từ
                                          selection: newValue.selection,
                                        );
                                      }),
                                    ],
                                    keyboardType: TextInputType.text,
                                    style: const TextStyle(
                                        height: 1.17,
                                        fontSize: 20,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffC4C4C4)),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffC4C4C4)),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffC4C4C4)),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          // top: 10,
                                          // bottom: 20,
                                          left: 15,
                                          right: 15),
                                      hintText: "Nhập Họ và Tên đệm của bạn",
                                      hintStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffC4C4C4)),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Vui lòng không để trống Họ và Tên đệm của bạn';
                                      }

                                      return null; // Trả về null nếu không có lỗi
                                    },
                                  ),
                                ),
                                // Tên
                                SizedBox(
                                  height: 2.h,
                                ),

                                SizedBox(
                                  width: 70.w,
                                  // height: 40,
                                  child: TextFormField(
                                    controller: lastNameController,
                                    cursorColor: Colors.black,
                                    cursorWidth: 1,
                                    focusNode: _focusNodelastName,
                                    // onTapOutside: (event) =>
                                    //     _focusNodelastName.unfocus(),
                                    onEditingComplete: () =>
                                        _focusNodelastName.unfocus(),
                                    inputFormatters: [
                                      FilteringTextInputFormatter
                                          .singleLineFormatter, // Đảm bảo chỉ nhập trên một dòng
                                      TextInputFormatter.withFunction(
                                          (oldValue, newValue) {
                                        if (newValue.text.isEmpty) {
                                          return newValue;
                                        }
                                        return TextEditingValue(
                                          text: newValue.text.replaceAllMapped(
                                              RegExp(r'\b\w'),
                                              (match) => match
                                                  .group(0)!
                                                  .toUpperCase()), // In hoa chữ cái đầu của từng từ
                                          selection: newValue.selection,
                                        );
                                      }),
                                      FilteringTextInputFormatter.deny(RegExp(
                                          r'[\s]')), // Không cho phép khoảng trắng
                                      FilteringTextInputFormatter.allow(RegExp(
                                          r'[a-zA-Z]')), // Chỉ cho phép nhập chữ
                                    ],
                                    keyboardType: TextInputType
                                        .text, // Hiển thị bàn phím là chữ

                                    style: const TextStyle(
                                        height: 1.17,
                                        fontSize: 20,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffC4C4C4)),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffC4C4C4)),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffC4C4C4)),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          // top: 10,
                                          // bottom: 20,
                                          left: 15,
                                          right: 15),
                                      hintText: "Nhập Tên của bạn",
                                      hintStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffC4C4C4)),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Vui lòng không để trống Tên của bạn';
                                      }

                                      return null; // Trả về null nếu không có lỗi
                                    },
                                  ),
                                ),

                                // Địa chỉ
                                SizedBox(
                                  height: 2.h,
                                ),
                                SizedBox(
                                  width: 70.w,
                                  // height: 50,
                                  child: FocusScope(
                                    node: focusScopeNode,
                                    child: Autocomplete<PredictionModel>(
                                      displayStringForOption:
                                          displayStringForOption,
                                      initialValue: TextEditingValue(
                                          text: addressController.text),
                                      optionsBuilder: (textEditingValue) async {
                                        if (textEditingValue.text.isEmpty ||
                                            textEditingValue.text == '') {
                                          return const Iterable.empty();
                                        }
                                        final value = await autocompleteService
                                            .getAutocomplete(
                                                textEditingValue.text);
                                        if (value['statusCode'] == 200) {
                                          autocompleteModel = value['data'];
                                          options = value['data']
                                              ?.predictions!
                                              .where((element) => utf8
                                                  .decode(element.description!
                                                      .toString()
                                                      .runes
                                                      .toList())
                                                  .toLowerCase()
                                                  .contains(textEditingValue
                                                      .text
                                                      .toLowerCase()));

                                          return Future.value(options);
                                        }
                                        return [];
                                      },
                                      onSelected: (address) {
                                        debugPrint(
                                            'You just selected $address');
                                        addressController.text = utf8.decode(
                                            address.description!
                                                .toString()
                                                .runes
                                                .toList());
                                        setState(() {
                                          focusScopeNode.unfocus();
                                        });
                                      },
                                      fieldViewBuilder: (context, controller,
                                          focusNode, onEditingComplete) {
                                        return TextFormField(
                                          // controller: addressController,
                                          controller: controller,
                                          focusNode: focusNode,
                                          onEditingComplete: onEditingComplete,
                                          // onTapOutside: (event) =>
                                          //     focusNode.unfocus(),
                                          cursorColor: Colors.black,
                                          cursorWidth: 1,
                                          style: const TextStyle(
                                              height: 1.17,
                                              fontSize: 20,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffC4C4C4)),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffC4C4C4)),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xffC4C4C4)),
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    // top: 10,
                                                    // bottom: 20,
                                                    left: 15,
                                                    right: 15),
                                            hintText: "Nhập Địa chỉ của bạn",
                                            hintStyle: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xffC4C4C4),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                // DOB
                                SizedBox(
                                  height: 2.h,
                                ),

                                SizedBox(
                                  width: 70.w,
                                  // height: 40,
                                  child: TextFormField(
                                    controller: dobController,
                                    readOnly: true,
                                    cursorColor: Colors.black,
                                    cursorWidth: 1,
                                    style: const TextStyle(
                                        height: 1.17,
                                        fontSize: 20,
                                        color: Colors.black),
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffC4C4C4)),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffC4C4C4)),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xffC4C4C4)),
                                        borderRadius: BorderRadius.circular(24),
                                      ),
                                      contentPadding: const EdgeInsets.only(
                                          // top: 10,
                                          // bottom: 20,
                                          left: 15,
                                          right: 15),
                                      hintText: "Nhập Ngày sinh dd/mm/yyyy",
                                      hintStyle: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xffC4C4C4)),
                                    ),
                                    onTap: _selectDate,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Vui lòng không để trống Ngày sinh của bạn';
                                      }

                                      return null; // Trả về null nếu không có lỗi
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                // Gender
                                Container(
                                  // margin: const EdgeInsets.only(top: 22),
                                  width: 70.w,
                                  // height: 40,
                                  // padding: EdgeInsets.symmetric(horizontal: 15),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                        color: const Color(0xffC4C4C4)),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        isExpanded: true,
                                        iconSize: 20,
                                        padding: const EdgeInsets.only(
                                            left: 15, right: 15),
                                        value: genderController,
                                        items: genders
                                            .map((item) =>
                                                DropdownMenuItem<String>(
                                                  value: item,
                                                  child: Text(item,
                                                      style: const TextStyle(
                                                          fontSize: 20)),
                                                ))
                                            .toList(),
                                        onChanged: (item) => setState(
                                            () => genderController = item)),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.5.h,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // margin: const EdgeInsets.only(top: 22),
                                        width: 24.w,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          color: Colors.white,
                                          border: Border.all(
                                              color: const Color(0xffC4C4C4),
                                              width: 1,
                                              style: BorderStyle.solid),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            padding: const EdgeInsets.only(
                                                left: 1, right: 1),
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                          ),
                                          child: Text(
                                            "quay lại".toUpperCase(),
                                            style: const TextStyle(
                                                letterSpacing: 0.5,
                                                fontSize: 18,
                                                color: Colors.black,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        // margin: const EdgeInsets.only(top: 22),
                                        width: 43.w,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xff302E2E),
                                                Color(0xe6444141),
                                                Color(0x8c484646),
                                                Color(0x26444141),
                                              ]),
                                          borderRadius:
                                              BorderRadius.circular(24),
                                        ),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _focusNodefirstName.unfocus();
                                            _focusNodelastName.unfocus();
                                            if (_formKey.currentState!
                                                .validate()) {
                                              submitRegister();
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(24),
                                            ),
                                            backgroundColor: Colors.transparent,
                                            shadowColor: Colors.transparent,
                                          ),
                                          child: const Text(
                                            "HOÀN TẤT",
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Color(0xffC4C4C4),
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2.5.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  // Logic
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  List<String> genders = ['NAM', 'NỮ'];
  String? genderController = 'NAM';
  DateTime? dobSubmit;

  AutocompleteModel? autocompleteModel = AutocompleteModel();
  Iterable<PredictionModel>? options;
  final AutocompleteService autocompleteService = AutocompleteService();

  String displayStringForOption(PredictionModel prediction) =>
      utf8.decode(prediction.description!.toString().runes.toList());

  final FocusNode _focusNodefirstName = FocusNode();
  final FocusNode _focusNodelastName = FocusNode();

  FocusNode focusNode = FocusNode();
  FocusScopeNode focusScopeNode = FocusScopeNode();

  Future<void> _selectDate() async {
    if (!_isDisposed && mounted) {
      DateTime? dob = await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );

      if (dob != null) {
        if (!_isDisposed && mounted) {
          setState(() {
            dobSubmit = dob;
            dobController.text =
                DateFormat('dd-MM-yyyy').format(dob).toString().split(" ")[0];
          });
        }
        print(dobController.toString());
      }
    }
  }

  void submitRegister() async {
    String firstName = firstNameController.text.toString();
    String lastName = lastNameController.text.trim().toString();
    String address = addressController.text.toString();
    String dob = dobSubmit!.toIso8601String();
    String gender = genderController.toString();
    String thumbnailUrl = "";
    String status = "ACTIVATED";

    RegisterCustomerModel registerCustomerModel = RegisterCustomerModel(
        thumbnailUrl: thumbnailUrl,
        firstName: firstName,
        lastName: lastName,
        address: address,
        gender: gender,
        status: status,
        dob: dob);
    AuthenticateService authenticateService = AuthenticateService();
    if (!_isDisposed && mounted) {
      try {
        var result =
            await authenticateService.registerCustomer(registerCustomerModel);
        if (result['statusCode'] == 200) {
          _successMessage("Nhập thông tin thành công");
          // Navigator.pushNamed(context, LoginOTPScreen.LoginOTPScreenRoute);
          Get.toNamed(LoginOTPScreen.LoginOTPScreenRoute);
        } else if (result['statusCode'] == 500) {
          _errorMessage(result['message']);
        } else {
          _errorMessage("Nhập thông tin thất bại");
          print("$result");
        }
      } catch (e) {
        _errorMessage("Vui lòng thử lại");
        print(e.toString());
      }
    }
  }

  void _successMessage(String? message) {
    try {
      ShowSnackBar.SuccessSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

  void _errorMessage(String? message) {
    try {
      ShowSnackBar.ErrorSnackBar(context, message!);
    } catch (e) {
      print(e);
    }
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    focusNode.dispose();
    _isDisposed = true;
    super.dispose();
  }

  // thay đôi height

  @override
  void initState() {
    super.initState();
  }

  Future<void> getUnauth() async {
    if (!_isDisposed && mounted) {
      try {
        AuthenticateService authenticateService = AuthenticateService();
        String phone = await SharedPreferencesService.getPhone();
        var result = await authenticateService.getAccountUnauth(phone);
        if (result['statusCode'] == 200) {
          RegisterCustomerModel registerCustomerModel = result['data'];
          setState(() {
            firstNameController.text = registerCustomerModel.firstName!;
            lastNameController.text = registerCustomerModel.lastName!;
            addressController.text = registerCustomerModel.address!;
            dobSubmit = DateTime.parse(registerCustomerModel.dob!);
            genderController = registerCustomerModel.gender;
          });
        } else if (result['statusCode'] == 500) {
          _errorMessage(result['message']);
        } else {
          print("$result");
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
