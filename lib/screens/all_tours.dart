import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:post_tour/screens/details_screen.dart';
import 'package:post_tour/model/tour_get_model.dart';
import 'package:svg_flutter/svg.dart';

import '../controllers/tours_controller.dart';

class AllToursPage extends StatelessWidget {
  final AllToursController allToursController = Get.put(AllToursController());

  Widget returnData({required String data}) {
    DateTime dateTime = DateTime.parse(data);
    String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
    return Text(
      formattedDate,
      style: TextStyle(color: Colors.blueAccent, fontSize: 17),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All tours"),
      ),
      body: Center(
        child: Obx(() {
          if (allToursController.tours.isEmpty) {
            return CircularProgressIndicator();
          } else {
            return ListView.builder(
              itemCount: allToursController.tours.length,
              itemBuilder: (context, index) {
                TourGetModel tour = allToursController.tours[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailPlaceCard(tours: tour, index: index),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            image: tour.images != null &&
                                    tour.images!.isNotEmpty
                                ? DecorationImage(
                                    image:
                                        NetworkImage(tour.images!.first.image!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          alignment: Alignment.bottomLeft,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            textAlign: TextAlign.start,
                            tour.placeName ?? "",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.grey,
                              ),
                              Icon(
                                Icons.star,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Location: ${tour.title}",
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: 15,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              returnData(data: tour.startTime.toString()),
                              Text(
                                "${double.parse(tour.cost.toString())}\$",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
