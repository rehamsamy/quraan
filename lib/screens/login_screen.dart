import 'dart:convert';
import 'package:quraan/screens/student/student_homepage.dart';
import 'package:quraan/sharedText.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:quraan/models/user_model.dart';
import 'package:quraan/screens/admin/admin_homepage.dart';
import 'package:quraan/screens/choose_role.dart';
import 'package:quraan/screens/teacher/teacher_homepage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  var dio = Dio();
  UserModel userModel = UserModel();

  _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (emailController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل البريد الألكتروني",
        ),
      );
      return;
    }
    if (passwordController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل كلمة المرور",
        ),
      );
      return;
    }
    if (passwordController.text.length < 6) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "كلمة المرور يجب أن تكون أكبر من 6 حروف أو أرقام",
        ),
      );
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      var formData = FormData.fromMap({
        "email": emailController.text,
        "password": passwordController.text,
      });

      var response =
          await Dio().post("${AppConstance.api_url}/login", data: formData);

      if (response.statusCode == 200) {
        userModel = UserModel.fromJson(response.data);

        String userMod = json.encode(userModel);
        String userToken = json.encode(userModel.accessToken);

        prefs.setString("userModel", userMod);
        prefs.setString("tokenAccess", userToken);
        print("fmkfmkm ${userToken}");
        prefs.setString("password", passwordController.text);
        SharedText.password = prefs.getString("password")!;
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: "تم تسجيل الدخول بنجاح",
          ),
        );

        if (userModel.role == "admin") {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AdminHomePage()));
        } else if (userModel.role == "student") {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => StudentHomepage()));
        } else if (userModel.role == "teacher") {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const TeacherHomepage()));
        }
      }

      setState(() {
        emailController.clear();
        passwordController.clear();
        isLoading = false;
      });
    } on DioError catch (exception) {
      /// Get custom massage for the exception
      showTopSnackBar(
        context,
        CustomSnackBar.error(message: exception.response!.data['error']),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppConstance.mainColor,
      //   elevation: 0,
      //   title: Text(
      //     "تسجيل الدخول",
      //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      //   ),
      //   centerTitle: true,
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),

              Text(
                "تسجيل الدخول",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppConstance.mainColor),
              ),

              const SizedBox(
                height: 50,
              ),

              /// Email
              Row(
                children: [
                  Text(
                    "البريد الألكتروني",
                    style: TextStyle(
                        color: AppConstance.mainColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: AppConstance.mainColor,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  hintText: "البريد الألكتروني",
                  hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.34),
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onFieldSubmitted: (value) {
                  //Validator
                },
                // validator: widget.validationFunction,
              ),

              const SizedBox(
                height: 30,
              ),

              /// Password
              Row(
                children: [
                  Text(
                    "كلمة المرور",
                    style: TextStyle(
                        color: AppConstance.mainColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                controller: passwordController,
                keyboardType: TextInputType.text,
                cursorColor: AppConstance.mainColor,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  hintText: "كلمة المرور",
                  hintStyle: TextStyle(
                      color: Colors.grey.withOpacity(0.34),
                      fontWeight: FontWeight.w600,
                      fontSize: 12),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onFieldSubmitted: (value) {
                  //Validator
                },
                // validator: widget.validationFunction,
              ),

              const SizedBox(
                height: 50,
              ),

              ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 13, horizontal: 10)),
                    elevation: MaterialStateProperty.all<double>(0),
                    fixedSize: MaterialStateProperty.all<Size>(Size(200, 45)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    backgroundColor:
                        MaterialStateProperty.all(AppConstance.mainColor),
                  ),
                  onPressed: () {
                    _login();
                  },
                  child: const Text(
                    "تسجيل الدخول",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  )),

              const SizedBox(
                height: 10,
              ),

              TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChooseRole()));
                  },
                  child: Text(
                    "تسجيل حساب جديد",
                    style: TextStyle(color: AppConstance.mainColor),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
