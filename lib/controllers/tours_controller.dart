import 'package:get/get.dart';
import 'package:post_tour/model/tour_get_model.dart';
import 'package:post_tour/service/tour_api_service.dart';

class AllToursController extends GetxController {
  var tours = <TourGetModel>[].obs;

  Future<void> fetchAllTours() async {
    TourApiService apiService = TourApiService();
    try {
      List<TourGetModel> fetchedTours = await apiService.getAllTours();
      tours.assignAll(fetchedTours);
    } catch (e) {
      // Handle error
      print("Failed to fetch tours: $e");
    }
  }

  void deleteTour(int tourId) async {
    try {
      await TourApiService().deleteTour(tourId: tourId);
      tours.removeWhere((tour) => tour.id == tourId);
    } catch (e) {
      // Handle error
      print("Failed to delete tour: $e");
    }
  }
}
