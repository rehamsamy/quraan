import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/screens/student/student_homepage.dart';
import 'package:quraan/screens/teacher/teacher_homepage.dart';

class ChooseRole extends StatefulWidget {
  const ChooseRole({Key? key}) : super(key: key);

  @override
  _ChooseRoleState createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Text(
              "من فضلك",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10,),

            const Text(
              "أختر بمن تريد الدخول",
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
                      MaterialPageRoute(builder: (context) => StudentHomepage()));
                },
                child: const Text(
                  "طالب",
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
                      MaterialPageRoute(builder: (context) => TeacherHomepage()));
                },
                child: const Text(
                  "مدرس",
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
