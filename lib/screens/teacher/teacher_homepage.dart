import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/screens/admin/admin_profile.dart';
import 'package:quraan/screens/login_screen.dart';
import 'package:quraan/screens/teacher/add_mark.dart';
import 'package:quraan/screens/teacher/add_session.dart';
import 'package:quraan/screens/teacher/enter_attendance.dart';
import 'package:quraan/screens/teacher/student_info.dart';
import 'package:quraan/screens/teacher/teacher_profile.dart';

class TeacherHomepage extends StatefulWidget {
  const TeacherHomepage({Key? key}) : super(key: key);

  @override
  _TeacherHomepageState createState() => _TeacherHomepageState();
}

class _TeacherHomepageState extends State<TeacherHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstance.mainColor,
        elevation: 0,
        leading: Text(""),
        title: Text(
          "لوحة تحكم المدرس",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(height: 40,),

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
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      backgroundColor:
                      MaterialStateProperty.all(AppConstance.mainColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => TeacherProfile()));
                    },
                    child: const Text(
                      "الملف الشخصي",
                      style: TextStyle(
                          color: Color(0XFFFAFAFA),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),

              const SizedBox(
                height: 30,
              ),


              /// Student
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
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      backgroundColor:
                      MaterialStateProperty.all(AppConstance.mainColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => StudentInformations()));
                    },
                    child: const Text(
                      "بيانات الطلاب",
                      style: TextStyle(
                          color: Color(0XFFFAFAFA),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),

              const SizedBox(
                height: 30,
              ),

              /// Add Session
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
              //             MaterialPageRoute(builder: (context) => AddSession()));
              //       },
              //       child: const Text(
              //         "إضافة جلسة",
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

              /// Add Absence
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
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      backgroundColor:
                      MaterialStateProperty.all(AppConstance.mainColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => EnterAttendance()));
                    },
                    child: const Text(
                      "إضافة الغياب",
                      style: TextStyle(
                          color: Color(0XFFFAFAFA),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),

              const SizedBox(
                height: 30,
              ),

              /// Add Mark
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
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      backgroundColor:
                      MaterialStateProperty.all(AppConstance.mainColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AddMark()));
                    },
                    child: const Text(
                      "إضافة الدرجة",
                      style: TextStyle(
                          color: Color(0XFFFAFAFA),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),

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
                      " تسجيل الخروج",
                      style: TextStyle(
                          color: Color(0XFFFAFAFA),
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
