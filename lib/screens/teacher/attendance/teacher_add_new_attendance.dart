import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/models/session_model.dart';
import 'package:quraan/models/student_model.dart';
import 'package:quraan/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddNewAttendance extends StatefulWidget {
  const AddNewAttendance({Key? key}) : super(key: key);

  @override
  State<AddNewAttendance> createState() => _AddNewAttendanceState();
}

class _AddNewAttendanceState extends State<AddNewAttendance> {
  var dio = Dio();
  List<StudentModel> studentsList = [];
  List<SessionModel> sessionsList = [];
  StudentModel? studentModel;
  SessionModel? sessionModel;
  bool isLoading = false;
  UserModel userModel = UserModel();
  bool absence = false;
  bool presence = false;
  int? teacherID;

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
          studentsList = (response.data['data'] as List)
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

  getAllSessions() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      userModel =
          UserModel.fromJson(json.decode(prefs.getString("userModel")!));
      setState(() {
        teacherID = userModel.userData!.id;
      });
      var response = await Dio().get(
          "${AppConstance.api_url}/teacher/${userModel.userData!.id}/sessions",
          options: Options(headers: {
            'Authorization':
                'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));
      if (response.statusCode == 200) {
        setState(() {
          sessionsList = (response.data['data'] as List)
              .map((e) => SessionModel.fromJson(e))
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

  addAttendance() async {
    if (studentModel == null) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "???????? ????????????",
        ),
      );
      return;
    }

    if (sessionModel == null) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "???????? ?????? ????????????",
        ),
      );
      return;
    }

    if (absence == false && presence == false) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "???????? ???????????? ?????????????? ???????? ",
        ),
      );
      return;
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var formData = FormData.fromMap({
        "session_id": sessionModel!.id,
        "teacher_id": teacherID,
        "student_id": studentModel!.id,
        "status": presence ? 1 : 0,
      });

      var response = await Dio().post("${AppConstance.api_url}/attendances",
          data: formData,
          options: Options(headers: {
            'Authorization':
                'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));

      if (response.statusCode == 200) {
        showTopSnackBar(
          context,
          const CustomSnackBar.success(
            message: "???? ?????????????? ??????????",
          ),
        );

        Navigator.pop(context);
        Navigator.pop(context);
      }
    } on DioError catch (exception) {
      /// Get custom massage for the exception
      showTopSnackBar(
        context,
        CustomSnackBar.error(
            message: exception.response!.data['errors'][0]),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getAllStudents();
    getAllSessions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "?????????? ???????? ??????????????",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppConstance.mainColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: ListView(
          shrinkWrap: true,
          children: [


            /// Choose Student
            Row(
              children: [
                Text(
                  "???????? ????????????",
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
                        ? "???????? ????????????"
                        : studentModel!.name!.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: studentModel == null ? Colors.grey : Colors.white,
                        fontSize: 16),
                  ),
                ),
                items: studentsList.map((StudentModel studentModel) {
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

            const SizedBox(
              height: 30,
            ),

            /// Choose Session
            Row(
              children: [
                Text(
                  "???????? ?????? ????????????",
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
              child: DropdownButton<SessionModel>(
                // value: "",
                icon: Text(""),
                isExpanded: true,
                underline: const Text(""),
                hint: Center(
                  child: Text(
                    sessionModel == null
                        ? "???????? ?????? ????????????"
                        : sessionModel!.id!.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: sessionModel == null ? Colors.grey : Colors.white,
                        fontSize: 16),
                  ),
                ),
                items: sessionsList.map((SessionModel sessionModel) {
                  return DropdownMenuItem<SessionModel>(
                    value: sessionModel,
                    child: Center(
                      child: Text(
                        sessionModel.id.toString(),
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
                    sessionModel = value;
                  });
                },
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            /// Attendance
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        "????????",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                      Checkbox(
                        activeColor: AppConstance.mainColor,
                        value: absence,
                        onChanged: (bool? value) {
                          setState(() {
                            presence = false;
                            absence = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Text(
                        "????????",
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                      Checkbox(
                        activeColor: AppConstance.mainColor,
                        value: presence,
                        onChanged: (bool? value) {
                          setState(() {
                            presence = true;
                            absence = false;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 50,
            ),

            ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 10)),
                  elevation: MaterialStateProperty.all<double>(0),
                  fixedSize: MaterialStateProperty.all<Size>(Size(200, 45)),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  backgroundColor:
                      MaterialStateProperty.all(AppConstance.mainColor),
                ),
                onPressed: () {
                  addAttendance();
                },
                child: const Text(
                  "?????????? ????????????",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                )),
          ],
        ),
      ),
    );
  }
}
