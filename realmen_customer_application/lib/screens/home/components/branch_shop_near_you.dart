import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';

class branchShopNearYou extends StatelessWidget {
  List nameShop = [
    'Nguyen Xuan Soan',
    'Hoang Sa',
    'Tran Huu Nghia',
    'Dien Bien Phu',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 290,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {},
            child: Container(
              width: MediaQuery.of(context).size.width / 1.4,
              margin:
                  const EdgeInsets.only(left: 15, top: 5, bottom: 5, right: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                      child: Image.asset(
                        // "assets/branchshop/${index + 1}.png",
                        "assets/images/admin.png",
                        height: 160,
                        width: MediaQuery.of(context).size.width / 1.4,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            nameShop[index],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "48 đường Trần Xuân Soạn, Quận 7, Phuường 3",
                            maxLines: 2,
                            style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 15,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 40,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xff444444),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Mở cừa: 7h - 23h",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: const Color(0xffE3E3E3),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  padding: const EdgeInsets.all(0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        // margin: const EdgeInsets.only(left: 5.0),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'đặt lịch'.toUpperCase(),
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Icon(
                                          CommunityMaterialIcons.arrow_right,
                                          color: Colors.black,
                                          size: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Center(
                                  //   child: Text(
                                  //     'đặt lịch'.toUpperCase(),
                                  //     textAlign: TextAlign.center,
                                  //     style: const TextStyle(
                                  //       fontSize: 20,
                                  //       color: Colors.black,
                                  //     ),
                                  //   ),
                                  // ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
