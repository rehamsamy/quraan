import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';

class StudentInformations extends StatefulWidget {
  const StudentInformations({Key? key}) : super(key: key);

  @override
  _StudentInformationsState createState() => _StudentInformationsState();
}

class _StudentInformationsState extends State<StudentInformations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstance.mainColor,
        elevation: 0,
        title: Text(
          "بيانات الطلاب",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(bottom: 20),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("أسم الطالب : ",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),),
                        SizedBox(height: 5,),
                        Expanded(
                          child: Text(" محمد وجدي محمد",
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,overflow: TextOverflow.ellipsis
                            ),),
                        )
                      ],
                    ),
                    SizedBox(height: 10,),


                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("البريد الألكتروني : ",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),),
                        SizedBox(height: 5,),
                        Expanded(
                          child: Text("mohamed.wagdy957@gmail.com",
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,overflow: TextOverflow.ellipsis
                            ),),
                        )
                      ],
                    ),


                    SizedBox(height: 10,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("رقم الجوال : ",style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18
                        ),),
                        SizedBox(height: 5,),
                        Expanded(
                          child: Text(" 01009848788",
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,overflow: TextOverflow.ellipsis
                            ),),
                        )
                      ],
                    ),

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
