import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
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

  _login() async {
    if (emailController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message:
          "أدخل البريد الألكتروني",
        ),
      );
      return;
    }
    if (passwordController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message:
          "أدخل كلمة المرور",
        ),
      );
      return;
    }
    if (passwordController.text.length < 6) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message:
          "كلمة المرور يجب أن تكون أكبر من 6 حروف أو أرقام",
        ),
      );
      return;
    }

    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ChooseRole()));

    try {
      setState(() {
        isLoading = true;
      });
      var url = Uri.parse("${AppConstance.api_url}login");
      var response = await http.post(url, body: {
              "email" : emailController.text,
              "password": passwordController.text,
      });

    } on DioError catch (exception) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstance.mainColor,
        elevation: 0,
        title: Text(
          "تسجيل الدخول",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Center(
          child: ListView(
            children: [
              const SizedBox(
                height: 20,
              ),

              /// Email
              Row(
                children: [
                  Text(
                    "البريد الألكتروني",
                    style: TextStyle(
                        color: Colors.grey,
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
                        color: Colors.grey,
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
                        color: Color(0XFFFAFAFA),
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
