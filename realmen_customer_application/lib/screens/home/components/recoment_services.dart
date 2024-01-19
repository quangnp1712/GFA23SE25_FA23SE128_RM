// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:realmen_customer_application/models/service/service_model.dart';
import 'package:realmen_customer_application/service/categoryservice/category_services_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RecomendServices extends StatefulWidget {
  const RecomendServices({super.key});

  @override
  State<RecomendServices> createState() => _RecomendServicesState();
}

class _RecomendServicesState extends State<RecomendServices> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: GridView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        itemCount: serviceList!.length > 5 ? 5 : serviceList?.length,
        itemBuilder: (context, index) {
          return serviceList![index].serviceId != null
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
                            child: CachedNetworkImage(
                              imageUrl: serviceList![index]
                                  .serviceDisplayList![0]
                                  .serviceDisplayUrl!,
                              height: 160,
                              width: MediaQuery.of(context).size.width / 1.4,
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  value: progress.progress,
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                "assets/images/massage.jpg",
                                height: 140,
                                width: MediaQuery.of(context).size.width / 1.4,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
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

  bool _isDisposed = false;
  ServiceModel? serviceModel = ServiceModel();
  List<ServiceContent>? serviceList = [];
  final storage = FirebaseStorage.instance;
  List<String> urlList = [
    "1.jpg",
    "2.png",
    "3.png",
  ];

  @override
  void initState() {
    super.initState();
    getService();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> getService() async {
    if (!_isDisposed && mounted) {
      try {
        CategoryServices categoryServices = CategoryServices();
        final result = await categoryServices.getServiceList();
        if (result['statusCode'] == 200) {
          serviceModel = result['data'] as ServiceModel;
          serviceList = serviceModel!.content;
          //  Lấy Url image
          for (var service in serviceList!) {
            try {
              if (service.serviceDisplayList != null &&
                  service.serviceDisplayList!.isNotEmpty) {
                final String serviceDisplayUrl =
                    service.serviceDisplayList![0].serviceDisplayUrl.toString();
                var reference = storage.ref(serviceDisplayUrl);
                service.serviceDisplayList![0].serviceDisplayUrl =
                    await reference.getDownloadURL();
              }
            } catch (e) {
              final random = Random();
              var randomUrl = random.nextInt(urlList.length);
              var reference = storage.ref('service/${urlList[randomUrl]}');
              service.serviceDisplayList![0].serviceDisplayUrl =
                  await reference.getDownloadURL();
            }
          }
          setState(() {
            serviceList;
          });
        } else {
          // _errorMessage(result['message']);
          print(result);
        }
      } on Exception catch (e) {
        // _errorMessage("Vui lòng thử lại");
        print(e.toString());
      }
    }
  }
}
