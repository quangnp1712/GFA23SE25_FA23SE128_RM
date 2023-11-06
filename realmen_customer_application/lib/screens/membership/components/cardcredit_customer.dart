import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CardCreditCustomer extends StatefulWidget {
  const CardCreditCustomer({super.key});

  @override
  State<CardCreditCustomer> createState() => _CardCreditCustomerState();
}

class _CardCreditCustomerState extends State<CardCreditCustomer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Image.asset(
              'assets/images/logomembership.png',
              height: 200,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Anh Tuan",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.cut,
                            color: Colors.white,
                          ),
                          Text(
                            // điểm hiện có
                            "9999",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "-",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 20),
                          Text(
                            "Silver",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: LinearPercentIndicator(
                          width: 200.0,
                          animation: true,
                          animationDuration: 1000,
                          lineHeight: 10.0,
                          leading: const Text(
                            "50,000",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          trailing: const Text(
                            "200,000",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          percent: 0.2,
                          center: const Text(
                            "20%",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          progressColor: Colors.white,
                        ),
                      ),
                      const Text(
                        "Cần sử dụng thêm 150,000 điểm tích lũy để lên hạng Level 2",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
