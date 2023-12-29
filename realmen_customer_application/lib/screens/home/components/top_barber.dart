// ignore_for_file: camel_case_types, avoid_unnecessary_containers

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class barberTop extends StatefulWidget {
  // const barberTop({super.key});

  const barberTop({super.key});

  @override
  State<barberTop> createState() => _barberTopState();
}

class _barberTopState extends State<barberTop> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: stylists.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: 320,
                  width: 200,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: const Color(0xA6444444))
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
                              child: FutureBuilder(
                                future: getImageFB(stylists[index].url!),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Widget> snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasData) {
                                      return snapshot
                                          .data!; // Return the widget when the future is complete
                                    } else {
                                      return Container(
                                          height:
                                              200); // Handle the case when the future completes with an error
                                    }
                                  } else {
                                    return const SizedBox(
                                        height: 200,
                                        child: Center(
                                            child:
                                                CircularProgressIndicator())); // Show a loading indicator while the future is in progress
                                  }
                                },
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
                                            children: [
                                              const WidgetSpan(
                                                child: Icon(
                                                  Icons.star,
                                                  color: Color(0xff323232),
                                                ),
                                              ),
                                              const WidgetSpan(
                                                child: SizedBox(width: 4),
                                              ),
                                              TextSpan(
                                                  text: stylists[index]
                                                      .rate
                                                      .toString()),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text.rich(
                                          TextSpan(
                                            style: TextStyle(
                                              fontSize: 17,
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                            ),
                                            children: [
                                              const WidgetSpan(
                                                child: Icon(
                                                  Icons.location_on,
                                                  color: Color(0xff323232),
                                                ),
                                              ),
                                              const WidgetSpan(
                                                child: SizedBox(width: 4),
                                              ),
                                              TextSpan(
                                                  text: stylists[index]
                                                      .city
                                                      .toString()),
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
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        stylists[index].name.toString(),
                                        maxLines: 2,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
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

  List<StylistModel> stylists = [
    StylistModel(
        name: 'Phương Quang', rate: 4.9, city: "Hồ Chí Minh", url: "1.jpg"),
    StylistModel(name: 'Anh Quân', rate: 4.8, city: "Thủ Đức", url: "2.jpg"),
    StylistModel(name: 'Quang Minh', rate: 4.9, city: "Đà Nẵng", url: "3.jpg"),
    StylistModel(name: 'Anh Tuấn', rate: 4.7, city: "Hà Nội", url: "4.jpg"),
  ];

  @override
  void initState() {
    super.initState();
  }

  // ignore: unused_field
  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  final storage = FirebaseStorage.instance;
  Future<Widget> getImageFB(String url) async {
    try {
      if (url != '') {
        var reference = storage.ref('stylist/$url');
        return Image.network(
          await reference.getDownloadURL(),
          scale: 1,
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        );
      } else {
        return Container(
          height: 200,
        );
      }
    } catch (e) {
      return Container(
        height: 200,
      );
    }
  }
}

class StylistModel {
  String? name;
  double? rate;
  String? city;
  String? url;

  StylistModel({
    this.name,
    this.rate,
    this.city,
    this.url,
  });
}
