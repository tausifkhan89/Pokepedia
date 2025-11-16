import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pokepedia/screens/home_screen.dart';
import 'package:pokepedia/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  late var obscureText = true;
  bool _isLoading = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1a1a1a),
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
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
                // Heading
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Center(
                    child: Text(
                      'Create an Account',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                      ),
                    ),
                  ),
                ),

                // Name
                Text(
                  'Name',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(color: Color(0xff5E6674)),
                    prefixIcon: Icon(Icons.person_2_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fillColor: Color(0xff1f2937),
                    filled: true,
                    prefixIconColor: Color(0xff9ca3af),
                  ),
                  cursorColor: Colors.red,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                // Confirm Password
                Text(
                  'Confirm Password',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: confirmPasswordController,
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                    hintText: 'Confirm your password',
                    hintStyle: TextStyle(color: Color(0xff5E6674)),
                    prefixIcon: Icon(Icons.lock_reset),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    fillColor: Color(0xff1f2937),
                    filled: true,
                    prefixIconColor: Color(0xff9ca3af),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 20),

                // Register Button
                Center(
                  child: InkWell(
                    onTap: () {
                      if (_isLoading) return;
                      if (formKey.currentState!.validate()) {
                        registerUser();
                      }
                    },
                    child: Container(
                      height: 56,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Color(0xff2a75bb),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              )
                            : const Text(
                                'Register',
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

                SizedBox(height: 20),

                // Already have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        if (_isLoading) return;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      },
                      child: Text(
                        'Log In',
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
    );
  }

  void registerUser() {
    setState(() {
      _isLoading = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
          var user = value.user;
          if (user != null) {
            var uid = value.user!.uid;
            addUserData(uid);
          }
          setState(() {
            _isLoading = false;
          });
        })
        .catchError((error) {
          setState(() {
            _isLoading = false;
          });
          Fluttertoast.showToast(
            msg: 'Error $error',
            backgroundColor: Colors.red,
          );
        });
  }

  void addUserData(String uid) {
    Map<String, dynamic> userData = {
      'name': nameController.text,
      'password': passwordController.text,
      'email': emailController.text,
      'uid': uid,
    };
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userData)
        .then((value) {
          Fluttertoast.showToast(
            msg: 'Registration Successful',
            backgroundColor: Colors.green,
          );
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        })
        .catchError((e) {
          setState(() {
            _isLoading = false;
          });
          Fluttertoast.showToast(msg: 'Error $e', backgroundColor: Colors.red);
        });
  }
}
