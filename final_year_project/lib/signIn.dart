import 'dart:convert';

import 'package:final_year_project/models/api.dart';
import 'package:final_year_project/searchScreen.dart';
import 'package:final_year_project/widget/facebookbtn.dart';
import 'package:final_year_project/widget/customTextfield.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final String serverEndPoint = Api.userEndpoint;
  String message = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 30.0, top: 70),
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
                  ),
                ),
                CustomTextField(
                    hintText: 'Email',
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    controller: _emailController,
                    contentPadding: const EdgeInsets.only(top: 5, left: 16.0)),
                CustomTextField(
                    hintText: ' Password',
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    controller: _passwordController,
                    contentPadding: const EdgeInsets.only(top: 5, left: 16.0)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, top: 25.0),
                  child: Container(
                    height: 50, //
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        final String email = _emailController.value.text.trim();
                        final String password =
                            _passwordController.value.text.trim();
                        print("email:$email");
                        try {
                          if (await logIn(email, password)) {
                            debugPrint("success");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchScreen(),
                              ),
                            );
                          }
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: color.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          color: color.onSecondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                const GoogleFacebook_btn(
                    imagePath: 'assets/Google.jpg', text: 'Login with Google'),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: GoogleFacebook_btn(
                      imagePath: 'assets/facebook.jpg',
                      text: 'Login with Facebook'),
                ),
                Row(
                  children: [
                    Text(
                      "Don't have an Account?",
                      style: TextStyle(
                          color: color.secondary,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: color.onSecondary,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // User Login

  Future<bool> logIn(email, password) async {
    try {
      final res = await http.get(
        Uri.parse("$serverEndPoint/login/$email/$password"),
      );
      // print(res.body);
      final resData = jsonDecode(res.body);
      print(res.statusCode);
      if (res.statusCode == 200) {
        // message = "login successful";
        return true;
      }
      // print(resData['message']);
      // message = resData["message"];
    } catch (e) {
      print(e.toString());
      // message = e.toString();
      rethrow;
    }
    return false;
  }
}
