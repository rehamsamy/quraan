import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/models/session_model.dart';
import 'package:quraan/models/user_model.dart';
import 'package:quraan/screens/admin/sessions/add_session.dart';
import 'package:quraan/screens/admin/sessions/session_details.dart';
import 'package:quraan/screens/admin/sessions/update_session.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class AllSessions extends StatefulWidget {
  const AllSessions({Key? key}) : super(key: key);

  @override
  _AllSessionsState createState() => _AllSessionsState();
}

class _AllSessionsState extends State<AllSessions> {
  UserModel userModel = UserModel();
  List<SessionModel> sessionList = [];
  bool isLoading = false;

  getAllSessions() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await Dio().get("${AppConstance.api_url}/sessions",
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

  removeSession(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response =
          await Dio().delete("${AppConstance.api_url}/sessions/${id}",
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
        getAllSessions();
      }
    } on DioError catch (exception) {
      /// Get custom massage for the exception
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
          "إدارة الجلسات",
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


                                  /// Teacher name
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "أسم المعلم : ",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppConstance.mainColor),
                                      ),
                                      Expanded(
                                          child: Text(
                                        sessionList[index]
                                            .teacher!
                                            .name
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

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              removeSession(
                                                  sessionList[index].id);
                                            });
                                          },
                                          child: Text(
                                            "حذف",
                                            style: TextStyle(color: Colors.red),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdateSessionScreen(
                                                          sessionModel:
                                                              sessionList[
                                                                  index]),
                                                ));
                                          },
                                          child: Text(
                                            "تعديل",
                                            style:
                                                TextStyle(color: Colors.green),
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SessionDetailsScreen(
                                                          sessionModel:
                                                              sessionList[
                                                                  index]),
                                                ));
                                          },
                                          child: Text(
                                            "التفاصيل",
                                            style: TextStyle(
                                                color: AppConstance.mainColor),
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
                ),
    );
  }
}
