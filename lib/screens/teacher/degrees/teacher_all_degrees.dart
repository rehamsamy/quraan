import 'dart:convert';
import 'package:quraan/models/attendance_model.dart';
import 'package:quraan/models/grade_model.dart';
import 'package:quraan/screens/teacher/attendance/teacher_add_new_attendance.dart';
import 'package:quraan/screens/teacher/degrees/add_degree.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/models/session_model.dart';
import 'package:quraan/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherGrades extends StatefulWidget {
  const TeacherGrades({Key? key}) : super(key: key);

  @override
  _TeacherGradesState createState() => _TeacherGradesState();
}

class _TeacherGradesState extends State<TeacherGrades> {
  UserModel userModel = UserModel();
  List<GradeListModel> graderList = [];
  bool isLoading = false;

  getAllDegree() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      userModel =
          UserModel.fromJson(json.decode(prefs.getString("userModel")!));
      var response = await Dio().get(
          "${AppConstance.api_url}/grades",
          options: Options(headers: {
            'Authorization':
            'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));

      if (response.statusCode == 200) {
        setState(() {
          graderList = (response.data['data'] as List)
              .map((e) => GradeListModel.fromJson(e))
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


  removeDegree(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response =
      await Dio().delete("${AppConstance.api_url}/grades/${id}",
          options: Options(headers: {
            'Authorization':
            'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));
      if (response.statusCode == 200) {
        showTopSnackBar(
          context,
          const CustomSnackBar.success(
            message: "تم الحذف بنجاح",
          ),
        );
        getAllDegree();
      }
    } on DioError catch (exception) {
      /// Get custom massage for the exception
    }
  }

  @override
  void initState() {
    getAllDegree();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "الدرجات",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppConstance.mainColor),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const TeacherAddDegree(),));
                      },
                      child: const Text(
                        "إضافة الدرجات",
                        style: TextStyle(color: Colors.white),
                      )),
                ],
              ),
              isLoading
                  ? Center(
                child: Container(
                  height: 50,
                  child: SpinKitSquareCircle(
                    color: AppConstance.mainColor,
                    size: 50.0,
                  ),
                ),
              )
                  : graderList.length == 0
                  ? Center(
                child: Text("لا يوجد بيانات"),
              )
                  : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: graderList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 15),
                            margin: EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius:
                                BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: AppConstance.mainColor
                                        .withOpacity(.4),
                                    width: 1)),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [


                                /// Session Number
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "رقم الجلسة : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color:
                                          AppConstance.mainColor),
                                    ),
                                    Expanded(
                                        child: Text(
                                          graderList[index].sessionId.toString(),
                                          softWrap: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ))
                                  ],
                                ),


                                SizedBox(
                                  height: 5,
                                ),


                                /// Degree
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "الدرجة : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color:
                                          AppConstance.mainColor),
                                    ),
                                    Expanded(
                                        child: Text(
                                          graderList[index].grade.toString(),
                                          softWrap: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ))
                                  ],
                                ),


                                SizedBox(
                                  height: 5,
                                ),


                                /// Teacher Name
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "أسم المعلم : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color:
                                          AppConstance.mainColor),
                                    ),
                                    Expanded(
                                        child: Text(
                                          graderList[index].teacher!.name.toString(),
                                          softWrap: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ))
                                  ],
                                ),

                                SizedBox(
                                  height: 5,
                                ),

                                /// Student Name
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "أسم الطالب : ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color:
                                          AppConstance.mainColor),
                                    ),
                                    Expanded(
                                        child: Text(
                                          graderList[index].student!.name.toString(),
                                          softWrap: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ))
                                  ],
                                ),



                                const SizedBox(
                                  height: 10,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          setState(() {
                                            removeDegree(graderList[index].id);
                                          });
                                        },
                                        child: const Text(
                                          "حذف",
                                          style: TextStyle(color: Colors.red),
                                        )),
                                  ],
                                )

                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
