import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:post_tour/controllers/auth_controller.dart';
import 'package:post_tour/controllers/hive_controller.dart';
import 'package:post_tour/controllers/tours_controller.dart';
import 'package:post_tour/screens/bottom_nav_screen.dart';
import 'package:post_tour/screens/introduction_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('userDetails');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StartUpPage(),
    );
  }
}

class StartUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HiveController hiveController = Get.put(HiveController());
    AuthController authController = Get.put(AuthController());
    AllToursController allToursController = Get.put(AllToursController());

    // Check if user details exist in Hive
    if (hiveController.isUserLoggedIn(key: "userEmailPassword")) {
      allToursController.fetchAllTours();
      return BottomNavPage();
    } else {
      return IntroductionScreen();
    }
  }
}
