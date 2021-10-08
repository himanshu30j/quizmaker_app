import 'package:flutter/material.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/views/home.dart';
import 'package:quizmaker/views/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  checkLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInDetails().then((value) {
      setState(() {
        isLoggedIn = value;
      });
    });
  }

  @override
  void initState() {
    checkLoggedInStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "quiz maker",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (isLoggedIn ?? false) ? Home() : SignIn(),
    );
  }
}
