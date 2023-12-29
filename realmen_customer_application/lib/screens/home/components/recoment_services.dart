// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:realmen_customer_application/models/service/service_model.dart';
import 'package:realmen_customer_application/service/categoryservice/category_services_service.dart';

class RecomendServices extends StatefulWidget {
  const RecomendServices({super.key});

  @override
  State<RecomendServices> createState() => _RecomendServicesState();
}

class _RecomendServicesState extends State<RecomendServices> {
  List nameService = [
    'Cắt tóc',
    'Dưỡng tóc',
    'Massage loại 1',
    'Massage loại 2',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: serviceList!.length > 5 ? 5 : serviceList?.length,
        itemBuilder: (context, index) {
          // ignore: unnecessary_null_comparison
          return serviceList![index] != null
              ? InkWell(
                  onTap: () {},
                  child: Container(
                    height: 204,
                    width: MediaQuery.of(context).size.width / 1.4,
                    margin: const EdgeInsets.only(
                        left: 15, top: 5, bottom: 5, right: 5),
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
                              child: FutureBuilder<Widget>(
                                future: getImageFB(serviceList![index]),
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
                                              140); // Handle the case when the future completes with an error
                                    }
                                  } else {
                                    return const SizedBox(
                                        height: 140,
                                        child: Center(
                                            child:
                                                CircularProgressIndicator())); // Show a loading indicator while the future is in progress
                                  }
                                },
                              )),
                          SizedBox(
                            height: 56,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  // ignore: unnecessary_null_comparison
                                  serviceList![index].name! != null
                                      ? utf8.decode(serviceList![index]
                                          .name!
                                          .runes
                                          .toList())
                                      : "",
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                // Text(
                                //   "90,0000 VNĐ",
                                //   style: TextStyle(
                                //     fontSize: 15,
                                //     color: Colors.white.withOpacity(0.8),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getService();
  }

  bool _isDisposed = false;
  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  ServiceModel? serviceModel = ServiceModel();
  List<ServiceContent>? serviceList = [];
  Future<void> getService() async {
    if (!_isDisposed) {
      try {
        CategoryServices categoryServices = CategoryServices();
        final result = await categoryServices.getServiceList();
        if (result['statusCode'] == 200) {
          serviceModel = result['data'] as ServiceModel;
          serviceList = serviceModel!.content;
          setState(() {
            serviceList;
          });
        } else {
          print("$result['statusCode'] : $result['error']");
        }
      } on Exception catch (e) {
        print("Error: $e");
      }
    }
  }

  final storage = FirebaseStorage.instance;
  List<String> urlList = [
    "1.jpg",
    "2.png",
    "3.png",
  ];
  Future<Widget> getImageFB(ServiceContent service) async {
    try {
      if (service.serviceDisplayList != null &&
          service.serviceDisplayList!.isNotEmpty) {
        final String serviceDisplayUrl =
            service.serviceDisplayList![0].serviceDisplayUrl.toString();
        var reference = storage.ref('service/$serviceDisplayUrl');
        return Image.network(
          await reference.getDownloadURL(),
          scale: 1,
          height: 160,
          width: MediaQuery.of(context).size.width / 1.4,
          fit: BoxFit.cover,
        );
      } else {
        return Container();
      }
    } catch (e) {
      final random = Random();
      var randomUrl = random.nextInt(urlList.length);
      var reference = storage.ref('service/${urlList[randomUrl]}');
      return Image.network(
        await reference.getDownloadURL(),
        scale: 1,
        height: 160,
        width: MediaQuery.of(context).size.width / 1.4,
        fit: BoxFit.cover,
      );
    }
  }
}
