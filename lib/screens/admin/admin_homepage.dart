import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/screens/admin/admin_profile.dart';
import 'package:quraan/screens/admin/student_manage_screen.dart';
import 'package:quraan/screens/admin/teacher_manage_screen.dart';
import 'package:quraan/screens/login_screen.dart';
import 'package:quraan/screens/student_register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Text(""),
        title: Text(
          "لوحة تحكم المدير المسئول",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppConstance.mainColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
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
                        builder: (context) => AdminProfile()));
                  },
                  child: const Text(
                    "الملف الشخصي",
                    style: TextStyle(
                        color:  Colors.black,
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
                        builder: (context) => StudentManagement()));
                  },
                  child: const Text(
                    "إدارة الطلاب",
                    style: TextStyle(
                        color:  Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )),
            ),

            const SizedBox(
              height: 30,
            ),

            /// Teachers
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
                        builder: (context) => TeacherManagement()));
                  },
                  child: const Text(
                    "إدارة المدرسين",
                    style: TextStyle(
                        color:  Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )),
            ),

            const SizedBox(
              height: 30,
            ),

            // /// Add Session
            // Container(
            //   height: 55,
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   width: MediaQuery.of(context).size.width,
            //   child: ElevatedButton(
            //       style: ButtonStyle(
            //         padding: MaterialStateProperty.all(
            //             const EdgeInsets.symmetric(
            //                 vertical: 13, horizontal: 10)),
            //         elevation: MaterialStateProperty.all<double>(0),
            //         fixedSize: MaterialStateProperty.all<Size>(Size(200, 45)),
            //         shape: MaterialStateProperty.all(
            //           RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(50),
            //           ),
            //         ),
            //         backgroundColor:
            //             MaterialStateProperty.all(AppConstance.mainColor),
            //       ),
            //       onPressed: () {
            //         Navigator.of(context).push(MaterialPageRoute(
            //             builder: (context) => AdminProfile()));
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
            //
            //
            //
            // /// absence Teachers
            // Container(
            //   height: 55,
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   width: MediaQuery.of(context).size.width,
            //   child: ElevatedButton(
            //       style: ButtonStyle(
            //         padding: MaterialStateProperty.all(
            //             const EdgeInsets.symmetric(
            //                 vertical: 13, horizontal: 10)),
            //         elevation: MaterialStateProperty.all<double>(0),
            //         fixedSize: MaterialStateProperty.all<Size>(Size(200, 45)),
            //         shape: MaterialStateProperty.all(
            //           RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(50),
            //           ),
            //         ),
            //         backgroundColor:
            //             MaterialStateProperty.all(AppConstance.mainColor),
            //       ),
            //       onPressed: () {
            //         Navigator.of(context).push(MaterialPageRoute(
            //             builder: (context) => AdminProfile()));
            //       },
            //       child: const Text(
            //         "إضافة غياب مدرس",
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
            // /// Create a memorization session
            // Container(
            //   height: 55,
            //   padding: EdgeInsets.symmetric(horizontal: 20),
            //   width: MediaQuery.of(context).size.width,
            //   child: ElevatedButton(
            //       style: ButtonStyle(
            //         padding: MaterialStateProperty.all(
            //             const EdgeInsets.symmetric(
            //                 vertical: 13, horizontal: 10)),
            //         elevation: MaterialStateProperty.all<double>(0),
            //         fixedSize: MaterialStateProperty.all<Size>(Size(200, 45)),
            //         shape: MaterialStateProperty.all(
            //           RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(50),
            //           ),
            //         ),
            //         backgroundColor:
            //             MaterialStateProperty.all(AppConstance.mainColor),
            //       ),
            //       onPressed: () {
            //         Navigator.of(context).push(MaterialPageRoute(
            //             builder: (context) => AdminProfile()));
            //       },
            //       child: const Text(
            //         "إنشاء جلسة تحفيظ",
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
    );
  }
}
