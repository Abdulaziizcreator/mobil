import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:post_tour/model/tour_get_model.dart';
import 'package:post_tour/service/raiting_api_service.dart';
import 'package:svg_flutter/svg_flutter.dart';

class DetailPlaceCard extends StatefulWidget {
  final TourGetModel tours;
  final int index;

  DetailPlaceCard({
    required this.tours,
    required this.index,
    super.key,
  });

  @override
  State<DetailPlaceCard> createState() => _DetailPlaceCardState();
}

class _DetailPlaceCardState extends State<DetailPlaceCard> {
  PageController _pageController = PageController();
  int currentPage = 0;
  List<String> imageUrl = [];
  int _currentRating = 0;

  void _rate(int rating) async {
    setState(() {
      _currentRating = rating;
    });
    String reponse = await RaitingApiService.ratingTour(
        id: widget.tours.id!, raiting: rating);
    print('Selected rating: $rating');
    print(reponse);
  }

  @override
  void initState() {
    super.initState();
    imageUrl = widget.tours.images!.map((image) => image.image!).toList();
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(),
    );
  }

  List<Widget> _buildPageContent() {
    return imageUrl.map((image) {
      return _buildPage(
        image: image,
        title: widget.tours.placeName.toString(),
        description: widget.tours.title.toString(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xffB6B8B8),
              Color(0xffF2F4F5),
              Color(0xffF0F2F3),
            ],
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset("assets/svg/left.svg")),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: InkWell(
                            onTap: () {
                              // tourController.toggleLiked(widget.index);
                            },
                            child: Card(
                              child: Container(
                                height: 38,
                                width: 38,
                                child: Center(
                                  child: Icon(
                                    IconlyBold.heart,
                                    color: Colors.red,
                                  ),
                                  // Add heart icon here if needed
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 480,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 10),
                          blurRadius: 15,
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    alignment: Alignment.bottomLeft,
                    child: Stack(
                      children: [
                        PageView(
                          controller: _pageController,
                          onPageChanged: (int page) {
                            setState(() {
                              currentPage = page;
                            });
                          },
                          children: _buildPageContent(),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    imageUrl.length,
                                    (index) => Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 3),
                                      width: 35,
                                      height: 5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        shape: BoxShape.rectangle,
                                        color: currentPage == index
                                            ? Colors.white
                                            : Colors.white30,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                ),
                                child: GridTileBar(
                                  title: Text(
                                    widget.tours.placeName.toString(),
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: EdgeInsets.only(top: 5),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 2),
                                          child: Icon(
                                            IconlyBold.location,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          widget.tours.title.toString(),
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/svg/star2.svg",
                                              color: Color(0xffFF9505),
                                              height: 20,
                                              width: 20,
                                            ),
                                            SizedBox(width: 5),
                                            Text(
                                              "5",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () => _rate(index + 1),
                  icon: Icon(
                    size: 30,
                    index < _currentRating ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                  ),
                );
              }),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.only(left: 5, top: 5),
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xffC4C4C4),
              Color(0xffF5F5F5),
              Color(0xffFFFFFF),
            ],
          ),
        ),
        child: ListTile(
          title: Text(
            "Price",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.start,
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "\$${widget.tours.cost.toString()}",
                style: TextStyle(
                  color: Color(0xff024D8D),
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                " /Person",
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              )
            ],
          ),
          trailing: InkWell(
            child: Container(
              alignment: Alignment.topRight,
              height: 80,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: Offset(0, 10),
                    blurRadius: 20,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      "assets/svg/ticket.svg",
                      height: 24,
                      width: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 7),
                  Center(
                    child: Text(
                      "Book Ticket",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
