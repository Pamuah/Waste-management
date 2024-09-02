import 'dart:convert';

import 'package:final_year_project/signIn.dart';
import 'package:final_year_project/widget/customTextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'models/api.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/sign-up';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  final String serverEndPoint = Api.userEndpoint;

  Future signUp() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passwordController.text.trim());
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailcontroller.dispose();
    _nameController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 30.0, top: 70),
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                ),
              ),
              CustomTextField(
                  hintText: 'Name',
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  controller: _nameController,
                  contentPadding: const EdgeInsets.only(top: 5, left: 16.0)),
              CustomTextField(
                  hintText: 'Email',
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  controller: _emailcontroller,
                  contentPadding: const EdgeInsets.only(top: 5, left: 16.0)),
              CustomTextField(
                  hintText: ' Password',
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  controller: _passwordController,
                  contentPadding: const EdgeInsets.only(top: 5, left: 16.0)),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'The password should be at least 6 characters long',
                  style: TextStyle(
                      color: color.tertiary,
                      fontWeight: FontWeight.w400,
                      fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Container(
                  height: 50, //
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        if (await addUser()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        }
                      } catch (e) {
                        debugPrint(e.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: color.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Row(
                  children: [
                    Container(
                      height: 1.0,
                      width: MediaQuery.of(context).size.width * 0.4,
                      color: Colors.grey,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Text(
                        'Or',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: color.tertiary,
                        ),
                      ),
                    ),
                    Container(
                      height: 1.0,
                      width: MediaQuery.of(context).size.width * 0.4,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: color.onBackground, width: 1.0),
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/Google.jpg',
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              'Continue with Google',
                              style: TextStyle(
                                  color: color.secondary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: color.onBackground, width: 1.0),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/facebook.jpg',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            'Continue with Facebook',
                            style: TextStyle(
                                color: color.secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> addUser() async {
    final name = _nameController.value.text.trim();
    final email = _emailcontroller.value.text.trim();
    final password = _passwordController.value.text.trim();
    Map<String, String> user = {
      'name': name,
      'email': email,
      'password': password,
    };

    final res = await http.post(
      Uri.parse("$serverEndPoint/register"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user),
    );
    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }
}
