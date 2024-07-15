import 'package:dio/dio.dart';

class RaitingApiService {
  static String BASE = "sobirjonsss.pythonanywhere.com";
  static String postRaitingUrl = "sobirjonsss.pythonanywhere.com";
  static Dio dio = Dio();
  static String token = "1f257f08c0dba1ad20fb7ca57bdf9d467215b091";

  static Future<String> ratingTour({required int id,required int raiting}) async {
    var formData = FormData();
    formData.fields.add(MapEntry("grade", raiting.toString()));

    var response = await dio.post(
      "https://$BASE/main/create-or-update-raiting/$id/",
      data: formData,
      options: Options(headers: {
        "Authorization": "token $token",
        "Content-Type": "multipart/form-data",
      }),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.data.toString();
    } else {
      throw Exception('Failed to post tour');
    }
  }
}
