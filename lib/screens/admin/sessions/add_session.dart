import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

class AddSessionScreen extends StatefulWidget {
  const AddSessionScreen({Key? key}) : super(key: key);

  @override
  _AddSessionScreenState createState() => _AddSessionScreenState();
}

class _AddSessionScreenState extends State<AddSessionScreen> {
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
  var dio = Dio();
  List<TeacherModel> teacherList = [];
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

    if (end.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل نهاية الجلسة",
        ),
      );
      return;
    }

    if (numberOfStudent.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل عدد الطلبة",
        ),
      );
      return;
    }

    if (int.parse(numberOfStudent.text) > 50) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "عدد الطلبة يجب ان يكون اقل من 50 طالب",
        ),
      );
      return;
    }

    if (zoomLink.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل رابط الجلسة",
        ),
      );
      return;
    }

    if (preSessionId.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل رابط الحلقة السابقة",
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

    if (active == false && notActive == false) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل الحالة ",
        ),
      );
      return;
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var formData = FormData.fromMap({
        "start": start.text,
        "end": end.text,
        "teacher_id": teacherModel!.id,
        "number_of_students": numberOfStudent.text,
        "link": zoomLink.text,
        "pre_session_id" : preSessionId.text,
        "status": active ? 1 : 0,
      });

      var response = await Dio().post("${AppConstance.api_url}/sessions",
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "إضافة جلسة جديدة",
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

                    /// Start
                    Row(
                      children: [
                        Text(
                          "بداية الجلسة",
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
                    TextFormField(
                      controller: start,
                      readOnly: true,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: AppConstance.mainColor,
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: startDateTime,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050));

                        if (picked == null) return;

                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                              hour: startDateTime.hour,
                              minute: startDateTime.minute),
                        );

                        if (pickedTime == null) return;

                        final newDateTime = DateTime(picked.year, picked.month,
                            picked.day, pickedTime.hour, pickedTime.minute);

                        setState(() {
                          startDateTime = newDateTime;
                          start.text = startDateTime.toString();
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        hintText: "بداية الجلسة",
                        hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.34),
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        //Validator
                      },
                      // validator: widget.validationFunction,
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    /// End
                    Row(
                      children: [
                        Text(
                          "نهاية الجلسة",
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
                    TextFormField(
                      controller: end,
                      readOnly: true,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: AppConstance.mainColor,
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: endDateTime,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2050));

                        if (picked == null) return;

                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                              hour: endDateTime.hour,
                              minute: endDateTime.minute),
                        );

                        if (pickedTime == null) return;

                        final newDateTime = DateTime(picked.year, picked.month,
                            picked.day, pickedTime.hour, pickedTime.minute);

                        setState(() {
                          endDateTime = newDateTime;
                          end.text = endDateTime.toString();
                        });
                      },
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        hintText: "بداية الجلسة",
                        hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.34),
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        //Validator
                      },
                      // validator: widget.validationFunction,
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    /// Number Of Students
                    Row(
                      children: [
                        Text(
                          "عدد الطلبة",
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
                    TextFormField(
                      controller: numberOfStudent,
                      keyboardType: TextInputType.number,
                      cursorColor: AppConstance.mainColor,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        hintText: "عدد الطلبة",
                        hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.34),
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        //Validator
                      },
                      // validator: widget.validationFunction,
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    /// session link
                    Row(
                      children: [
                        Text(
                          "رابط الجلسة",
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
                    TextFormField(
                      controller: zoomLink,
                      keyboardType: TextInputType.text,
                      cursorColor: AppConstance.mainColor,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        hintText: "رابط الجلسة",
                        hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.34),
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        //Validator
                      },
                      // validator: widget.validationFunction,
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    /// previous session link
                    Row(
                      children: [
                        Text(
                          "رابط الحلقة السابقة",
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
                    TextFormField(
                      controller: preSessionId,
                      keyboardType: TextInputType.text,
                      cursorColor: AppConstance.mainColor,
                      decoration: InputDecoration(
                        contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        hintText: "رابط الحلقة السابقة",
                        hintStyle: TextStyle(
                            color: Colors.grey.withOpacity(0.34),
                            fontWeight: FontWeight.w600,
                            fontSize: 12),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      onFieldSubmitted: (value) {
                        //Validator
                      },
                      // validator: widget.validationFunction,
                    ),

                    const SizedBox(
                      height: 30,
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

                    /// Active Or Not Active
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "مفعل",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                              Checkbox(
                                activeColor: AppConstance.mainColor,
                                value: active,
                                onChanged: (bool? value) {
                                  setState(() {
                                    notActive = false;
                                    active = true;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "غير مفعل",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                              Checkbox(
                                activeColor: AppConstance.mainColor,
                                value: notActive,
                                onChanged: (bool? value) {
                                  setState(() {
                                    notActive = true;
                                    active = false;
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
