import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quraan/models/session_model.dart';
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

class SessionDetailsScreen extends StatefulWidget {
  SessionModel sessionModel;

  SessionDetailsScreen({Key? key, required this.sessionModel})
      : super(key: key);

  @override
  _SessionDetailsScreenState createState() => _SessionDetailsScreenState();
}

class _SessionDetailsScreenState extends State<SessionDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "تفاصيل الجلسة رقم ${widget.sessionModel.id}",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppConstance.mainColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),

              /// Session Number
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                      Text(
                        "رقم الجسلة : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppConstance.mainColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.sessionModel.id.toString(),
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              /// Session Start
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                      Text(
                        "بداية الجلسة : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppConstance.mainColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.sessionModel.start.toString(),
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              /// Session end
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                      Text(
                        "بداية الجلسة : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppConstance.mainColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.sessionModel.end.toString(),
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              /// Session Status
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                      Text(
                        "الحالة : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppConstance.mainColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.sessionModel.status == "1" ? "مفعل" : "غير مفعل",
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              /// Session Student
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                      Text(
                        "عدد الطلبة : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppConstance.mainColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.sessionModel.numberOfStudents.toString(),
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              /// Teacher name
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                      Text(
                        "أسم المعلم : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppConstance.mainColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.sessionModel.teacher!.name.toString(),
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
