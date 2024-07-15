import 'dart:io';

class TourPostModel {
  int category;
  String placeName;
  String title;
  String body;
  List<File> image;
  int cost;
  String startTime;
  String endTime;
  String service;
  int seats;
  List<File> media;

  TourPostModel({
    required this.category,
    required this.placeName,
    required this.title,
    required this.body,
    required this.image,
    required this.cost,
    required this.startTime,
    required this.endTime,
    required this.seats,
    required this.media,
    required this.service,
  });

  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'place_name': placeName,
      'title': title,
      'body': body,
      'cost': cost,
      'start_time': startTime,
      'end_time': endTime,
      'seats': seats,
      'service': service,
      'image': image.map((file) => file.path).toList(),
      'media': media.map((file) => file.path).toList(),
    };
  }
}
