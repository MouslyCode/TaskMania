import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/ui/pages/pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<String> _users = [];

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (username.isNotEmpty && password.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> users = prefs.getStringList('user') ?? [];
      users.add('$username|$password');
      await prefs.setStringList('user', users);

      _usernameController.clear();
      _passwordController.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Login Succes')));

      setState(() {
        _users = users;
      });
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => MainPage()),
          (Route<dynamic> route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please Enter both Username and Password')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 43),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
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
                    hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xFF615BE6),
                    )),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.0))),
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
                    hintStyle: TextStyle(color: Colors.black26, fontSize: 14),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xFF615BE6),
                    )),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(width: 1.0))),
              ),
            ],
          ),
          const SizedBox(
            height: 36,
          ),
          ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF615BE6),
              ),
              child: const Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    ));
  }
}
