import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realmen_customer_application/screens/membership/components/cardcredit_customer.dart';
import 'package:realmen_customer_application/screens/membership/components/labeltext_level.dart';
import 'package:sizer/sizer.dart';

class MembershipScreen extends StatefulWidget {
  Function callback;
  MembershipScreen(this.callback, {super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
  static const String MembershipScreenRoute = "/membership-screen";
}

class _MembershipScreenState extends State<MembershipScreen> {
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
                              children: [
                                SizedBox(
                                  height: 50,
                                  child: IconButton(
                                    alignment: Alignment.centerLeft,
                                    color: Colors.black,
                                    iconSize: 22,
                                    icon: const Icon(Icons.keyboard_arrow_left),
                                    onPressed: () {
                                      widget.callback(0);
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      "realmen member".toUpperCase(),
                                      style: GoogleFonts.quicksand(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Column(
                        children: [
                          const SizedBox(height: 30),
                          const CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                AssetImage('assets/images/admin.png'),
                          ),
                          Container(
                            height: 250,
                            child: const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: CardCreditCustomer(),
                            ),
                          ),
                          const SizedBox(height: 5),
                          LabelTextLevel(),
                        ],
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
}
