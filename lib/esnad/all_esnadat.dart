import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/esnad/add_esnad.dart';
import 'package:quraan/models/esnad_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AllEsnadatScreen extends StatefulWidget {

  @override
  _AllEsnadatScreenState createState() => _AllEsnadatScreenState();
}

class _AllEsnadatScreenState extends State<AllEsnadatScreen> {
  List<EsnadModel> esnadList = [];
  bool isLoading = false;
  getAllEsnad() async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await Dio().get("${AppConstance.api_url}/teacher_students",
          options: Options(headers: {
            'Authorization':
            'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));

      if (response.statusCode == 200) {
        setState(() {
          esnadList = (response.data['data'] as List)
              .map((e) => EsnadModel.fromJson(e))
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

  removeEsnad(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response =
      await Dio().delete("${AppConstance.api_url}/teacher_students/${id}",
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
        getAllEsnad();
      }
    } on DioError catch (exception) {
      /// Get custom massage for the exception
    }
  }

  @override
  void initState() {
    getAllEsnad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "إدارة الاسنادات",
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
          : esnadList.length == 0
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
                            builder: (context) => AddEsnadScreen(),
                          ));
                    },
                    child: Text(
                      "إضافة إسناد جديد",
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
                itemCount: esnadList.length,
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
                                  esnadList[index]
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


                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "أسم الطالب : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: AppConstance.mainColor),
                            ),
                            Expanded(
                                child: Text(
                                  esnadList[index]
                                      .student!
                                      .name
                                      .toString(),
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
                                    removeEsnad(
                                        esnadList[index].id);
                                  });
                                },
                                child: Text(
                                  "حذف",
                                  style: TextStyle(color: Colors.red),
                                )),
                            // TextButton(
                            //     onPressed: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //             builder: (context) =>
                            //                 UpdateSessionScreen(
                            //                     sessionModel:
                            //                     sessionList[
                            //                     index]),
                            //           ));
                            //     },
                            //     child: Text(
                            //       "تعديل",
                            //       style:
                            //       TextStyle(color: Colors.green),
                            //     )),
                            TextButton(
                                onPressed: () {
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           SessionDetailsScreen(
                                  //               sessionModel:
                                  //               sessionList[
                                  //               index]),
                                  //     ));
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
