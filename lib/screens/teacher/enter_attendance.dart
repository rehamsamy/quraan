import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';
import 'package:intl/intl.dart';

class EnterAttendance extends StatefulWidget {
  const EnterAttendance({Key? key}) : super(key: key);

  @override
  _EnterAttendanceState createState() => _EnterAttendanceState();
}

class _EnterAttendanceState extends State<EnterAttendance> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstance.mainColor,
        elevation: 0,
        title: Text(
          "إضافة الغياب",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("اليوم : ${DateFormat('EEEE').format(DateTime.now())}",style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600
                ),),),
            Expanded(
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 6,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text("غياب"),
                                  Checkbox(
                                    activeColor: AppConstance.mainColor,
                                    checkColor: Colors.white,
                                    value: _value,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _value = value!;
                                      });
                                    },
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text("حضور"),
                                  Checkbox(
                                    activeColor: AppConstance.mainColor,
                                    checkColor: Colors.white,
                                    value: _value,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _value = value!;
                                      });
                                    },
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
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
