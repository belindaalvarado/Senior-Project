import 'package:flutter/material.dart';
import './gallery_screen.dart';
import 'dart:io';
// import 'package:replicate/replicate.dart';

//create result screen class
class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

//create result screen state class
class _ResultScreenState extends State<ResultScreen> {
  final files = ValueNotifier(<File>[]);
  bool _continue = false;
  String Url = model.output_URL;

  @override
  void initState() {
    files.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    files.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Output URL: ${model.output_URL}");
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(children: [
        const Padding(
            padding: EdgeInsets.only(top: 100),
            child: Align(
                // alignment: Alignment.bottomCenter,
                child: Text(
              'Results',
              style: TextStyle(
                fontSize: 40,
              ),
            ))),

        //display the picture
        Expanded(
          child: Url.isEmpty
              ? Image.asset('assets/empty.jpg')
              : Image.network(Url),
        ),
      ]),
    );
  }
}
