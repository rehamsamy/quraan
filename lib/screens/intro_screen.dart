import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/models/user_model.dart';
import 'package:quraan/screens/admin/admin_homepage.dart';
import 'package:quraan/screens/admin/admin_profile.dart';
import 'package:quraan/screens/choose_role.dart';
import 'package:quraan/screens/login_screen.dart';
import 'package:quraan/screens/student/student_homepage.dart';
import 'package:quraan/screens/teacher/teacher_homepage.dart';
import 'package:quraan/sharedText.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("userModel") != null) {
      SharedText.userObj = prefs.getString("userModel")!;
      SharedText.userToken = prefs.getString("tokenAccess")!;
      SharedText.password = prefs.getString("password")!;
      print(
          "print user role ${json.decode(prefs.getString("userModel")!)['role']}");
      if (json.decode(prefs.getString("userModel")!)['role'] == "admin") {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AdminHomePage()));
      } else if (json.decode(prefs.getString("userModel")!)['role'] ==
          "student") {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const StudentHomepage()));
      } else if (json.decode(prefs.getString("userModel")!)['role'] ==
          "teacher") {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const TeacherHomepage()));
      }
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
  }

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 5000), () {
      getUserData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            " القرأن الكريم",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: AppConstance.mainColor),
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            height: 50,
            child: SpinKitSquareCircle(
              color: AppConstance.mainColor,
              size: 50.0,
            ),
          )
        ],
      ),
    );
  }
}
