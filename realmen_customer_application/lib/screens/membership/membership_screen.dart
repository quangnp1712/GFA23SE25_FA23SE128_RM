import 'package:flutter/material.dart';
import 'package:realmen_customer_application/screens/membership/components/cardcredit_customer.dart';
import 'package:realmen_customer_application/screens/membership/components/labeltext_level.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage('assets/images/admin.png'),
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
      ),
    );
  }
}
