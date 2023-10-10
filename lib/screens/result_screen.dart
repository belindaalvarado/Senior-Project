import 'package:flutter/material.dart';

//create result screen class
class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

//create result screen state class
class _ResultScreenState extends State<ResultScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color.fromRGBO(168, 199, 183, 1),
              )),
        ),
        body: const Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Results',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        ));
  }
}
