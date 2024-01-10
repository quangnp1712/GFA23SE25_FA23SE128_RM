// ignore_for_file: sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import 'package:realmen_staff_application/screens/task/booking_processing.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bg.png'),
                    fit: BoxFit.cover,
                  ),
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
                    child: Container(
                      padding: const EdgeInsets.only(top: 30),
                      width: 90.w,
                      height: 90.h,
                      // height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 7),
                            child: Center(
                              child: Stack(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    child: IconButton(
                                      alignment: Alignment.centerLeft,
                                      color: Colors.black,
                                      iconSize: 22,
                                      icon:
                                          const Icon(Icons.keyboard_arrow_left),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "đang phục vụ".toUpperCase(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 200,
                            // width: 300,

                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.arrow_back),
                                  onPressed: () {
                                    if (_currentPage > 0) {
                                      _pageController.previousPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                ),
                                Expanded(
                                  child: PageView.builder(
                                    controller: _pageController,
                                    itemCount: _images.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          _showFullScreenImage(context, index);
                                        },
                                        child: Hero(
                                          tag: 'selectedImage$index',
                                          child: Image.file(_images[index]),
                                        ),
                                      );
                                    },
                                    onPageChanged: (int page) {
                                      setState(() {
                                        _currentPage = page;
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward),
                                  onPressed: () {
                                    if (_currentPage < _images.length - 1) {
                                      _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 170,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 5.0,
                                crossAxisSpacing: 4.0,
                                childAspectRatio: 4 / 8,
                              ),
                              shrinkWrap: true,
                              itemCount: _images.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // Set the current page of PageView to the selected image
                                    if (_currentPage > 0) {
                                      _pageController.animateToPage(
                                        index,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    } else if (_currentPage <
                                        _images.length - 1) {
                                      _pageController.animateToPage(
                                        index,
                                        duration:
                                            const Duration(milliseconds: 300),
                                        curve: Curves.ease,
                                      );
                                    }
                                  },
                                  child: Image.file(
                                    _images[index],
                                    fit: BoxFit.contain,
                                    // height: 120,
                                    height: MediaQuery.of(context).size.height /
                                        7.3,
                                    alignment: Alignment.topCenter,
                                  ),
                                );
                              },
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 70.w,
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black54,
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.all(10),
                                      child: TextButton(
                                        onPressed: () {
                                          // _pickImageFromCamera();
                                          _pickImages();
                                        },
                                        child: const Center(
                                          child: Text(
                                            "Chụp ảnh",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black54,
                                            width: 1,
                                            style: BorderStyle.solid,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.all(10),
                                      child: TextButton(
                                        onPressed: () {
                                          _removeImage(_currentPage);
                                          print("Xóa ảnh: $_currentPage");
                                        },
                                        child: const Center(
                                          child: Text(
                                            "Xóa ảnh",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
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
    );
  }

  @override
  void initState() {
    super.initState();
  }

  List<File> _images = [];
  int _selectedImageIndex = 0;
  int _currentPage = 0;
  PageController _pageController = PageController();
  Future<void> _pickImages() async {
    // for (var i = 0; i < 4; i++) {
    if (_images.length < 4) {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _images.add(File(image.path));
        });
      }
    }
    // }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
      if (_selectedImageIndex == index) {
        _selectedImageIndex = 0;
      }
    });
  }

  void _showFullScreenImage(BuildContext context, int initialIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FullScreenImagePage(images: _images, initialIndex: initialIndex),
      ),
    );
  }
}

class FullScreenImagePage extends StatefulWidget {
  final List<File> images;
  final int initialIndex;

  FullScreenImagePage({required this.images, required this.initialIndex});

  @override
  _FullScreenImagePageState createState() => _FullScreenImagePageState();
}

class _FullScreenImagePageState extends State<FullScreenImagePage> {
  late PageController _pageController;
  bool _isZoomed = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            backgroundColor: Colors.black,
            iconTheme: const IconThemeData(color: Colors.white)),
        body:
            // Zoomed
            InteractiveViewer(
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Center(
                // slide
                child: Hero(
                  tag: 'selectedImage$index',
                  child: Image.file(widget.images[index]),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
