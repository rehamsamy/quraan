import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/models/student_attendance_model.dart';
import 'package:quraan/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {

  UserModel userModel = UserModel();
  List<StudentAttendanceModel> attendanceList = [];
  bool isLoading = false;

  getAllGrades() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      userModel =
          UserModel.fromJson(json.decode(prefs.getString("userModel")!));

      var response = await Dio().get(
          "${AppConstance.api_url}/student/${userModel.userData!.id}/attendances",
          options: Options(headers: {
            'Authorization':
            'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));

      if (response.statusCode == 200) {
        setState(() {
          attendanceList = (response.data['data'] as List)
              .map((e) => StudentAttendanceModel.fromJson(e))
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

  @override
  void initState() {
    getAllGrades();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "الحضور والأنصراف",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppConstance.mainColor),
        ),
        centerTitle: true,
      ),
      body:

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
          ? const Center(
        child: Text("لا يوجد بيانات"),
      )
          :
      Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: ListView.builder(
          itemCount: attendanceList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 20, horizontal: 15),
              margin: const EdgeInsets.only(bottom: 15),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      color: AppConstance.mainColor.withOpacity(.4),
                      width: 1)),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "أسم المدرس : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18,color: AppConstance.mainColor),
                        ),
                      const  SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Text(
                           attendanceList[index].teacher!.name.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis),
                          ),
                        )
                      ],
                    ),
                   const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "حالة الحضور : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18,color: AppConstance.mainColor),
                        ),
                      const  SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Text(
                            attendanceList[index].status == "1" ? "حضور" : "غياب",
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis),
                          ),
                        )
                      ],
                    ),
                    const    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "رقم الجلسة : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18,color: AppConstance.mainColor),
                        ),
                        const   SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Text(
                            attendanceList[index].session!.id.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis),
                          ),
                        )
                      ],
                    ),
                  const  SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "أسم الطالب : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18,color: AppConstance.mainColor),
                        ),
                       const SizedBox(
                          height: 5,
                        ),
                        Expanded(
                          child: Text(
                            attendanceList[index].student!.name.toString(),
                            maxLines: 1,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                overflow: TextOverflow.ellipsis),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
