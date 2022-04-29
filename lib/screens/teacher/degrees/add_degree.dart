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

class TeacherAddDegree extends StatefulWidget {
  const TeacherAddDegree({Key? key}) : super(key: key);

  @override
  State<TeacherAddDegree> createState() => _TeacherAddDegreeState();
}

class _TeacherAddDegreeState extends State<TeacherAddDegree> {
  var dio = Dio();
  List<StudentModel> studentsList = [];
  List<SessionModel> sessionsList = [];
  StudentModel? studentModel;
  SessionModel? sessionModel;
  bool isLoading = false;
  UserModel userModel = UserModel();
TextEditingController gradeController = TextEditingController();
TextEditingController surahNameController = TextEditingController();
TextEditingController partNumberController = TextEditingController();
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

  addGrade() async {
    if (studentModel == null) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "أختر الطالب",
        ),
      );
      return;
    }

    if (sessionModel == null) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "أختر رقم الجلسة",
        ),
      );
      return;
    }

    if (gradeController.text.isEmpty) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "أدخل الدرجة ",
        ),
      );
      return;
    }


    if (surahNameController.text.isEmpty) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "أدخل أسم السورة ",
        ),
      );
      return;
    }


    if (partNumberController.text.isEmpty) {
      showTopSnackBar(
        context,
        const CustomSnackBar.error(
          message: "أدخل رقم الجزء ",
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
        "grade": gradeController.text,
        "surah_name": surahNameController.text,
        "part_number": partNumberController.text,
      });

      var response = await Dio().post("${AppConstance.api_url}/grades",
          data: formData,
          options: Options(headers: {
            'Authorization':
            'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));

      if (response.statusCode == 200) {
        showTopSnackBar(
          context,
          const CustomSnackBar.success(
            message: "تم التسجيل بنجاح",
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
            message: exception.response!.data['errors']['end']),
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
          "إضافة الدرجات",
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
                  "أختر الطالب",
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
                        ? "أختر الطالب"
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
                  "أختر رقم الجلسة",
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
                        ? "أختر رقم الجلسة"
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

            /// Grade
            Row(
              children: [
                Text(
                  "الدرجة",
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
              controller: gradeController,
              keyboardType: TextInputType.number,
              cursorColor: AppConstance.mainColor,
              decoration: InputDecoration(
                contentPadding:
                EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                hintText: "الدرجة",
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


            /// Surah Name
            Row(
              children: [
                Text(
                  "أسم السورة",
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
              controller: surahNameController,
              keyboardType: TextInputType.text,
              cursorColor: AppConstance.mainColor,
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                hintText: "أسم السورة",
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


            /// Part Number
            Row(
              children: [
                Text(
                  "رقم الجزء",
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
              controller: partNumberController,
              keyboardType: TextInputType.number,
              cursorColor: AppConstance.mainColor,
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                hintText: "رقم الجزء",
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
                  addGrade();
                },
                child: const Text(
                  "إضافة الدرجة",
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
