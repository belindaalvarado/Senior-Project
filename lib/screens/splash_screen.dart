import 'package:flutter/material.dart';
import 'dart:async';
import 'package:senior_project/screens/beggining_screen.dart';

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
        context, MaterialPageRoute(builder: (context) => BegginingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //align to center of the scrren
      
      body: 
        Container(
          width: 375,
          height: 670,
          padding: const EdgeInsets.only(
              top: 245,
              left: 58,
              right: 59,
              bottom: 321,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: const Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  SizedBox(
                      width: 258,
                      height: 104,
                      child: Text(
                          'Trimming \nTrends',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontFamily: 'Lobster Two',
                              fontWeight: FontWeight.w400,
                              height: 0,
                          ),
                      ),
                  ),
              ],
          ),
    ),
    );
  }
}