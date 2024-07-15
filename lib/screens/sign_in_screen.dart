import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:post_tour/controllers/auth_controller.dart';
import 'package:post_tour/controllers/hive_controller.dart';
import 'package:post_tour/screens/introduction_screen.dart';
import 'package:post_tour/screens/sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisibility = true;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  HiveController hiveController = Get.put(HiveController());
  AuthController authController = Get.put(AuthController());

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

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    }
    if (password.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  doLogin() {
    authController.doLogin(
        context: context,
        emailController: _emailController,
        passwordController: _passwordController);
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
          return authController.loadingSignIn.value
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            IntroductionScreen()));
                              },
                              child: Card(
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: const Center(
                                      child: Icon(IconlyLight.arrow_left_2)),
                                ),
                              ),
                            ),
                            const SizedBox(height: 40),
                            const Text(
                              "Welcome back! Glad\nto see you, Again!",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 35),
                            ),
                            const SizedBox(height: 30),
                            Center(
                              child: TextFormField(
                                validator: validateEmail,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            const SizedBox(height: 18),
                            Center(
                              child: TextFormField(
                                validator: validatePassword,
                                controller: _passwordController,
                                obscureText: passwordVisibility,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        passwordVisibility =
                                            !passwordVisibility;
                                      });
                                    },
                                    icon: passwordVisibility
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off),
                                  ),
                                  hintText: "Enter your password",
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState?.validate() == true) {
                                  setState(() {
                                    doLogin();
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
                                    const BoxShadow(
                                      color: Colors.black38,
                                      offset: Offset(0, 10),
                                      blurRadius: 20,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Text(
                                        "LOGIN",
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
                            const SizedBox(
                              height: 180,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Create a new account?"),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SignUpScreen()));
                                    },
                                    child: const Text("Sign up"))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
        }),
      ),
    ));
  }
}
