import 'dart:convert';
import 'package:quraan/models/attendance_model.dart';
import 'package:quraan/screens/teacher/attendance/teacher_add_new_attendance.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherAttendance extends StatefulWidget {
  const TeacherAttendance({Key? key}) : super(key: key);

  @override
  _TeacherAttendanceState createState() => _TeacherAttendanceState();
}

class _TeacherAttendanceState extends State<TeacherAttendance> {
  UserModel userModel = UserModel();
  List<AttendanceListModel> attendanceList = [];
  bool isLoading = false;

  getAllAttendance() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      userModel =
          UserModel.fromJson(json.decode(prefs.getString("userModel")!));
      var response = await Dio().get(
          "${AppConstance.api_url}/attendances",
          options: Options(headers: {
            'Authorization':
                'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));

      if (response.statusCode == 200) {
        setState(() {
          attendanceList = (response.data['data'] as List)
              .map((e) => AttendanceListModel.fromJson(e))
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


  removeAttendance(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response =
      await Dio().delete("${AppConstance.api_url}/attendances/${id}",
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
        getAllAttendance();
      }
    } on DioError catch (exception) {
      /// Get custom massage for the exception
    }
  }

  @override
  void initState() {
    getAllAttendance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "الحضور والإنصراف",
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
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewAttendance(),));
                      },
                      child: const Text(
                        "إضافة حضور وأنصراف",
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
                  : attendanceList.length == 0
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
                                  itemCount: attendanceList.length,
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
                                                    attendanceList[index].sessionId.toString(),
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
                                                    attendanceList[index].teacher!.name.toString(),
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
                                                    attendanceList[index].student!.name.toString(),
                                                    softWrap: true,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ))
                                            ],
                                          ),

                                          SizedBox(
                                            height: 5,
                                          ),

                                          /// Status
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "الحالة : ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color:
                                                    AppConstance.mainColor),
                                              ),
                                              Expanded(
                                                  child: Text(
                                                    attendanceList[index].status == "1" ? "حضور" : "غياب",
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
                                                      removeAttendance(attendanceList[index].id);
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
