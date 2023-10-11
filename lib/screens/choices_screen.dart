import 'package:flutter/material.dart';
import 'package:senior_project/screens/gallery_screen.dart';

class ChoicesScreen extends StatefulWidget {
  const ChoicesScreen({Key? key}) : super(key: key);

  @override
  _ChoicesScreenState createState() => _ChoicesScreenState();
}

class _ChoicesScreenState extends State<ChoicesScreen> {
  List<bool> hairLength = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
            alignment: Alignment.center,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              //add 3 buttons, for short, medium, or long hair

              //short hair button
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      
                      hairLength[0] = !hairLength[0];
                      // hairLength[0] = true;
                      hairLength[1] = false;
                      hairLength[2] = false;
                    });
                  },
                  child: Text(
                    'short',
                    style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hairLength[0] == true
                        ? Color.fromRGBO(168, 199, 183, 1)
                        : Colors.white,
                    fixedSize: Size(120, 120),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              //medium hair button
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      hairLength[0] = false;
                      hairLength[1] = !hairLength[1];
                      hairLength[2] = false;
                    });
                  },
                  child: Text(
                    'med',
                    style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hairLength[1] == true
                        ? Color.fromRGBO(168, 199, 183, 1)
                        : Colors.white,
                    fixedSize: Size(120, 120),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              //long hair button
              Padding(
                padding: EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      hairLength[0] = false;
                      hairLength[1] = false;
                      hairLength[2] = !hairLength[2];
                    });
                  },
                  child: Text(
                    'long',
                    style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: hairLength[2] == true
                        ? Color.fromRGBO(168, 199, 183, 1)
                        : Colors.white,
                    fixedSize: Size(120, 120),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
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
