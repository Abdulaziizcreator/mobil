import 'package:dio/dio.dart';
import 'package:post_tour/model/tour_get_model.dart';
import '../model/model.dart';

class TourApiService {
  static String BASE = "sobirjonsss.pythonanywhere.com";
  static String API_ADD_TOUR = "/main/create-tour/";
  final Dio dio = Dio();
  final baseGetAllToursUrl =
      "https://sobirjonsss.pythonanywhere.com/main/tours/";
  static String token = "1f257f08c0dba1ad20fb7ca57bdf9d467215b091";

  static Future<String> addTour(TourPostModel tour) async {
    var dio = Dio();

    var formData = FormData();
    formData.fields.add(MapEntry('category', tour.category.toString()));
    formData.fields.add(MapEntry('place_name', tour.placeName));
    formData.fields.add(MapEntry('title', tour.title));
    formData.fields.add(MapEntry('body', tour.body));
    formData.fields.add(MapEntry('cost', tour.cost.toString()));
    formData.fields.add(MapEntry('start_time', tour.startTime));
    formData.fields.add(MapEntry('end_time', tour.endTime));
    formData.fields.add(MapEntry('seats', tour.seats.toString()));
    formData.fields.add(MapEntry('service', tour.service));

    for (var file in tour.image) {
      formData.files.add(MapEntry(
        'image',
        await MultipartFile.fromFile(file.path),
      ));
    }

    for (var file in tour.media) {
      formData.files.add(MapEntry(
        'media',
        await MultipartFile.fromFile(file.path),
      ));
    }

    var response = await dio.post(
      'https://$BASE$API_ADD_TOUR',
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

  Future<List<TourGetModel>> getAllTours() async {
    List<TourGetModel> tours = [];
    try {
      Response allTours = await dio.get(baseGetAllToursUrl);

      if (allTours.statusCode == 200) {
        allTours.data.forEach((tour) {
          tours.add(TourGetModel.fromJson(tour));
        });
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print("Dio error");
        print("STATUS: ${e.response?.statusCode}");
        print("DATA: ${e.response?.data}");
        print("HEADERS: ${e.response?.headers}");
      } else {
        print("Error sending request");
        print(e.message);
      }
    }
    return tours;
  }

  Future<void> deleteTour({required int tourId}) async {
    final String deleteUrl = 'https://$BASE/main/delete-tour/$tourId/';

    try {
      var response = await dio.delete(
        deleteUrl,
        options: Options(
          headers: {
            "Authorization": "token $token",
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Tour deleted successfully');
      } else {
        throw Exception('Failed to delete tour');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print("Dio error");
        print("STATUS: ${e.response?.statusCode}");
        print("DATA: ${e.response?.data}");
        print("HEADERS: ${e.response?.headers}");
      } else {
        print("Error sending request");
        print(e.message);
      }
    }
  }
}
