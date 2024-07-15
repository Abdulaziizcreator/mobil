import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_tour/model/model.dart';
import 'package:post_tour/screens/all_tours.dart';
import 'package:post_tour/screens/sign_in_screen.dart';
import 'package:post_tour/service/tour_api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<File> _images = [];
  List<File> _media = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  Future<void> pickMedia() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _media.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  void postTour() async {
    print(_images);
    if (_images.isEmpty || _media.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please pick images and media files")),
      );
      return;
    }

    TourPostModel tourPostModel = TourPostModel(
      category: 6,
      placeName: "Magic City",
      title: "Toshkent",
      body: "Best park  in Uzbekistan",
      image: _images,
      cost: 15,
      startTime: "2024-05-06",
      endTime: "2024-06-01",
      seats: 20,
      media: _media,
      service: "Free lunch",
    );

    try {
      String response = await TourApiService.addTour(tourPostModel);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to post tour: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text("Sign in"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllToursPage()));
                  },
                  child: Text("All tours"),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllToursPage()));
              },
              child: Text("All tours"),
            ),
            TextButton(
              onPressed: pickImages,
              child: Text("Pick Images"),
            ),
            TextButton(
              onPressed: pickMedia,
              child: Text("Pick Media"),
            ),
            SizedBox(height: 30),
            TextButton(
              onPressed: postTour,
              child: Text("Post Tour"),
            ),
            SizedBox(height: 30),
            if (_images != null && _images!.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _images!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(_images[index].path),
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    );
                  },
                ),
              ),
            if (_media != null && _media!.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _media!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        File(_media[index].path),
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
