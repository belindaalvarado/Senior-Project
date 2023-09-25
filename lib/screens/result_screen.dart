import 'package:flutter/material.dart';


//create result screen class
class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

//create result screen state class
class _ResultScreenState extends State<ResultScreen> {

  //get immage from last screen and display it here
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          Text(
            'Here is your result\n (images will be displayed here))',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w400,
            ),      
          ),
        ],
         mainAxisAlignment: MainAxisAlignment.center,)
      )
    );
  }
}