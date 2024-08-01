import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/pages/login_page.dart';
import 'package:todo_app/ui/pages/pages.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3), () => 100).then((value) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => LoginPage()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF615BE6),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'TaskMania',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          )
        ],
      ),
    );
  }
}
