import 'dart:convert';
import 'package:quraan/screens/admin/sessions/add_session.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/models/session_model.dart';
import 'package:quraan/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherAllSessions extends StatefulWidget {
  const TeacherAllSessions({Key? key}) : super(key: key);

  @override
  _TeacherAllSessionsState createState() => _TeacherAllSessionsState();
}

class _TeacherAllSessionsState extends State<TeacherAllSessions> {
  UserModel userModel = UserModel();
  List<SessionModel> sessionList = [];
  bool isLoading = false;

  getAllSessions() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      userModel =
          UserModel.fromJson(json.decode(prefs.getString("userModel")!));
      var response = await Dio().get(
          "${AppConstance.api_url}/teacher/${userModel.userData!.id}/sessions",
          options: Options(headers: {
            'Authorization':
                'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));

      if (response.statusCode == 200) {
        setState(() {
          sessionList = (response.data['data'] as List)
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

  @override
  void initState() {
    getAllSessions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "الجلسات",
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
          : sessionList.length == 0
              ? Center(
                  child: Text("لا يوجد بيانات"),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddSessionScreen(),
                                    ));
                              },
                              child: Text(
                                "إضافة جلسة جديدة",
                                style: TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: sessionList.length,
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
                                        "رقم الجلسة : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppConstance.mainColor),
                                      ),
                                      Expanded(
                                          child: Text(
                                        sessionList[index].id.toString(),
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
                                        "بداية الجسلة : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppConstance.mainColor),
                                      ),
                                      Expanded(
                                          child: Text(
                                        sessionList[index].start.toString(),
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                    ],
                                  ),

                                  SizedBox(
                                    height: 5,
                                  ),

                                  /// End
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "نهاية الجلسة : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppConstance.mainColor),
                                      ),
                                      Expanded(
                                          child: Text(
                                        sessionList[index].end.toString(),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "عدد الطلبة : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppConstance.mainColor),
                                      ),
                                      Expanded(
                                          child: Text(
                                        sessionList[index]
                                            .numberOfStudents
                                            .toString(),
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),

                                  /// Session Link
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "رابط الجلسة :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppConstance.mainColor),
                                      ),
                                      Expanded(
                                          child: GestureDetector(
                                        onTap: () async {
                                          var url = sessionList[index]
                                              .link
                                              .toString();
                                          if (await canLaunch(url)) {
                                            await launch(url,
                                                forceSafariVC: false);
                                          } else {
                                            throw 'Could not launch $url';
                                          }
                                        },
                                        child: Text(
                                          sessionList[index].link.toString(),
                                          softWrap: true,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                    ],
                                  ),

                                  SizedBox(
                                    height: 5,
                                  ),

                                  /// previous Link
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "رابط الحلقة السابقة :",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppConstance.mainColor),
                                      ),
                                      Expanded(
                                          child: GestureDetector(
                                            onTap: () async {
                                             if(sessionList[index].preSessionId != null){
                                               var url = sessionList[index]
                                                   .preSessionId
                                                   .toString();
                                               if (await canLaunch(url)) {
                                                 await launch(url,
                                                     forceSafariVC: false);
                                               } else {
                                                 throw 'Could not launch $url';
                                               }
                                             }
                                            },
                                            child: Text(
                                              sessionList[index].preSessionId ?? "",
                                              softWrap: true,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ))
                                    ],
                                  ),

                                  SizedBox(
                                    height: 5,
                                  ),

                                  /// Status
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        " الحالة : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppConstance.mainColor),
                                      ),
                                      Expanded(
                                          child: Text(
                                        sessionList[index].status == "1"
                                            ? "مفعل"
                                            : "غير مفعل",
                                        softWrap: true,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ))
                                    ],
                                  ),
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
