
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class EditProfileInfoScreen extends StatelessWidget {
  String firstName;
  String lastName;
  String phoneNumber;
  String email;

  bool isEdit = false;

  EditProfileInfoScreen(
      {required this.firstName,
        required this.lastName,
        required this.phoneNumber,
        required this.email,
        super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xffBBBDBE),
                    Color(0xffF2F4F5),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "Profile Info",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 23,
                        ),
                      ),
                      Expanded(child: Container()),
                      Icon(
                        Icons.check,
                        color: isEdit ? Colors.black : Colors.grey,
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Your name",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 10, bottom: 5),
                    child: Text(
                      firstName,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 5, bottom: 10),
                    child: Text(
                      lastName,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Phone number",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 5, bottom: 10),
                    child: Text(
                      phoneNumber,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Email",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 5, bottom: 10),
                    child: Text(
                      email,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                  ),
                ],
              )),
        ));
  }
}
