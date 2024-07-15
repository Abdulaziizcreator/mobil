import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:post_tour/controllers/hive_controller.dart';
import 'package:post_tour/controllers/tours_controller.dart';
import 'package:post_tour/model/get_user_data_model.dart';
import 'package:post_tour/model/sign_up_model.dart';
import 'package:post_tour/screens/bottom_nav_screen.dart';

import '../model/sign_in_model.dart';
import '../service/auth_api_service.dart';

class AuthController extends GetxController {
  HiveController hiveController = Get.put(HiveController());
  AllToursController allToursController = Get.put(AllToursController());
  var token = ''.obs;
  var loadingSignIn = false.obs;
  var loadingSignUp = false.obs;

  void doLogin({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  }) async {
    loadingSignIn.value = true;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        SignInModel signInModel = SignInModel(
          email: email,
          password: password,
        );
        hiveController.storeUserEmailObject(
            obj: signInModel, objKey: "userEmailPassword");

        String response = await AuthApiService.signIn(signInModel: signInModel);

        String? responseUserDetails =
            await AuthApiService.getUserDetail(token: response);

        GetDataUserModel getDataUserModel =
            GetDataUserModel.fromJson(jsonDecode(responseUserDetails!));
        Logger().e(getDataUserModel.firstName);
        hiveController.storeDetails(
            obj: getDataUserModel, objKey: "userDetailsKey");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNavPage()));

        await allToursController.fetchAllTours();
        loadingSignIn.value = false;
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              duration: Duration(milliseconds: 600),
              content: Text("Invalid password")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields correctly")),
      );
    }
  }

  void doSingUp({
    required BuildContext context,
    required TextEditingController emailController,
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController passwordConfirmController,
    required TextEditingController phoneNumberController,
    required TextEditingController passwordController,
  }) async {
    loadingSignUp.value = true;
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String fistName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String phoneNumber = phoneNumberController.text.trim();
    String passwordConfirm = passwordConfirmController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        SignUpModel signUpModel = SignUpModel(
            first_name: fistName,
            last_name: lastName,
            email: email,
            phone_number: phoneNumber,
            password: password,
            password_confirm: passwordConfirm);

        String response = await AuthApiService.signUp(signUpModel: signUpModel);
        if (response != null) {
          SignInModel signInModel =
              SignInModel(email: email, password: password);
          hiveController.storeUserEmailObject(
              obj: signInModel, objKey: "userEmailPassword");
        }
        String? responseUserDetails =
            await AuthApiService.getUserDetail(token: response);

        GetDataUserModel getDataUserModel =
            GetDataUserModel.fromJson(jsonDecode(responseUserDetails!));

        hiveController.storeDetails(
            obj: getDataUserModel, objKey: "userDetailsKey");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => BottomNavPage()));

        await allToursController.fetchAllTours();
        loadingSignUp.value = false;
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              duration: Duration(milliseconds: 600),
              content: Text("Invalid password")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields correctly")),
      );
    }
  }
}
