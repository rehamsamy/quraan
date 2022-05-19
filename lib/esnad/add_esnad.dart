import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quraan/models/student_model.dart';
import 'package:quraan/models/teacher_model.dart';
import 'package:quraan/screens/student/student_homepage.dart';
import 'package:quraan/sharedText.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:quraan/models/user_model.dart';
import 'package:quraan/screens/admin/admin_homepage.dart';
import 'package:quraan/screens/choose_role.dart';
import 'package:quraan/screens/teacher/teacher_homepage.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddEsnadScreen extends StatefulWidget {
  const AddEsnadScreen({Key? key}) : super(key: key);

  @override
  _AddEsnadScreenState createState() => _AddEsnadScreenState();
}

class _AddEsnadScreenState extends State<AddEsnadScreen> {
  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now();
  TextEditingController start = TextEditingController();
  TextEditingController end = TextEditingController();
  TextEditingController numberOfStudent = TextEditingController();
  TextEditingController zoomLink = TextEditingController();
  TextEditingController preSessionId = TextEditingController();
  int? teacherID;
  bool active = false;
  bool notActive = false;
   TeacherModel? teacherModel;
  StudentModel? studentModel;
  var dio = Dio();
  List<TeacherModel> teacherList = [];
  List<StudentModel> studentList = [];
  bool isLoading = false;

  getAllTeachers() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await Dio().get("${AppConstance.api_url}/teacher/all",
          options: Options(headers: {
            'Authorization':
            'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));

      if (response.statusCode == 200) {
        setState(() {
          teacherList = (response.data['data'] as List)
              .map((e) => TeacherModel.fromJson(e))
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


  getAllStudents() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await Dio().get("${AppConstance.api_url}/student/all",
          options: Options(headers: {
            'Authorization':
            'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));

      if (response.statusCode == 200) {
        setState(() {
          studentList = (response.data['data'] as List)
              .map((e) => StudentModel.fromJson(e))
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


  addSession() async {
    if (start.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل بداية الجلسة",
        ),
      );
      return;
    }




    if (teacherModel == null) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أختر المعلم",
        ),
      );
      return;
    }


    if (studentModel == null) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أختر الطالب",
        ),
      );
      return;
    }


    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var formData = FormData.fromMap({
        "teacher_id": teacherModel!.id,
        "student_id": studentModel!.id,
      });

      var response = await Dio().post("${AppConstance.api_url}/teacher_students",
          data: formData,
          options: Options(headers: {
            'Authorization':
            'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));

      print(response.data.toString() + "text");

      if (response.statusCode == 200) {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: "تم التسجيل بنجاح",
          ),
        );

        Navigator.pop(context);
        Navigator.pop(context);
      }

      setState(() {
        start.clear();
        end.clear();
        numberOfStudent.clear();
        zoomLink.clear();
        active = false;
        notActive = false;
      });
    } on DioError catch (exception) {
      /// Get custom massage for the exception
      showTopSnackBar(
        context,
        CustomSnackBar.error(
            message: exception.response!.data['errors']['end']),
      );
    }
  }

  @override
  void initState() {
    getAllTeachers();
    getAllStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "إضافة إسناد جديدة",
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
          : Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Center(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),

              /// Select Teacher
              Row(
                children: [
                  Text(
                    "أختر المعلم",
                    style: TextStyle(
                        color: AppConstance.mainColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.grey,
                    )),
                child: DropdownButton<TeacherModel>(
                  // value: "",
                  icon: Text(""),
                  isExpanded: true,
                  underline: const Text(""),
                  hint: Center(
                    child: Text(
                      teacherModel == null
                          ? "أختر المعلم"
                          : teacherModel!.name!.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: teacherModel == null
                              ? Colors.grey
                              : Colors.white,
                          fontSize: 16),
                    ),
                  ),
                  items: teacherList.map((TeacherModel teacherModel) {
                    return DropdownMenuItem<TeacherModel>(
                      value: teacherModel,
                      child: Center(
                        child: Text(
                          teacherModel.name!,
                          style: const TextStyle(
                              fontFamily: "Almarai",
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      teacherModel = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 40,),
              Row(
                children: [
                  Text(
                    "أختر الطالب",
                    style: TextStyle(
                        color: AppConstance.mainColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.grey,
                    )),
                child: DropdownButton<StudentModel>(
                  // value: "",
                  icon: Text(""),
                  isExpanded: true,
                  underline: const Text(""),
                  hint: Center(
                    child: Text(
                      studentModel == null
                          ? "أختر الطالب"
                          : studentModel!.name!.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: studentModel == null
                              ? Colors.grey
                              : Colors.white,
                          fontSize: 16),
                    ),
                  ),
                  items: studentList.map((StudentModel studentModel) {
                    return DropdownMenuItem<StudentModel>(
                      value: studentModel,
                      child: Center(
                        child: Text(
                          studentModel.name!,
                          style: const TextStyle(
                              fontFamily: "Almarai",
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      studentModel = value;
                    });
                  },
                ),
              ),


              /// Active Or Not Active
              // Row(
              //   children: [
              //     Expanded(
              //       child: Row(
              //         children: [
              //           Text(
              //             "مفعل",
              //             style: TextStyle(
              //                 color: Colors.grey,
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 14),
              //           ),
              //           Checkbox(
              //             activeColor: AppConstance.mainColor,
              //             value: active,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 notActive = false;
              //                 active = true;
              //               });
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //     Expanded(
              //       child: Row(
              //         children: [
              //           Text(
              //             "غير مفعل",
              //             style: TextStyle(
              //                 color: Colors.grey,
              //                 fontWeight: FontWeight.w600,
              //                 fontSize: 14),
              //           ),
              //           Checkbox(
              //             activeColor: AppConstance.mainColor,
              //             value: notActive,
              //             onChanged: (bool? value) {
              //               setState(() {
              //                 notActive = true;
              //                 active = false;
              //               });
              //             },
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              //
              const SizedBox(
                height: 50,
              ),

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
                    addSession();
                  },
                  child: const Text(
                    "إضافة الجلسة",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
