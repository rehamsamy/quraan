import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/models/MyTeachersModel.dart';
import 'package:quraan/models/my_students_model.dart';
import 'package:quraan/models/session_model.dart';
import 'package:quraan/models/user_model.dart';
import 'package:quraan/screens/admin/sessions/add_session.dart';
import 'package:quraan/screens/admin/sessions/session_details.dart';
import 'package:quraan/screens/admin/sessions/update_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class MyTeachersScreen extends StatefulWidget {
  const MyTeachersScreen({Key? key}) : super(key: key);

  @override
  _MyTeachersState createState() => _MyTeachersState();
}

class _MyTeachersState extends State<MyTeachersScreen> {
   MyTeachersModel myStudentsModel = MyTeachersModel();
  List<MyTeachersModel> myTeachersList = [];
  bool isLoading = false;



  getMyTeachers(id) async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await Dio().get("${AppConstance.api_url}/student/${id}/teachers",
          options: Options(headers: {
            'Authorization':
            'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));

      if (response.statusCode == 200) {
        setState(() {
          myTeachersList = (response.data['data'] as List)
              .map((e) => MyTeachersModel.fromJson(e))
              .toList();
          isLoading = false;
        });
      }
    } on DioError catch (exception) {
      /// Get custom massage for the exception
      setState(() {
        isLoading = false;
      });
    }
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      UserModel   userModel =
      UserModel.fromJson(json.decode(prefs.getString("userModel")!));
      getMyTeachers(userModel.userData!.id);
    });
  }


  @override
  void initState() {
    getUserData();
    // getMyStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "المعلمين المسند لهم",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppConstance.mainColor),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
        child: Container(
          height: 50,
          child: SpinKitSquareCircle(
            color: AppConstance.mainColor,
            size: 50.0,
          ),
        ),
      )
          : myTeachersList.length == 0
          ? Center(
        child: Text("لا يوجد بيانات"),
      )
          : SingleChildScrollView(
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     TextButton(
            //         onPressed: () {
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder: (context) => AddSessionScreen(),
            //               ));
            //         },
            //         child: Text(
            //           "إضافة جلسة جديدة",
            //           style: TextStyle(color: Colors.white),
            //         )),
            //   ],
            // ),
            Container(
              padding:
              EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: myTeachersList.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: AppConstance.mainColor
                                .withOpacity(.4),
                            width: 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// /session Number
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "الاسم : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppConstance.mainColor),
                            ),
                            Expanded(
                                child: Text(
                                  myTeachersList[index].name.toString(),
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ))
                          ],
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        /// Start
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              " العمر : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppConstance.mainColor),
                            ),
                            Expanded(
                                child: Text(
                                  myTeachersList[index].age.toString(),
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ))
                          ],
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       "المرتب : ",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 16,
                        //           color: AppConstance.mainColor),
                        //     ),
                        //     Expanded(
                        //         child: Text(
                        //           myTeachersList[index]
                        //               .salary??0
                        //               .toString(),
                        //           softWrap: true,
                        //           maxLines: 1,
                        //           overflow: TextOverflow.ellipsis,
                        //         ))
                        //   ],
                        // ),

                        /// End
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              " البريد الالكتروني : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppConstance.mainColor),
                            ),
                            Expanded(
                                child: Text(
                                  myTeachersList[index].email.toString(),
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ))
                          ],
                        ),

                        SizedBox(
                          height: 5,
                        ),

                        /// Number Of Student

                        // SizedBox(
                        //   height: 5,
                        // ),


                        // /// Teacher name
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       "رقم الهاتف : ",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 16,
                        //           color: AppConstance.mainColor),
                        //     ),
                        //     Expanded(
                        //         child: Text(
                        //           myTeachersList[index]
                        //               .phone!
                        //               .toString(),
                        //           softWrap: true,
                        //           maxLines: 1,
                        //           overflow: TextOverflow.ellipsis,
                        //         ))
                        //   ],
                        // ),

                        SizedBox(
                          height: 5,
                        ),


                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.start,
                        //   children: [
                        //     Text(
                        //       "العنوان : ",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.w500,
                        //           fontSize: 16,
                        //           color: AppConstance.mainColor),
                        //     ),
                        //     Expanded(
                        //         child: Text(
                        //           myTeachersList[index]
                        //               .address??''
                        //               .toString(),
                        //           softWrap: true,
                        //           maxLines: 1,
                        //           overflow: TextOverflow.ellipsis,
                        //         ))
                        //   ],
                        // ),
                        //
                        // SizedBox(
                        //   height: 5,
                        // ),





                        SizedBox(
                          height: 5,
                        ),

                        /// Status


                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
