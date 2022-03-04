import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quraan/constants.dart';
import 'package:quraan/screens/choose_screen.dart';
import 'package:quraan/screens/login_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 5000), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ChooseScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         const Text(
            " القرأن الكريم",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
         const SizedBox(
            height: 40,
          ),
          Container(
            height: 50,
            child: SpinKitSquareCircle(
              color: AppConstance.mainColor,
              size: 50.0,
            ),
          )
        ],
      ),
    );
  }
}
