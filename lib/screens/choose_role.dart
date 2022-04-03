import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/screens/student/student_homepage.dart';
import 'package:quraan/screens/student_register_screen.dart';
import 'package:quraan/screens/teacher/teacher_homepage.dart';
import 'package:quraan/screens/teacher_register_screen.dart';

class ChooseRole extends StatefulWidget {
  const ChooseRole({Key? key}) : super(key: key);

  @override
  _ChooseRoleState createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "من فضلك",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppConstance.mainColor),
            ),

            const SizedBox(
              height: 10,
            ),

            Text(
              "أختر بمن تريد التسجيل",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: AppConstance.mainColor),
            ),

            const SizedBox(
              height: 60,
            ),

            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => StudentRegisterScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: AppConstance.mainColor.withOpacity(.4),
                                width: 1)),
                        child: Column(
                          children: [
                            Icon(
                              Icons.person_add,
                              size: 40,
                              color: AppConstance.mainColor,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "طالب",
                              style: TextStyle(
                                  color: AppConstance.mainColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TeacherRegisterScreen()));
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: AppConstance.mainColor.withOpacity(.4),
                                width: 1)),
                        child: Column(
                          children: [
                            Icon(
                              Icons.person_add,
                              size: 40,
                              color: AppConstance.mainColor,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "مدرس",
                              style: TextStyle(
                                  color: AppConstance.mainColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // /// Student
            // ElevatedButton(
            //     style: ButtonStyle(
            //       padding: MaterialStateProperty.all(
            //           const EdgeInsets.symmetric(
            //               vertical: 13, horizontal: 10)),
            //       elevation: MaterialStateProperty.all<double>(0),
            //       fixedSize:
            //       MaterialStateProperty.all<Size>(Size(200, 45)),
            //       shape: MaterialStateProperty.all(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(50),
            //         ),
            //       ),
            //       backgroundColor:
            //       MaterialStateProperty.all(AppConstance.mainColor),
            //     ),
            //     onPressed: () {
            //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => StudentRegisterScreen()));
            //     },
            //     child: const Text(
            //       "طالب",
            //       style: TextStyle(
            //           color: Color(0XFFFAFAFA),
            //           fontSize: 15,
            //           fontWeight: FontWeight.w600),
            //     )),
            //
            // const SizedBox(
            //   height: 30,
            // ),

            // /// Teacher
            // ElevatedButton(
            //     style: ButtonStyle(
            //       padding: MaterialStateProperty.all(
            //           const EdgeInsets.symmetric(
            //               vertical: 13, horizontal: 10)),
            //       elevation: MaterialStateProperty.all<double>(0),
            //       shape: MaterialStateProperty.all(
            //         RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(50),
            //         ),
            //       ),
            //       fixedSize:
            //       MaterialStateProperty.all<Size>(Size(200, 45)),
            //       backgroundColor:
            //       MaterialStateProperty.all(AppConstance.mainColor),
            //     ),
            //     onPressed: () {
            //       Navigator.of(context).push(MaterialPageRoute(builder: (context) => TeacherRegisterScreen()));
            //
            //     },
            //     child: const Text(
            //       "مدرس",
            //       style: TextStyle(
            //           color: Color(0XFFFAFAFA),
            //           fontSize: 15,
            //           fontWeight: FontWeight.w600),
            //     )),
          ],
        ),
      ),
    );
  }
}
