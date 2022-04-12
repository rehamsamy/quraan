import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/models/single_user_data_model.dart';
import 'package:quraan/models/user_model.dart';
import 'package:quraan/sharedText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditStudentProfile extends StatefulWidget {
  int studentID;

  EditStudentProfile({Key? key, required this.studentID}) : super(key: key);

  @override
  State<EditStudentProfile> createState() => _EditStudentProfileState();
}

class _EditStudentProfileState extends State<EditStudentProfile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  SingleUserDataModel singleUserDataModel = SingleUserDataModel();
  bool isMale = false;
  bool isFemale = false;
  bool isLoading = false;

  _editUser() async {
    if (nameController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل الأسم",
        ),
      );
      return;
    }
    if (emailController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل البريد الألكتروني",
        ),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "كلمة المرور وتأكيد كلمة المرور غير متطابقان",
        ),
      );
      return;
    }
    if (phoneController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل رقم الجوال",
        ),
      );
      return;
    }
    if (addressController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل العنوان ",
        ),
      );
      return;
    }
    if (ageController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل السن ",
        ),
      );
      return;
    }

    if (isMale == false && isFemale == false) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل الجنس ",
        ),
      );
      return;
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var response = await Dio().put(
          "${AppConstance.api_url}/student/${widget.studentID}?name=${nameController.text}&email=${emailController.text}&password=${passwordController.text.isEmpty ? SharedText.password : passwordController.text}&password_confirmation=${confirmPasswordController.text.isEmpty ? SharedText.password : confirmPasswordController.text}&phone=${phoneController.text}&address=${addressController.text}&gender=${isMale ? "male" : "female"}&age=${ageController.text}",
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization':
                'Bearer ${json.decode(prefs.getString("tokenAccess")!)}',
          }));

      if (response.statusCode == 200) {
        Navigator.pop(context);
        Navigator.pop(context);
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: "تم التعديل بنجاح",
          ),
        );
      }
    } on DioError catch (exception) {
      /// Get custom massage for the exception
      showTopSnackBar(
        context,
        CustomSnackBar.error(message: exception.response!.data['status']),
      );
    }

    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  getUserDataFromUrl(studentID) async {
    setState(() {
      isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var response =
          await Dio().get("${AppConstance.api_url}/student/${studentID}",
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

  setInformationOfUser() async {
    await getUserDataFromUrl(widget.studentID);
    setState(() {
      emailController.text = singleUserDataModel.email!;
      nameController.text = singleUserDataModel.name!;
      phoneController.text = singleUserDataModel.phone!;
      ageController.text = singleUserDataModel.age!;
      addressController.text = singleUserDataModel.address!;
      isMale = singleUserDataModel.gender == "male" ? true : false;
      isFemale = singleUserDataModel.gender == "female" ? true : false;
    });
  }

  @override
  void initState() {
    setInformationOfUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "تعديل بيانات حسابك",
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
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Center(
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),

                    /// Name
                    Row(
                      children: [
                        Text(
                          " الأسم",
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
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      cursorColor: AppConstance.mainColor,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        hintText: "الأسم",
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

                    /// Email
                    Row(
                      children: [
                        Text(
                          "البريد الألكتروني",
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
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      cursorColor: AppConstance.mainColor,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        hintText: "البريد الألكتروني",
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

                    /// Password
                    Row(
                      children: [
                        Text(
                          "كلمة المرور",
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
                      obscureText: true,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      cursorColor: AppConstance.mainColor,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        hintText: "كلمة المرور",
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

                    /// Confirm Password
                    Row(
                      children: [
                        Text(
                          "تأكيد كلمة المرور",
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
                      obscureText: true,
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.text,
                      cursorColor: AppConstance.mainColor,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        hintText: "تأكيد كلمة المرور",
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

                    /// Phone
                    Row(
                      children: [
                        Text(
                          "رقم الجوال",
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
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      cursorColor: AppConstance.mainColor,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        hintText: "رقم الجوال",
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

                    /// Address
                    Row(
                      children: [
                        Text(
                          "العنوان",
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
                      controller: addressController,
                      keyboardType: TextInputType.text,
                      cursorColor: AppConstance.mainColor,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        hintText: "العنوان",
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

                    /// Age
                    Row(
                      children: [
                        Text(
                          "السن",
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
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      cursorColor: AppConstance.mainColor,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                        hintText: "السن",
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

                    /// Gender
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Text(
                                "ذكر",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                              Checkbox(
                                activeColor: AppConstance.mainColor,
                                value: isMale,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isFemale = false;
                                    isMale = true;
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
                                "أنثي",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14),
                              ),
                              Checkbox(
                                activeColor: AppConstance.mainColor,
                                value: isFemale,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isFemale = true;
                                    isMale = false;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 30,
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
                          // _register();
                          _editUser();
                        },
                        child: const Text(
                          "تعديل",
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
