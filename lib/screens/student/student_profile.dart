import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/models/single_user_data_model.dart';
import 'package:quraan/models/user_model.dart';
import 'package:quraan/screens/student/edit_student_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({Key? key}) : super(key: key);

  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfile> {
  UserModel userModel = UserModel();
  SingleUserDataModel singleUserDataModel = SingleUserDataModel();
  bool isLoading = false;

  getUserDataFromUrl(id) async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response = await Dio().get("${AppConstance.api_url}/student/${id}",
          options: Options(headers: {
            'Authorization':
                'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));

      if (response.statusCode == 200) {
        setState(() {
          singleUserDataModel =
              SingleUserDataModel.fromJson(response.data['data']);
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

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userModel =
          UserModel.fromJson(json.decode(prefs.getString("userModel")!));
      getUserDataFromUrl(userModel.userData!.id);
    });
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "الملف الشخصي",
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
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),

                    /// Name
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                              "الأسم : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppConstance.mainColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              singleUserDataModel.name.toString(),
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

                    /// Email
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                              "البريد الألكتروني : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppConstance.mainColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              singleUserDataModel.email.toString(),
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

                    /// Phone Number
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                              "رقم الجوال : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppConstance.mainColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              singleUserDataModel.phone.toString(),
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

                    SizedBox(
                      height: 20,
                    ),

                    /// Age
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                              " السن : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppConstance.mainColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              singleUserDataModel.age.toString(),
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

                    SizedBox(
                      height: 20,
                    ),

                    /// Address
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                              " العنوان : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppConstance.mainColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              singleUserDataModel.address.toString(),
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

                    SizedBox(
                      height: 20,
                    ),

                    /// Gender
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                              " النوع : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: AppConstance.mainColor),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              singleUserDataModel.gender.toString(),
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

                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditStudentProfile(
                                        studentID: singleUserDataModel.id!,
                                      )));
                            },
                            child: Text(
                              "تعديل الملف الشخصي",
                              style: TextStyle(color: AppConstance.mainColor),
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
