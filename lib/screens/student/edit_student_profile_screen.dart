import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/models/user_model.dart';
import 'package:quraan/sharedText.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditStudentProfile extends StatefulWidget {
  const EditStudentProfile({Key? key}) : super(key: key);

  @override
  State<EditStudentProfile> createState() => _EditStudentProfileState();
}

class _EditStudentProfileState extends State<EditStudentProfile> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  UserModel userModel = UserModel();
  bool isMale = false;
  bool isFemale = false;

  _editUser() async {
    if(nameController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message:
          "أدخل الأسم",
        ),
      );
      return;
    }
    if(emailController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message:
          "أدخل البريد الألكتروني",
        ),
      );
      return;
    }


    if(passwordController.text != confirmPasswordController.text) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message:
          "كلمة المرور وتأكيد كلمة المرور غير متطابقان",
        ),
      );
      return;
    }
    if(phoneController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message:
          "أدخل رقم الجوال",
        ),
      );
      return;
    }
    if(ageController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message:
          "أدخل السن ",
        ),
      );
      return;
    }

    if(isMale == false && isFemale == false) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message:
          "أدخل الجنس ",
        ),
      );
      return;
    }

    try {

      print("mkemewkmewmekm ${nameController.text}");
      print("mkemewkmewmekm ${emailController.text}");
      print("mkemewkmewmekm ${passwordController.text}");
      print("mkemewkmewmekm ${confirmPasswordController.text}");
      print("mkemewkmewmekm ${ageController.text}");
      print("mkemewkmewmekm ${phoneController.text}");
      print("mkemewkmewmekm ${isMale}");
      print("mkemewkmewmekm ${isFemale}");
      var formData;

      passwordController.text.isEmpty ?
      formData = FormData.fromMap({
        "name" : nameController.text,
        "email" : emailController.text,
        "password" : SharedText.password,
        "password_confirmation" : SharedText.password,
        "phone" : phoneController.text,
        "gender" : isMale ? "male" : "female",
        "age" : ageController.text,
      })
          :

      formData = FormData.fromMap({
        "name" : nameController.text,
        "email" : emailController.text,
        "password" : passwordController.text,
        "password_confirmation" : confirmPasswordController.text,
        "phone" : phoneController.text,
        "gender" : isMale ? "male" : "female",
        "age" : ageController.text,
      });


      var response = await Dio().put("${AppConstance.api_url}/teacher/${userModel.userData!.id}",
          data: formData,
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${SharedText.userToken}',
          })
      );

      print("response is ${response.statusCode}");
      print("response is ${response.data}");

      if(response.statusCode == 200) {
        Navigator.pop(context);
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message:
            "تم التعديل بنجاح",
          ),
        );
      }

    } on DioError catch (exception) {
      /// Get custom massage for the exception
      showTopSnackBar(
        context,
        CustomSnackBar.error(
            message:
            exception.response!.data['errors']['email'][0]
        ),
      );
    }


    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) => LoginScreen()));

  }

  setInformationOfUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userModel =  UserModel.fromJson(json.decode(prefs.getString("userModel")!));
      emailController.text = userModel.userData!.email!;
      nameController.text = userModel.userData!.name!;
      phoneController.text = userModel.userData!.phone!;
      ageController.text = userModel.userData!.age!;
      isMale = userModel.userData!.gender == "male" ? true : false;
      isFemale = userModel.userData!.gender == "female" ? true : false;
    });
  }

  @override
  void initState() {
    setInformationOfUser();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "تعديل بيانات حسابك",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: AppConstance.mainColor),
        ),
        centerTitle: true,
      ),
      body: Container(
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
              const SizedBox(height: 10,),
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
              const SizedBox(height: 10,),
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
              const SizedBox(height: 10,),
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
              const SizedBox(height: 10,),
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
                    // _register();
                    _editUser();
                  },
                  child: const Text(
                    "تسجيل",
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
