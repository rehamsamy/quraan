import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/screens/admin/admin_profile.dart';
import 'package:quraan/screens/login_screen.dart';
import 'package:quraan/screens/register_screen.dart';

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
        backgroundColor: AppConstance.mainColor,
        elevation: 0,
        leading: Text(""),
        title: Text(
          "لوحة تحكم المدير المسؤل",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Center(
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
                        MaterialPageRoute(builder: (context) => AdminProfile()));
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
                        MaterialPageRoute(builder: (context) => AdminProfile()));
                  },
                  child: const Text(
                    "إدارة الطلاب",
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
                        MaterialPageRoute(builder: (context) => AdminProfile()));
                  },
                  child: const Text(
                    "إضافة جلسة",
                    style: TextStyle(
                        color: Color(0XFFFAFAFA),
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
                        MaterialPageRoute(builder: (context) => AdminProfile()));
                  },
                  child: const Text(
                    "إدارة المدرسين",
                    style: TextStyle(
                        color: Color(0XFFFAFAFA),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )),
            ),

            const SizedBox(
              height: 30,
            ),

            /// absence Teachers
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
                        MaterialPageRoute(builder: (context) => AdminProfile()));
                  },
                  child: const Text(
                    "إضافة غياب مدرس",
                    style: TextStyle(
                        color: Color(0XFFFAFAFA),
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )),
            ),

            const SizedBox(
              height: 30,
            ),

            /// Create a memorization session
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
                        MaterialPageRoute(builder: (context) => AdminProfile()));
                  },
                  child: const Text(
                    "إنشاء جلسة تحفيظ",
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
    );
  }
}
