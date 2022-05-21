import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/screens/login_screen.dart';
import 'package:quraan/screens/teacher/degrees/teacher_all_degrees.dart';
import 'package:quraan/screens/teacher/my_students.dart';
import 'package:quraan/screens/teacher/teacher_all_sessions.dart';
import 'package:quraan/screens/teacher/attendance/teacher_attendance.dart';
import 'package:quraan/screens/teacher/teacher_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Text(""),
        title: Text(
          "لوحة تحكم المدرس",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppConstance.mainColor),
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

             const SizedBox(
                height: 40,
              ),


              /// my students
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 10)),
                      elevation: MaterialStateProperty.all<double>(0),
                      fixedSize: MaterialStateProperty.all<Size>(Size(200, 45)),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
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
                      print('ccccccccccc');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyStudentsScreen()));
                    },
                    child: const Text(
                      "طلابي",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),

              const SizedBox(
                height: 30,
              ),

              /// Profile
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 10)),
                      elevation: MaterialStateProperty.all<double>(0),
                      fixedSize: MaterialStateProperty.all<Size>(Size(200, 45)),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TeacherProfile()));
                    },
                    child: const Text(
                      "الملف الشخصي",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),

              const SizedBox(
                height: 30,
              ),

              /// Sessions
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 10)),
                      elevation: MaterialStateProperty.all<double>(0),
                      fixedSize: MaterialStateProperty.all<Size>(Size(200, 45)),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TeacherAllSessions()));
                    },
                    child: const Text(
                      "الجلسات",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),

              const SizedBox(
                height: 30,
              ),
              // /// Student
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
              //             MaterialPageRoute(builder: (context) => StudentInformations()));
              //       },
              //       child: const Text(
              //         "بيانات الطلاب",
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
              // /// Add Session
              // // Container(
              // //   height: 55,
              // //   padding: EdgeInsets.symmetric(horizontal: 20),
              // //   width: MediaQuery.of(context).size.width,
              // //   child: ElevatedButton(
              // //       style: ButtonStyle(
              // //         padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 13, horizontal: 10)),
              // //         elevation: MaterialStateProperty.all<double>(0),
              // //         fixedSize:
              // //         MaterialStateProperty.all<Size>(Size(200, 45)),
              // //         shape: MaterialStateProperty.all(
              // //           RoundedRectangleBorder(
              // //             borderRadius: BorderRadius.circular(50),
              // //           ),
              // //         ),
              // //         backgroundColor:
              // //         MaterialStateProperty.all(AppConstance.mainColor),
              // //       ),
              // //       onPressed: () {
              // //         Navigator.of(context).push(
              // //             MaterialPageRoute(builder: (context) => AddSession()));
              // //       },
              // //       child: const Text(
              // //         "إضافة جلسة",
              // //         style: TextStyle(
              // //             color: Color(0XFFFAFAFA),
              // //             fontSize: 16,
              // //             fontWeight: FontWeight.w600),
              // //       )),
              // // ),
              //
              // //
              // // const SizedBox(
              // //   height: 30,
              // // ),
              //
              // /// Add Absence
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
              //             MaterialPageRoute(builder: (context) => EnterAttendance()));
              //       },
              //       child: const Text(
              //         "إضافة الغياب",
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
              // /// Add Mark
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
              //             MaterialPageRoute(builder: (context) => AddMark()));
              //       },
              //       child: const Text(
              //         "إضافة الدرجة",
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



              /// Grades
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 10)),
                      elevation: MaterialStateProperty.all<double>(0),
                      fixedSize: MaterialStateProperty.all<Size>(const Size(200, 45)),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TeacherGrades()));
                    },
                    child: const Text(
                      "الدرجات",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    )),
              ),


              const SizedBox(
                height: 30,
              ),


              /// Attendance
              Container(
                height: 55,
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 10)),
                      elevation: MaterialStateProperty.all<double>(0),
                      fixedSize: MaterialStateProperty.all<Size>(const Size(200, 45)),
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TeacherAttendance()));
                    },
                    child: const Text(
                      "الحضور والإنصراف",
                      style: TextStyle(
                          color: Colors.black,
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
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 10)),
                      elevation: MaterialStateProperty.all<double>(0),
                      fixedSize: MaterialStateProperty.all<Size>(Size(200, 45)),
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
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.clear();
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
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
