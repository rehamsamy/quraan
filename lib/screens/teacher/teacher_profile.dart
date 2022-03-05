import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({Key? key}) : super(key: key);

  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstance.mainColor,
        elevation: 0,
        title: Text(
          "الملف الشخصي",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ]
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("الأسم : ",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),),
                      SizedBox(height: 5,),
                      Text("Nora Bakhit",
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

              /// Email
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("البريد الألكتروني : ",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),),
                      SizedBox(height: 5,),
                      Text("johnDio@gmail.com",
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

              /// Phone Number
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("رقم الجوال : ",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),),
                      SizedBox(height: 5,),
                      Text("0123456789",
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(" السن : ",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),),
                      SizedBox(height: 5,),
                      Text("28 سنة",
                        maxLines: 1,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,overflow: TextOverflow.ellipsis
                        ),)
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),

              /// Sallery
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ]),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        " الراتب : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "3000 ريال",
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
            ],
          ),
        ),
      ),
    );
  }
}
