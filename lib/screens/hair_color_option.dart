//import 'dart:html';
import 'package:senior_project/screens/selection_screen.dart';
import 'package:senior_project/screens/choices_screen.dart';
import 'package:senior_project/screens/hair_color_choices.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/utils/buttons.dart';
//import 'dart:io';

class ColorHairScreen extends StatefulWidget {
  const ColorHairScreen({Key? key}) : super(key: key);

  @override
  _ColorHairScreenState createState() => _ColorHairScreenState();
}

class _ColorHairScreenState extends State<ColorHairScreen> {
  bool _continue = false;
  bool _hair_change = false;
  bool _no_hair_change = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color.fromRGBO(168, 199, 183, 1),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.only(bottom: 25),
                child: Align(
                    child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Would you like to change the color of your hair?',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                    ),
                  ),
                ))),
            Padding(
                padding: const EdgeInsets.fromLTRB(19, 24, 19, 24),
                child: Container(
                    width: 337,
                    height: 96,
                    //constraints: const BoxConstraints(maxHeight: 96),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(168, 199, 183, 1)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Column(children: [
                      ElevatedButton(
                          onPressed: () {
                            if (_hair_change) {
                              _hair_change = !_hair_change;
                              _continue = !_continue;
                            } else {
                              _hair_change = !_hair_change;
                              _no_hair_change = false;
                              _continue = true;
                            }
                            setState(() {});
                          },
                          style: buttonStyleType(true),
                          child: Row(children: [
                            const Text(
                              'Yes',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Montserrat',
                                  fontSize: 10),
                            ),
                            Spacer(),
                            Icon(Icons.check,
                                color: _hair_change
                                    ? Colors.black
                                    : Colors.transparent)
                          ])),
                      ElevatedButton(
                          onPressed: () {
                            if (_no_hair_change) {
                              _no_hair_change = !_no_hair_change;
                              _continue = !_continue;
                            } else {
                              _no_hair_change = !_no_hair_change;
                              _hair_change = false;
                              _continue = true;
                            }
                            setState(() {});
                          },
                          style: buttonStyleType(true),
                          child: Row(children: [
                            const Text(
                              'No',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontFamily: 'Montserrat',
                                  fontSize: 10),
                            ),
                            Spacer(),
                            Icon(Icons.check,
                                color: _no_hair_change
                                    ? Colors.black
                                    : Colors.transparent)
                          ]))
                    ]))),
            Padding(
                padding: EdgeInsets.only(top: 40),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (_continue) {
                        if (_hair_change) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ColorHairOptionScreen()));
                          //UploadPictureScreen2()));
                        } else if (_no_hair_change) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectionScreen()));
                        }
                      }
                    });
                  },
                  style: continueButton(_continue),
                  child: const Text(
                    'continue',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Montserrat',
                      fontSize: 10,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  } // widget
} // class
