import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/screens/login_screen.dart';
import 'package:quraan/screens/register_screen.dart';

class ChooseScreen extends StatefulWidget {
  const ChooseScreen({Key? key}) : super(key: key);

  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Text(
              "منصة تحفيظ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10,),

            const Text(
              " القرأن الكريم",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),


            const SizedBox(height: 60,),

            /// Login
            ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 10)),
                  elevation: MaterialStateProperty.all<double>(0),
                  fixedSize:
                  MaterialStateProperty.all<Size>(Size(200, 45)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  backgroundColor:
                  MaterialStateProperty.all(AppConstance.mainColor),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: const Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                      color: Color(0XFFFAFAFA),
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                )),

            const SizedBox(
              height: 30,
            ),

            /// Register
            ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 10)),
                  elevation: MaterialStateProperty.all<double>(0),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  fixedSize:
                  MaterialStateProperty.all<Size>(Size(200, 45)),
                  backgroundColor:
                  MaterialStateProperty.all(AppConstance.mainColor),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => RegisterScreen()));
                },
                child: const Text(
                  "إنشاء حساب جديد",
                  style: TextStyle(
                      color: Color(0XFFFAFAFA),
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                )),
          ],
        ),
      ),
    );
  }
}
