import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/ui/pages/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<String> _users = [];

  Future<void> _signup() async {
    final String username = _usernameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;

    if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> users = prefs.getStringList('user') ?? [];
      users.add('$username|$email|$password');
      await prefs.setStringList('user', users);

      _usernameController.clear();
      _emailController.clear();
      _passwordController.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign up Success')));

      setState(() {
        _users = users;
      });

      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false);
    } else {
      // if (email.isEmpty) {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text('Please Enter the email')));
      // } else if (username.isEmpty) {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text('Please Enter the username')));
      // } else if (password.isEmpty) {
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(SnackBar(content: Text('Please Enter the password')));
      // } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please enter the form')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 43),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                text: const TextSpan(
                    text: 'Sign',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Color(0xFF615BE6)))
                    ]),
              ),
              const SizedBox(
                height: 36,
              ),
              //Username TextForm
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Username',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
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
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              //Email TextForm
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'Email',
                        hintStyle:
                            TextStyle(color: Colors.black26, fontSize: 14),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFF615BE6),
                        )),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 1.0))),
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
                  Text(
                    'Password',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
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
                  ),
                ],
              ),
              const SizedBox(
                height: 36,
              ),
              ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF615BE6),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      minimumSize: Size(double.infinity, 45)),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          )),
    );
  }
}
