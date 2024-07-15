import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post_tour/controllers/hive_controller.dart';
import 'package:post_tour/controllers/tours_controller.dart';
import 'package:post_tour/model/get_user_data_model.dart';
import 'package:post_tour/screens/sign_in_screen.dart';
import 'package:post_tour/screens/sign_up.dart';

import 'bottom_nav_screen.dart';

class IntroductionScreen extends StatefulWidget {
  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  HiveController hiveController = Get.put(HiveController());

  _doSignInWithHive() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/image/splash1.jpg"),
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              AllToursController allToursController =
                                  Get.put(AllToursController());
                              HiveController hiveController =
                                  Get.put(HiveController());
                              GetDataUserModel userDetails = GetDataUserModel(
                                firstName: "User firstname",
                                lastName: "User lastname",
                                email: "User email",
                                phoneNumber: "User phoneNumber",
                              );
                              hiveController.storeDetails(
                                  obj: userDetails, objKey: "userDetailsKey");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BottomNavPage()));
                              allToursController.fetchAllTours();
                            },
                            child: Container(
                                margin: EdgeInsets.only(right: 20),
                                height: 50,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.transparent,
                                    border: Border.all(color: Colors.white30)),
                                child: Center(
                                    child: Text(
                                  "View as Guest",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ))),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          'Explore \nIndonesia \nwith us.',
                          style: TextStyle(
                              wordSpacing: 0,
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text(
                          'We Traveling are ready to help you on \nvacation around Indonesia',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Container(
                              //margin: const EdgeInsets.symmetric(horizontal: 30),
                              height: 80,

                              width: MediaQuery.of(context).size.width * 0.75,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black38,
                                      offset: Offset(0, 10),
                                      blurRadius: 20,
                                      spreadRadius: 1),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Center(
                                    child: const Text(
                                      "Let's Get Started",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(CupertinoIcons.arrow_right,
                                        size: 22, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: const Text(
                                "already have account?",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 3),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: Color(0xff016FB9),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
