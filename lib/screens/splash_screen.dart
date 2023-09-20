import 'package:flutter/material.dart';
import 'dart:async';
import 'package:senior_project/screens/beggining_screen.dart';
import 'package:senior_project/screens/upload_picture_screen1.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = Duration(seconds: 3);
    return Timer(duration, navigateToDeviceScreen);
  }

  navigateToDeviceScreen() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => UploadPictureScreen1()));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      //align to center of the scrren
      backgroundColor: Color(0xffFFFFFF),
      body: 
      Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Trimming\n Trends',
                  style: TextStyle(
                    fontFamily: 'Lobster Two',
                    fontSize: 40,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                
                ) ,
              ]
          ),
    ),
    );
  }
}