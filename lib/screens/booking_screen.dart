import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class BookingScreen extends StatelessWidget {
  const BookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        padding: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xffB6B8B8),
              // Color(0xffF2F4F5),
              Color(0xffF0F2F3),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Card(
                      child: Container(
                        height: 40,
                        width: 40,
                        child: Center(child: Icon(IconlyLight.arrow_left_2)),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "All booking",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(height: 100),
              Center(
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/image/nothing.jpeg'),
                          fit: BoxFit.cover)),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
