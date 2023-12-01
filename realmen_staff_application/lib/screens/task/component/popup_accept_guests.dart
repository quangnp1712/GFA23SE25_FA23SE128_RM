import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopUpAcceptGuest extends StatefulWidget {
  const PopUpAcceptGuest({super.key});

  @override
  State<PopUpAcceptGuest> createState() => _PopUpAcceptGuestState();
}

class _PopUpAcceptGuestState extends State<PopUpAcceptGuest> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "xác nhận phục vụ khách hàng".toUpperCase(),
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: Colors.grey.shade700,
          ),
          const SizedBox(
            height: 20,
          ),
          const Center(
            child: Text.rich(TextSpan(children: [
              WidgetSpan(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(Icons.account_circle),
                ),
              ),
              TextSpan(
                text: "Anh Tuấn - xxxxxx1487",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: Colors.black,
                ),
              )
            ])),
          ),
          const SizedBox(
            height: 35,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     Flexible(
          //       flex: 4,
          //       fit: FlexFit.tight,
          //       child: Container(
          //         // margin: const EdgeInsets.only(top: 22),
          //         // width: 70.w,
          //         height: 40,
          //         decoration: BoxDecoration(
          //           border: Border.all(color: Colors.black, width: 1),
          //           borderRadius: BorderRadius.circular(24),
          //         ),
          //         child: ElevatedButton(
          //           onPressed: () {
          //             Navigator.pop(context);
          //           },
          //           style: ElevatedButton.styleFrom(
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(24),
          //             ),
          //             backgroundColor: Colors.transparent,
          //             shadowColor: Colors.transparent,
          //           ),
          //           child: Text(
          //             "quay lại".toUpperCase(),
          //             style: const TextStyle(
          //                 fontSize: 22,
          //                 color: Colors.black,
          //                 fontWeight: FontWeight.w500),
          //           ),
          //         ),
          //       ),
          //     ),
          //     const Flexible(
          //       flex: 1,
          //       child: SizedBox(),
          //     ),
          //     Flexible(
          //       flex: 4,
          //       fit: FlexFit.tight,
          //       child: Container(
          //         // margin: const EdgeInsets.only(top: 22),
          //         // width: 70.w,
          //         height: 40,
          //         decoration: BoxDecoration(
          //           gradient: const LinearGradient(
          //               begin: Alignment.topLeft,
          //               end: Alignment.bottomRight,
          //               colors: [
          //                 Color(0xff302E2E),
          //                 Color(0xe6444141),
          //                 Color(0xe6444141),
          //                 Color(0x8c484646),
          //                 Color(0x26444141),
          //               ]),
          //           borderRadius: BorderRadius.circular(24),
          //         ),
          //         child: ElevatedButton(
          //           onPressed: () {
          //             Navigator.pop(context);
          //             // _logout(context);
          //           },
          //           style: ElevatedButton.styleFrom(
          //             shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(24),
          //             ),
          //             backgroundColor: Colors.transparent,
          //             shadowColor: Colors.transparent,
          //           ),
          //           child: Text(
          //             "ĐĂNG xuất".toUpperCase(),
          //             style: const TextStyle(
          //                 fontSize: 22,
          //                 color: Color(0xffC4C4C4),
          //                 fontWeight: FontWeight.w700),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ],
          // )
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Center(
                      child: Text(
                        "quay lại".toUpperCase(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      border: Border.all(
                        color: Colors.black54,
                        width: 1,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  margin: EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {},
                    child: Center(
                      child: Text(
                        "xác nhận".toUpperCase(),
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // // Logic
  // Future<void> _logout(BuildContext context) async {
  //   AuthenticateService authenticateService = AuthenticateService();
  //   authenticateService.logout();
  //   _errorMessage(context, "Đăng xuất");
  // }

  // void _errorMessage(BuildContext context, String? message) {
  //   try {
  //     ShowSnackBar.ErrorSnackBar(context, message!);
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
