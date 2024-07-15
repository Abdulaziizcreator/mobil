import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:post_tour/controllers/hive_controller.dart';
import 'package:post_tour/model/get_user_data_model.dart';

import 'booking_screen.dart';
import 'edit_prifile_details.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  GetDataUserModel userDetailsApi =
      HiveController().getDetails(objKey: "userDetailsKey");
  HiveController hiveController = Get.put(HiveController());

  File? _imageFile;

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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
          child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileInfoScreen(
                                firstName: userDetailsApi.firstName!.isNotEmpty
                                    ? userDetailsApi.firstName.toString()
                                    : "User name",
                                lastName: userDetailsApi.lastName!.isNotEmpty
                                    ? userDetailsApi.lastName.toString()
                                    : "User lastname",
                                phoneNumber:
                                    userDetailsApi.phoneNumber!.isNotEmpty
                                        ? userDetailsApi.phoneNumber.toString()
                                        : "Phone number",
                                email: userDetailsApi.email!.isNotEmpty
                                    ? userDetailsApi.email.toString()
                                    : "User email"),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          color: Colors.black,
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        child: InkWell(
                          onTap: () async {
                            File? newImage = await hiveController.pickImage();
                            setState(() {
                              _imageFile = newImage;
                            });
                          },
                          child: CircleAvatar(
                            radius: 60,
                            backgroundImage: _imageFile == null
                                ? AssetImage("assets/image/avatar.jpeg")
                                : FileImage(_imageFile!) as ImageProvider,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userDetailsApi.firstName!.isNotEmpty
                                  ? userDetailsApi.firstName.toString()
                                  : "User name",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 23),
                            ),
                            Text(
                              userDetailsApi.lastName!.isNotEmpty
                                  ? userDetailsApi.lastName.toString()
                                  : "User lastname",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Info",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                ListTile(
                  title: Text(
                    userDetailsApi.phoneNumber!.isNotEmpty
                        ? userDetailsApi.phoneNumber.toString()
                        : "Phone number",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text("phone number"),
                ),
                ListTile(
                  title: Text(
                    userDetailsApi.email!.isNotEmpty
                        ? userDetailsApi.email.toString()
                        : "User email",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text("email"),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BookingScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.square_list),
                        SizedBox(width: 8),
                        Text(
                          "Booking",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                        Expanded(child: Container()),
                        Icon(CupertinoIcons.right_chevron)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.person),
                        SizedBox(width: 8),
                        Text(
                          "My details",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                        Expanded(child: Container()),
                        Icon(CupertinoIcons.right_chevron)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => NotificationSettings()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Icon(IconlyLight.notification),
                        SizedBox(width: 8),
                        Text(
                          "Notification settings",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400),
                        ),
                        Expanded(child: Container()),
                        Icon(CupertinoIcons.right_chevron)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
