// ignore_for_file: valid_regexps

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/ui/pages/pages.dart';
import 'package:todo_app/ui/pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

extension extString on String {
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-ZO-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this);
  }

  bool get isValidUsername {
    final usernameRegExp = RegExp(r"^(a-zA-Z0-16)");
    return usernameRegExp.hasMatch(this);
  }

  bool get isValidPassword {
    final passwordRegExp = RegExp(
        r"^(?=.*[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>");
    return passwordRegExp.hasMatch(this);
  }

  bool get isNotNull {
    return this != null;
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> _users = [];

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> users = prefs.getStringList('user') ?? [];
      users.add('$username|$password');
      await prefs.setStringList('user', users);

      _usernameController.clear();
      _passwordController.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Login Succes')));

      setState(() {
        _users = users;
      });
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => MainPage()),
          (Route<dynamic> route) => false);
    }
    // else {

    //   // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //   //     content: Text('Please Enter both Username and Password')));
    // }
  }

  void _signUp() {
    Navigator.push(
        context, CupertinoPageRoute(builder: (context) => const SignupPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 43),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: const TextSpan(
                text: 'Log',
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                      text: 'in',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Color(0xFF615BE6)))
                ]),
          ),
          const SizedBox(
            height: 36,
          ),
          //Form
          Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Username',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                          hintText: 'Username',
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF615BE6),
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0))),
                      validator: (value) {
                        if (value!.isValidUsername && value!.isNotNull)
                          return 'Username must be between 0-16 character';
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                //Password TextForm
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Password',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          hintText: 'Password',
                          hintStyle:
                              TextStyle(color: Colors.black26, fontSize: 14),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF615BE6),
                          )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.0))),
                      validator: (value) {
                        if (value!.isValidPassword && value!.isNotNull) {
                          return 'Password must contain 0-9 characters, \n an uppercase letter, a lowercase letter, a digit, and special character';
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 36,
          ),
          ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF615BE6),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  minimumSize: const Size(double.infinity, 45)),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              )),
          const SizedBox(
            height: 13,
          ),
          RichText(
              text: TextSpan(
                  text: "Didn't have Account? ",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black54),
                  children: [
                TextSpan(
                    text: 'Sign up',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Color(
                          0xFF615BE6,
                        )),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _signUp();
                      })
              ]))
          // ElevatedButton(
          //     onPressed: _signUp,
          //     style: ElevatedButton.styleFrom(
          //         backgroundColor: Colors.white38,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(4)),
          //         minimumSize: Size(double.infinity, 45)),
          //     child: const Text(
          //       'Sign Up',
          //       style: TextStyle(color: Color(0xFF615BE6)),
          //     )),
        ],
      ),
    ));
  }
}
