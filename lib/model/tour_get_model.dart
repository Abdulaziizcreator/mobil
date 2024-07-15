class TourGetModel {
  int? id;
  int? category;
  String? placeName;
  String? title;
  String? body;
  String? startTime;
  String? endTime;
  int? discount;
  int? cost;
  int? seats;
  bool? booking;
  List<Services>? services;
  List<Images>? images;
  List<Media>? media;

  TourGetModel(
      {required this.id,
      required this.category,
      required this.placeName,
      required this.title,
      required this.body,
      required this.startTime,
      required this.endTime,
      required this.discount,
      required this.cost,
      required this.seats,
      required this.services,
      required this.images,
      required this.booking,
      required this.media});

  TourGetModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    placeName = json['place_name'];
    title = json['title'];
    body = json['body'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    discount = json['discount'];
    cost = json['cost'];
    seats = json['seats'];
    booking = json['booking'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['place_name'] = this.placeName;
    data['title'] = this.title;
    data['body'] = this.body;
    data['booking'] = this.booking;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['discount'] = this.discount;
    data['cost'] = this.cost;
    data['seats'] = this.seats;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
    }
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  String? service;

  Services({this.service});

  Services.fromJson(Map<String, dynamic> json) {
    service = json['service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service'] = this.service;
    return data;
  }
}

class Images {
  String? image;

  Images({this.image});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class Media {
  String? media;

  Media({this.media});

  Media.fromJson(Map<String, dynamic> json) {
    media = json['media'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['media'] = this.media;
    return data;
  }
}
