import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/models/user_model.dart';
import 'package:quraan/screens/teacher/edit_teacher_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({Key? key}) : super(key: key);

  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  UserModel userModel = UserModel();

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userModel =  UserModel.fromJson(json.decode(prefs.getString("userModel")!));
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
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600,color: AppConstance.mainColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

              SizedBox(height: 40,),

              /// Name
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: AppConstance.mainColor.withOpacity(.4),width: 1)
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("الأسم : ",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        color: AppConstance.mainColor
                      ),),
                      SizedBox(height: 5,),
                      Text(userModel.userData!.name.toString(),
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,overflow: TextOverflow.ellipsis
                        ),)
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20,),

              /// Email
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: AppConstance.mainColor.withOpacity(.4),width: 1)
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("البريد الألكتروني : ",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        color: AppConstance.mainColor
                      ),),
                      SizedBox(height: 5,),
                      Text(userModel.userData!.email.toString(),
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,overflow: TextOverflow.ellipsis
                        ),)
                    ],
                  ),
                ),
              ),

              const  SizedBox(height: 20,),

              /// Phone Number
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: AppConstance.mainColor.withOpacity(.4),width: 1)
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("رقم الجوال : ",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        color: AppConstance.mainColor
                      ),),
                      SizedBox(height: 5,),
                      Text(userModel.userData!.phone.toString(),
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,overflow: TextOverflow.ellipsis
                        ),)
                    ],
                  ),
                ),
              ),


              SizedBox(height: 20,),

              /// Age
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: AppConstance.mainColor.withOpacity(.4),width: 1)
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" السن : ",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        color: AppConstance.mainColor
                      ),),
                      SizedBox(height: 5,),
                      Text(userModel.userData!.age.toString(),
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,overflow: TextOverflow.ellipsis
                        ),)
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20,),


              /// Gender
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: AppConstance.mainColor.withOpacity(.4),width: 1)
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" النوع : ",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        color: AppConstance.mainColor
                      ),),
                      SizedBox(height: 5,),
                      Text(userModel.userData!.gender.toString(),
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,overflow: TextOverflow.ellipsis
                        ),)
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditTeacherProfile()));
                  }, child: Text("تعديل الملف الشخصي", style: TextStyle(
                    color: AppConstance.mainColor
                  ),)),
                ],
              )


            ],
          ),
        ),
      ),
    );
  }
}
