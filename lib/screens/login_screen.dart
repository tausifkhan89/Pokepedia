import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokepedia/screens/registration_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  late var obscureText = true;
  final Color baseColor = Color(0xff1a1a1a);
  late bool _isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    emailController.addListener(() {
      listener:
      (context);
    });
    passwordController.addListener(() {
      listener:
      (context);
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.removeListener(() {
      listener:
      (context);
    });
    passwordController.removeListener(() {
      listener:
      (context);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poke ball
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 20,
                    ),
                    child: Center(
                      child: Lottie.asset(
                        'assets/animations/Pokeball loading animation.json',
                        height: 150,
                      ),
                    ),
                  ),

                  // Welcome Back
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        'Welcome Back!',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 38,
                        ),
                      ),
                    ),
                  ),

                  // Email Filed
                  Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),

                  TextFormField(
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Color(0xff5E6674)),
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      fillColor: Color(0xff1f2937),
                      filled: true,
                      prefixIconColor: Color(0xff9ca3af),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.email],
                    cursorColor: Colors.red,
                  ),
                  SizedBox(height: 20),

                  // Password Field
                  Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.white),
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.redAccent),
                      ),
                      hintText: 'Enter your password',
                      hintStyle: TextStyle(color: Color(0xff5E6674)),
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                        icon: Icon(
                          obscureText
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                        ),
                        color: Color(0xff9ca3af),
                        iconSize: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      fillColor: Color(0xff1f2937),
                      filled: true,
                      prefixIconColor: Color(0xff9ca3af),
                    ),
                  ),

                  // Forgot password
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.yellow,
                            color: Colors.yellow[600],
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Login Button
                  Center(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      splashColor: Colors.green,
                      onTap: () {
                        loginUser();
                        final form = formKey.currentState;
                        String email = emailController.text;
                        String password = passwordController.text;
                        if (form!.validate()) {
                          final email = emailController.text;
                          String password = passwordController.text;
                        }
                      },
                      child: Container(
                        height: 56,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color:
                              emailController.text.isEmpty ||
                                  passwordController.text.isEmpty
                              ? Color(0xff3a3a3a)
                              : Color(0xff2a75bb),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                )
                              : const Text(
                                  'Log In',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),

                  // Divider
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Divider(
                            thickness: 1,
                            color: Color(0xff9ca3af),
                          ),
                        ),
                      ),
                      Text('OR', style: TextStyle(color: Color(0xff9ca3af))),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Divider(
                            thickness: 1,
                            color: Color(0xff9ca3af),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // continue with Google and FaceBook
                  Row(
                    children: [
                      // Google
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 56,
                          decoration: BoxDecoration(
                            color: Color(0xff1f2937),
                            borderRadius: BorderRadius.circular(30),
                            border: BoxBorder.all(color: Color(0xff4b5563)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                              ),
                              Text(
                                'Google',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // FaceBook
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 56,
                          decoration: BoxDecoration(
                            color: Color(0xff1f2937),
                            borderRadius: BorderRadius.circular(30),
                            border: BoxBorder.all(color: Color(0xff4b5563)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesomeIcons.facebookF,
                                color: Colors.white,
                              ),
                              Text(
                                'Facebook',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Don't have an Account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have and account? ',
                        style: TextStyle(color: Colors.white),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RegistrationScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.yellow,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.yellow,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void loginUser() {
    setState(() {
      _isLoading = true;
    });
    if (passwordController.text == "") {
      Fluttertoast.showToast(
        msg: 'Password cannot be empty',
        backgroundColor: Colors.red,
      );
    } else {
      String email = emailController.text;
      String password = passwordController.text;
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
            setState(() {
              _isLoading = false;
            });
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
            );
          })
          .catchError((e) {
            setState(() {
              _isLoading = false;
            });
            Fluttertoast.showToast(
              msg: 'Error: $e',
              backgroundColor: Colors.red,
            );
          });
    }
  }
}
