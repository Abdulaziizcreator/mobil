import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:post_tour/model/get_user_data_model.dart';

import '../model/sign_in_model.dart';

class HiveController extends GetxController {
  static var myBox = Hive.box('userDetails');

  storeUserEmailObject({required var obj, required String objKey}) {
    String objString = jsonEncode(obj);
    myBox.put(objKey, objString);
    print("Foydalanuvchi email password saqlandi");
  }

  SignInModel getUserEmailObject({required String objKey}) {
    String objString = myBox.get(objKey);
    Map<String, dynamic> objMap = jsonDecode(objString);
    SignInModel userDetails = SignInModel.fromJson(objMap);

    return userDetails;
  }

  storeDetails({required var obj, required String objKey}) {
    String objString = jsonEncode(obj);
    myBox.put(objKey, objString);
    print("Foydalanuvchi details saqlandi");
  }

  GetDataUserModel getDetails({required String objKey}) {
    String objString = myBox.get(objKey);
    Map<String, dynamic> objMap = jsonDecode(objString);
    GetDataUserModel userDetails = GetDataUserModel.fromJson(objMap);

    return userDetails;
  }

  bool isUserLoggedIn({required String key}) {
    return myBox.containsKey(key);
  }


  Future<File?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      File imageFile = File(image.path);
      // Save the image to Hive
      saveImage(imageFile);
      return imageFile;
    }
    return null;
  }

  void saveImage(File imageFile) {
    final bytes = imageFile.readAsBytesSync();
    myBox.put('profile_image', bytes);
  }

  Future<File?> getImage() async {
    final bytes = myBox.get('profile_image');
    if (bytes != null) {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = '${tempDir.path}/temp_image.jpg';
      File tempFile = File(tempPath);
      tempFile.writeAsBytesSync(bytes);
      return tempFile;
    }
    return null;
  }
}
