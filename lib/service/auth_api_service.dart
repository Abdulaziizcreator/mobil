import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:post_tour/model/get_user_data_model.dart';

import '../controllers/hive_controller.dart';
import '../model/sign_up_model.dart';
import '../model/sign_in_model.dart';

class AuthApiService {
  static String BASE = "sobirjonsss.pythonanywhere.com";
  static String signInUrl = "/auth/sign-in/";
  static String signUpUrl = "/auth/sign-up/";
  static String signOutUrl = "/auth/sign-out/";
  static String getDataUser =
      "https://sobirjonsss.pythonanywhere.com/auth/get-user-data/";
  static Dio dio = Dio();

  static Future<String> signIn({required SignInModel signInModel}) async {
    try {
      FormData formData = FormData.fromMap({
        "email": signInModel.email,
        "password": signInModel.password,
      });

      var response = await dio.post(
        "https://$BASE$signInUrl",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Extract token from response
        String token = response.data['token'];

        // Save email and password to Hive
        HiveController().storeUserEmailObject(
          objKey: 'userEmailPassword',
          obj: {
            'email': signInModel.email,
            'password': signInModel.password,
          },
        );

        return token;
      } else {
        throw Exception('Failed to sign in');
      }
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  static Future<String> signUp({required SignUpModel signUpModel}) async {
    var formData = FormData();
    formData.fields.add(MapEntry("first_name", signUpModel.first_name));
    formData.fields.add(MapEntry("last_name", signUpModel.last_name));
    formData.fields.add(MapEntry("email", signUpModel.email));
    formData.fields.add(MapEntry("phone_number", signUpModel.phone_number));
    formData.fields.add(MapEntry("password", signUpModel.password));
    formData.fields
        .add(MapEntry("password_confirm", signUpModel.password_confirm));

    var response = await dio.post(
      "https://$BASE$signUpUrl",
      data: formData,
      options: Options(headers: {
        "Content-Type": "application/x-www-form-urlencoded",
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      String token = response.data['token'];
      // Save email and password to Hive
      HiveController().storeUserEmailObject(
        objKey: 'userCredentials',
        obj: {
          'email': signUpModel.email,
          'password': signUpModel.password,
        },
      );
      print(token);
      return token;
    } else {
      throw Exception('Failed to sign up');
    }
  }

  static Future<void> deleteForm({required String token}) async {
    try {
      Response response = await dio.delete(
        'https://$BASE$signOutUrl',
        options: Options(headers: {
          "Authorization": "token $token",
          "Content-Type": "multipart/form-data",
        }),
      );

      if (response.statusCode == 200) {
        // Successful deletion
        print('Form deleted successfully');
      } else {
        // Handle other status codes if needed
        print('Failed to delete form: ${response.statusCode}');
      }
    } catch (e) {
      // Handle DioError exceptions, if any
      print('Failed to delete form: $e');
    }
  }

  static Future<String?> getUserDetail({required String token}) async {
    try {
      var userDetail = await dio.get(
        getDataUser,
        options: Options(
          headers: {
            "Authorization": "token $token",
          },
        ),
      );

      if (userDetail.statusCode == 200) {
        // This will be a Map<String, dynamic>
        return userDetail.toString();
      } else {
        throw Exception('F35133515353ailed to get user details');
      }
    } catch (e) {
      throw Exception('Failed to get user detailsdfdfkmk: $e');
    }
  }
}
