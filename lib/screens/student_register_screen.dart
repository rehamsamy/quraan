import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/screens/login_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:dio/dio.dart';

class StudentRegisterScreen extends StatefulWidget {
  const StudentRegisterScreen({Key? key}) : super(key: key);

  @override
  _StudentRegisterScreenState createState() => _StudentRegisterScreenState();
}

class _StudentRegisterScreenState extends State<StudentRegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController sallaryController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController partsController = TextEditingController();
  bool isMale = false;
  bool isFemale = false;
  bool parts1to5=false;
  bool parts5to10=false;
  bool parts10to15=false;
  bool parts15to20=false;
  bool parts20to25=false;
  bool parts25to30=false;

  _register() async {
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
    if (passwordController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل كلمة المرور",
        ),
      );
      return;
    }
    if (passwordController.text.length < 6) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "كلمة المرور يجب أن تكون أكبر من 6 حروف أو أرقام",
        ),
      );
      return;
    }
    if (confirmPasswordController.text.isEmpty) {
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل تأكيد كلمة المرور",
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

    if (parts1to5==false&&parts5to10==false&&parts10to15==false&& parts15to20==false
    && parts20to25 ==false && parts25to30==false &&parts25to30){
      showTopSnackBar(
        context,
        CustomSnackBar.error(
          message: "أدخل عدد الاجزاء ",
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
      var formData = FormData.fromMap({
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text,
        "phone": phoneController.text,
        "address": addressController.text,
        "gender": isMale ? "male" : "female",
        "age": ageController.text,
        "number_of_parts":parts1to5?"1-5(المعلمه عبير)":
                          parts5to10?"5-10(المعلمه فاطمه)":
                          parts10to15?"10-15(المعلمه مريم)":
                          parts15to20?"15-20(المعلمه هدي )":
                          parts20to25?"20-25(المعلمه نوف)":
                          parts25to30?"25-30(المعلمه نور)":null
      });

      var response = await Dio()
          .post("${AppConstance.api_url}/student/register", data: formData);

      if (response.statusCode == 200) {
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message: "تم التسجيل بنجاح",
          ),
        );

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      }

      setState(() {
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        phoneController.clear();
        addressController.clear();
        ageController.clear();
        isMale = false;
        isFemale = false;
      });
    } on DioError catch (exception) {
      /// Get custom massage for the exception
      showTopSnackBar(
        context,
        CustomSnackBar.error(
            message: exception.response!.data['errors']['email'][0]),
      );
    }

    // Navigator.of(context).push(
    //     MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "تسجيل طالب جديد",
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppConstance.mainColor),
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

              //number of parts
              const SizedBox(
                height: 30,
              ),

              Row(
                children: [
                  Text(
                    "عدد الاجزاء",
                    style: TextStyle(
                        color: AppConstance.mainColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ],
              ),

              const SizedBox(
                height: 5,
              ),
///////////////////////   parts
              Column(

                                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildPartsNumber('من 1 الي 5(المعلمة عبير)',parts1to5,1),
                      buildPartsNumber('من 5 الي 10(المعلمة فاطمة)',parts5to10,2),
                    ],
                  ),
                  Row(
                    children: [
                      buildPartsNumber('من 10 الي 15(المعلمة مريم)',parts10to15,3),
                      buildPartsNumber('من 15 الي 20(المعلمة هدي)',parts15to20,4),
                    ],
                  ),
                  Row(
                    children: [
                      buildPartsNumber('من 20 الي 25(المعلمة نوف)',parts20to25,5),
                      buildPartsNumber('من 25 الي 30(المعلمة نور)',parts25to30,6),
                    ],
                  )
                ],
              ),

              const SizedBox(
                height: 10,
              ),

              Row(
                children: [
                  Text(
                    "الجنس",
                    style: TextStyle(
                        color: AppConstance.mainColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ],
              ),

              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    _register();
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

  buildPartsNumber(String title,bool valueChange,int flag) {
    return Expanded(
      child: Row(
        children: [
          Text(
          title,
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: 14),
          ),
          Checkbox(
            activeColor: AppConstance.mainColor,
            value: valueChange,
            onChanged: (bool? value) {
              setState(() {
                if(flag==1){print('yes');
                  parts1to5=true;
                  parts5to10= false;
                  parts10to15=false;
                  parts15to20=false;
                  parts20to25=false;
                  parts25to30=false;
                }

              else  if(flag==2){
                  parts1to5=false;
                  parts5to10= true;
                  parts10to15=false;
                  parts15to20=false;
                  parts20to25=false;
                  parts25to30=false;
                }

               else if(flag==3){
                  parts1to5=false;
                  parts5to10= false;
                  parts10to15=true;
                  parts15to20=false;
                  parts20to25=false;
                  parts25to30=false;
                }

               else if(flag==4){
                  parts1to5=false;
                  parts5to10= false;
                  parts10to15=false;
                  parts15to20=true;
                  parts20to25=false;
                  parts25to30=false;
                }

              else  if(flag==5){
                  parts1to5=false;
                  parts5to10= false;
                  parts10to15=false;
                  parts15to20=false;
                  parts20to25=true;
                  parts25to30=false;
                }

               else if(flag==6){
                  parts1to5=false;
                  parts5to10= false;
                  parts10to15=false;
                  parts15to20=false;
                  parts20to25=false;
                  parts25to30=true;
                }



              });
            },
          ),
        ],
      ),
    );

  }
}
