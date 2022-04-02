import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/screens/login_screen.dart';
import 'package:quraan/screens/student/session_list.dart';
import 'package:quraan/screens/student/student_attendance.dart';
import 'package:quraan/screens/student/student_marks.dart';
import 'package:quraan/screens/student/student_profile.dart';
import 'package:quraan/screens/teacher/add_mark.dart';
import 'package:quraan/screens/teacher/enter_attendance.dart';
import 'package:quraan/screens/teacher/student_info.dart';
import 'package:quraan/screens/teacher/teacher_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentHomepage extends StatefulWidget {
  const StudentHomepage({Key? key}) : super(key: key);

  @override
  _StudentHomepageState createState() => _StudentHomepageState();
}

class _StudentHomepageState extends State<StudentHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Text(""),
        title: Text(
          "لوحة تحكم الطالب",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: AppConstance.mainColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// Profile
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 13, horizontal: 10)),
                      elevation: MaterialStateProperty.all<double>(0),
                      fixedSize:
                      MaterialStateProperty.all<Size>(Size(200, 45)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      ),
                      backgroundColor:
                      MaterialStateProperty.all(AppConstance.mainColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => StudentProfile()));
                    },
                    child: const Text(
                      "الملف الشخصي",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),
              //
              // const SizedBox(
              //   height: 30,
              // ),
              //
              // /// Session List
              // Container(
              //   height: 55,
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   width: MediaQuery.of(context).size.width,
              //   child: ElevatedButton(
              //       style: ButtonStyle(
              //         padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 13, horizontal: 10)),
              //         elevation: MaterialStateProperty.all<double>(0),
              //         fixedSize:
              //         MaterialStateProperty.all<Size>(Size(200, 45)),
              //         shape: MaterialStateProperty.all(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(50),
              //           ),
              //         ),
              //         backgroundColor:
              //         MaterialStateProperty.all(AppConstance.mainColor),
              //       ),
              //       onPressed: () {
              //         Navigator.of(context).push(
              //             MaterialPageRoute(builder: (context) => SessionList()));
              //       },
              //       child: const Text(
              //         "جدول الجلسات",
              //         style: TextStyle(
              //             color: Color(0XFFFAFAFA),
              //             fontSize: 16,
              //             fontWeight: FontWeight.w600),
              //       )),
              // ),
              //
              // const SizedBox(
              //   height: 30,
              // ),
              //
              // /// Attendance
              // Container(
              //   height: 55,
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   width: MediaQuery.of(context).size.width,
              //   child: ElevatedButton(
              //       style: ButtonStyle(
              //         padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 13, horizontal: 10)),
              //         elevation: MaterialStateProperty.all<double>(0),
              //         fixedSize:
              //         MaterialStateProperty.all<Size>(Size(200, 45)),
              //         shape: MaterialStateProperty.all(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(50),
              //           ),
              //         ),
              //         backgroundColor:
              //         MaterialStateProperty.all(AppConstance.mainColor),
              //       ),
              //       onPressed: () {
              //         Navigator.of(context).push(
              //             MaterialPageRoute(builder: (context) => Attendance()));
              //       },
              //       child: const Text(
              //         "الغياب",
              //         style: TextStyle(
              //             color: Color(0XFFFAFAFA),
              //             fontSize: 16,
              //             fontWeight: FontWeight.w600),
              //       )),
              // ),
              //
              // const SizedBox(
              //   height: 30,
              // ),
              //
              //
              // /// Marks
              // Container(
              //   height: 55,
              //   padding: EdgeInsets.symmetric(horizontal: 20),
              //   width: MediaQuery.of(context).size.width,
              //   child: ElevatedButton(
              //       style: ButtonStyle(
              //         padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 13, horizontal: 10)),
              //         elevation: MaterialStateProperty.all<double>(0),
              //         fixedSize:
              //         MaterialStateProperty.all<Size>(Size(200, 45)),
              //         shape: MaterialStateProperty.all(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(50),
              //           ),
              //         ),
              //         backgroundColor:
              //         MaterialStateProperty.all(AppConstance.mainColor),
              //       ),
              //       onPressed: () {
              //         Navigator.of(context).push(
              //             MaterialPageRoute(builder: (context) => StudentMarks()));
              //       },
              //       child: const Text(
              //         "الدرجات",
              //         style: TextStyle(
              //             color: Color(0XFFFAFAFA),
              //             fontSize: 16,
              //             fontWeight: FontWeight.w600),
              //       )),
              // ),

              const SizedBox(
                height: 30,
              ),


              /// Logout
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 13, horizontal: 10)),
                      elevation: MaterialStateProperty.all<double>(0),
                      fixedSize:
                      MaterialStateProperty.all<Size>(Size(200, 45)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                      ),
                      backgroundColor:
                      MaterialStateProperty.all(AppConstance.mainColor),
                    ),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.clear();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                    child: const Text(
                      " تسجيل الخروج",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
