import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:post_tour/controllers/hive_controller.dart';
import 'package:post_tour/model/get_user_data_model.dart';
import 'package:post_tour/screens/all_tours.dart';
import 'package:svg_flutter/svg.dart';
import '../controllers/tours_controller.dart';
import 'details_screen.dart';
import 'introduction_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AllToursController allToursController = Get.put(AllToursController());
  HiveController hiveController = Get.put(HiveController());
  File? _imageFile;
  GetDataUserModel userDetailsApi =
      HiveController().getDetails(objKey: "userDetailsKey");

  Future<void> _loadImage() async {
    File? imageFile = await hiveController.getImage();
    setState(() {
      _imageFile = imageFile;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the controller

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: _imageFile == null
                      ? AssetImage("assets/image/avatar.jpeg")
                      : FileImage(_imageFile!) as ImageProvider,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      userDetailsApi.firstName.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    )),
                Expanded(child: Container()),
                InkWell(
                  onTap: () {
                    Get.off(IntroductionScreen());
                  },
                  child: const Card(
                      child: SizedBox(
                          height: 35,
                          width: 35,
                          child:
                              Center(child: Icon(IconlyLight.notification)))),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              height: 800,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xffBBBDBE),
                    Color(0xffF2F4F5),
                  ],
                ),
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 5),
                  child: Row(
                    children: [
                      const Text(
                        "Popular place",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Expanded(child: Container()),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllToursPage()));
                          },
                          child: const Text(
                            "See all",
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
                ),
                Container(
                    height: 170,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black38,
                            offset: Offset(15, 8),
                            blurRadius: 15,
                            spreadRadius: 1),
                      ],
                    ),
                    child: Obx(() {
                      if (allToursController.tours.isEmpty) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: allToursController.tours.length,
                        itemBuilder: (context, index) {
                          final tours = allToursController.tours[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailPlaceCard(
                                        tours: tours, index: index)),
                              );
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                height: 160,
                                width: 270,
                                decoration: BoxDecoration(
                                  image: tours.images != null &&
                                          tours.images!.isNotEmpty
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              tours.images!.first.image!),
                                          fit: BoxFit.cover,
                                        )
                                      : null,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: 50,
                                  width: 300,
                                  decoration: const BoxDecoration(
                                      color: Colors.black87,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(15),
                                          bottomLeft: Radius.circular(15))),
                                  child: GridTileBar(
                                    title: Text(
                                      tours.placeName ?? '',
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(right: 2),
                                            child: Icon(
                                              IconlyBold.location,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            tours.body ?? '',
                                            style: const TextStyle(
                                                fontSize: 11,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                    trailing: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/svg/star2.svg",
                                          color: const Color(0xffFF9505),
                                          height: 18,
                                          width: 18,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          "4.5",
                                          // Placeholder for rating, update as needed
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      // )
                    })),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                  child: Row(
                    children: [
                      const Text(
                        "Recomendation for you",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                      Expanded(child: Container()),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllToursPage()));
                          },
                          child: const Text(
                            "See all",
                            style: TextStyle(color: Colors.blue),
                          ))
                    ],
                  ),
                ),
                Container(
                  height: 300,
                  child: Obx(() {
                    if (allToursController.tours.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: allToursController.tours.length,
                      itemBuilder: (context, index) {
                        final tours = allToursController.tours[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailPlaceCard(
                                      tours: tours, index: index)),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            child: Container(
                              height: 90,
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xffC8C8C8),
                                      Color(0xffFEFEFE),
                                      Color(0xffFFFFFF),
                                    ],
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15)),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(5),
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: tours.images != null &&
                                              tours.images!.isNotEmpty
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                  tours.images!.first.image!),
                                              fit: BoxFit.cover,
                                            )
                                          : null,
                                      color: Colors.grey[200],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5, top: 5),
                                          child: Text(
                                            tours.placeName ?? '',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              IconlyBold.location,
                                              size: 15,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              tours.title ?? '',
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: SvgPicture.asset(
                                                "assets/svg/star2.svg",
                                                height: 13,
                                                color: const Color(0xffFF9505),
                                                width: 13,
                                              ),
                                            ),
                                            Text(
                                              "5",
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    alignment: Alignment.bottomRight,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '\$${tours.cost}' ?? '',
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        const Text(
                                          "/Person",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 12),
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
                    );
                  }),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
