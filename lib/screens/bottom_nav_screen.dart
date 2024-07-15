import 'package:flutter/material.dart';
import 'package:post_tour/screens/profile_screen.dart';
import 'package:svg_flutter/svg.dart';

import 'home_screen.dart';

class BottomNavPage extends StatefulWidget {
  static const String id = 'BottomNavPage';

  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int selectedPage = 0;

  final List<Widget> _pageOptions = [
    HomeScreen(),
    ProfilePage(),
  ];

  final List<String> _bottomIcons = [
    "assets/svg/55.svg",
    "assets/svg/user.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        body: Stack(fit: StackFit.expand, children: [
          _pageOptions[selectedPage],
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xffBBBDBE),
                      Color(0xffF2F4F5),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    //margin: EdgeInsets.only(bottom: 5),
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xffBBBDBE),
                          Color(0xffF2F4F5),
                        ],
                      ),
                    ),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black38,
                              offset: Offset(0, 10),
                              blurRadius: 10,
                              spreadRadius: 1),
                        ],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _bottomIcons.map((icon) {
                          int index = _bottomIcons.indexOf(icon);
                          bool isSelected = selectedPage == index;
                          return GestureDetector(
                            onTap: () {

                              setState(() {
                                selectedPage = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              margin: EdgeInsets.all(5),
                              height: isSelected ? 33 : 25,
                              width: isSelected ? 33 : 25,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: SvgPicture.asset(
                                icon,
                                color: isSelected
                                    ? Colors.white
                                    : Colors.grey.shade100,
                                height: isSelected ? 18 : 13,
                                width: isSelected ? 18 : 13,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
