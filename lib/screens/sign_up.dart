import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:logger/logger.dart';
import 'package:post_tour/controllers/auth_controller.dart';
import 'package:post_tour/screens/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passwordVisibility = true;
  bool accept = false;
  bool loading = false;
  final log = Logger();
  final _formKey = GlobalKey<FormState>();
  AuthController authController = Get.put(AuthController());
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Name is required';
    }
    if (!RegExp(r'^[a-zA-Z0-9]{4,}$').hasMatch(name)) {
      return 'Must start with an uppercase letter and be at least 5 characters long';
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }
    String pattern = r'^(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}@gmail\.com$';
    if (!RegExp(pattern).hasMatch(email)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePhoneNumber(String? phoneNumber) {
    if (phoneNumber == null ||
        phoneNumber.isEmpty ||
        phoneNumber.length == 14) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\+[0-9]+$').hasMatch(phoneNumber)) {
      return 'Phone number must start with "+" and contain only digits';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  String? validateConfirmPassword(String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Confirm password is required';
    }
    if (confirmPassword != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  doSignUp() async {
    setState(() {
      authController.doSingUp(
          context: context,
          emailController: _emailController,
          firstNameController: _firstNameController,
          lastNameController: _lastNameController,
          passwordConfirmController: _confirmPasswordController,
          phoneNumberController: _phoneNumberController,
          passwordController: _passwordController);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, '/introduce', (route) => false);
        return false; // This prevents the default back button action
      },
      child: Scaffold(
        body: Obx(() {
          return authController.loadingSignUp.value
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xffB6B8B8),
                          Color(0xffF0F2F3),
                        ],
                      ),
                    ),
                    child: SingleChildScrollView(
                        child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/introduce', (route) => false);
                            },
                            child: Card(
                              child: Container(
                                height: 40,
                                width: 40,
                                child: Center(
                                    child: Icon(IconlyLight.arrow_left_2)),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Create Your Account!",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 35),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            validator: validateName,
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Firstname",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: 18),
                          TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: validateName,
                            enableSuggestions: false,
                            controller: _lastNameController,
                            decoration: InputDecoration(

                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Lastname",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: 18),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            validator: validatePhoneNumber,
                            controller: _phoneNumberController,
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Phone number",
                              hintStyle:
                                  TextStyle(color: Colors.grey, fontSize: 17),
                              border: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: 18),
                          TextFormField(
                            validator: validateEmail,
                            controller: _emailController,
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Email",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: 18),
                          TextFormField(
                            validator: validatePassword,
                            controller: _passwordController,
                            obscureText: passwordVisibility,
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              fillColor: Colors.white,
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordVisibility = !passwordVisibility;
                                  });
                                },
                                icon: passwordVisibility
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off),
                              ),
                              hintText: "Enter your password",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: 18),
                          TextFormField(
                            validator: validateConfirmPassword,
                            obscureText: true,
                            controller: _confirmPasswordController,
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide:
                                      BorderSide(color: Colors.grey.shade400)),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: "Confirm password",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                          SizedBox(height: 5),
                          Container(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        accept = !accept;
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: accept
                                          ? Icon(CupertinoIcons.checkmark_alt)
                                          : SizedBox(),
                                    ),
                                  ),
                                  Text(
                                    "I accept Terms of Use and Privacy Policy",
                                    style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )),
                          SizedBox(height: 0),
                          InkWell(
                            onTap: () {
                              if (_formKey.currentState?.validate() == true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Sign up successful')),
                                );
                                setState(() {
                                  doSignUp();
                                });
                              }
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              height: 80,
                              width: MediaQuery.of(context).size.width,
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
                                    child: const Text(
                                      "SIGN UP",
                                      style: TextStyle(
                                        fontSize: 18,
                                        wordSpacing: 1,
                                        letterSpacing: 1.5,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?"),
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  child: Text("Login"))
                            ],
                          )
                        ],
                      ),
                    )),
                  ),
                );
        }),
      ),
    ));
  }
}
