import 'package:flutter/material.dart';
import './gallery_screen.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String Url = model.output_URL;


  @override
  Widget build(BuildContext context) {
    print("Output URL: ${model.output_URL}");
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(children: [
        const Padding(
            padding: EdgeInsets.only(top: 100),
            child: Align(
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
