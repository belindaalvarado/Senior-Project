import 'package:flutter/material.dart';
import 'package:senior_project/utils/buttons.dart';
import 'package:senior_project/screens/gallery_screen.dart';

class ChoicesScreen extends StatefulWidget {
  const ChoicesScreen({Key? key}) : super(key: key);

  @override
  _ChoicesScreenState createState() => _ChoicesScreenState();
}

class _ChoicesScreenState extends State<ChoicesScreen> {
  List<bool> hairLength = [false, false, false];
  bool _continue = false;

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
        body: Column(children: [
          const Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Align(
                  child: Text(
                'Choose a length.',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                ),
              ))),
          SizedBox(
            height: 20,
          ),
          Align(
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //3 buttons - short, medium, or long hair

                    //short hair button
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            hairLength[0] = !hairLength[0];
                            hairLength[1] = false;
                            hairLength[2] = false;
                            _continue = hairLength[0];
                          });
                        },
                        style: lengthButton(hairLength[0]),
                        child: const Text(
                          'short',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),

                    //medium hair button
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            hairLength[0] = false;
                            hairLength[1] = !hairLength[1];
                            hairLength[2] = false;
                            _continue = hairLength[1];
                          });
                        },
                        style: lengthButton(hairLength[1]),
                        child: const Text(
                          'med',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),

                    //long hair button
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            hairLength[0] = false;
                            hairLength[1] = false;
                            hairLength[2] = !hairLength[2];
                            _continue = hairLength[2];
                          });
                        },
                        style: lengthButton(hairLength[2]),
                        child: const Text(
                          'long',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 60,
                    ),

                    //continue button
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton(
                        onPressed: () {
                          if (hairLength[0] == true) {
                            _continue = true;
                            //short hair
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GalleryScreen('short')));
                          } else if (hairLength[1] == true) {
                            _continue = true;
                            //medium hair
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GalleryScreen('med')));
                          } else if (hairLength[2] == true) {
                            _continue = true;
                            //long hair
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        GalleryScreen('long')));
                          } else {
                            //no hair length selected
                            _continue = false;
                          }
                          setState(() {});
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
                      ),
                    ),
                  ]))
        ]));
  }
}
