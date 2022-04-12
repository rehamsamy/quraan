import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/models/student_model.dart';
import 'package:quraan/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class StudentManagement extends StatefulWidget {
  const StudentManagement({Key? key}) : super(key: key);

  @override
  _StudentManagementState createState() => _StudentManagementState();
}

class _StudentManagementState extends State<StudentManagement> {
  UserModel userModel = UserModel();
  List<StudentModel> studentList = [];
  bool isLoading = false;

  getAllStudent() async {
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

  removeStudent(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await Dio().delete("${AppConstance.api_url}/student/${id}",
          options: Options(headers: {
            'Authorization':
                'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));
      if (response.statusCode == 200) {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: "تم الحذف بنجاح",
          ),
        );
        getAllStudent();
      }
    } on DioError catch (exception) {
      /// Get custom massage for the exception
    }
  }

  @override
  void initState() {
    getAllStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "إدارة الطلاب",
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
          : studentList.length == 0
              ? Center(
                  child: Text("لا يوجد بيانات"),
                )
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: ListView.builder(
                    itemCount: studentList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: AppConstance.mainColor.withOpacity(.4),
                                width: 1)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Name
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "الأسم : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: AppConstance.mainColor),
                                ),
                                Expanded(
                                    child: Text(
                                  studentList[index].name.toString(),
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            ),

                            SizedBox(
                              height: 5,
                            ),

                            /// Email
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "البريد الألكتروني : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: AppConstance.mainColor),
                                ),
                                Expanded(
                                    child: Text(
                                  studentList[index].email.toString(),
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            ),

                            SizedBox(
                              height: 5,
                            ),

                            /// Phone
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "رقم الجوال : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: AppConstance.mainColor),
                                ),
                                Expanded(
                                    child: Text(
                                  studentList[index].phone.toString(),
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            ),

                            SizedBox(
                              height: 5,
                            ),

                            /// Address
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "العنوان : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: AppConstance.mainColor),
                                ),
                                Expanded(
                                    child: Text(
                                  studentList[index].address.toString(),
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            ),

                            SizedBox(
                              height: 5,
                            ),

                            /// Age
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "السن : ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: AppConstance.mainColor),
                                ),
                                Expanded(
                                    child: Text(
                                  studentList[index].age.toString(),
                                  softWrap: true,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ))
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        removeStudent(studentList[index].id);
                                      });
                                    },
                                    child: Text(
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
    );
  }
}
