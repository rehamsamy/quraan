import 'package:flutter/material.dart';
import 'package:quraan/constants.dart';

class AddSession extends StatefulWidget {
  const AddSession({Key? key}) : super(key: key);

  @override
  _AddSessionState createState() => _AddSessionState();
}

class _AddSessionState extends State<AddSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstance.mainColor,
        elevation: 0,
        title: Text(
          "إضافة جلسة",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              // controller: emailController,
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
          ],
        ),
      ),
    );
  }
}
