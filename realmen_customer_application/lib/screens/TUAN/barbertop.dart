import 'package:flutter/material.dart';

class barberTop extends StatelessWidget {
  // const barberTop({super.key});
  List nameBarber = [
    'Nguyen Anh Quan.Nguyen Anh Quan Nguyen Anh Quan Nguyen Anh Quan',
    'Le Anh Tuan',
    'Tran Quang Minh',
    'Nguyen Phuong Quang',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 320,
                  width: 200,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xA6444444))
                      // boxShadow: const [
                      //   BoxShadow(
                      //     // color: kPrimaryColor.withOpacity(0.23),
                      //     blurRadius: 4,
                      //     spreadRadius: 2,
                      //   ),
                      // ],
                      ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                              child: Image.asset(
                                // "assets/barber/${index + 1}.png",
                                "assets/images/admin.png",
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                              child: Flex(
                                direction: Axis.vertical,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              fontSize: 17,
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                            children: const [
                                              WidgetSpan(
                                                child: Icon(
                                                  Icons.star,
                                                  color: Color(0xff323232),
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: SizedBox(width: 4),
                                              ),
                                              TextSpan(text: "4.5"),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              fontSize: 17,
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                            children: const [
                                              WidgetSpan(
                                                child: Icon(
                                                  Icons.location_on,
                                                  color: Color(0xff323232),
                                                ),
                                              ),
                                              WidgetSpan(
                                                child: SizedBox(width: 4),
                                              ),
                                              TextSpan(text: "Ho Chi Minh"),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 80,
                              child: Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      nameBarber[index],
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
