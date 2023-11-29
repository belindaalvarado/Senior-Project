//import 'dart:html';
//import 'package:senior_project/screens/upload_picture_screen2.dart';
import 'package:senior_project/screens/selection_screen.dart';
//import 'package:senior_project/screens/hair_color_choices.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/utils/templates.dart';
import 'package:senior_project/utils/buttons.dart';
import '../utils/globals.dart' as globals; 

class ColorHairOptionScreen extends StatefulWidget {
  const ColorHairOptionScreen({Key? key}) : super(key: key);

  @override
  _ColorHairOptionScreenState createState() => _ColorHairOptionScreenState();
}

class _ColorHairOptionScreenState extends State<ColorHairOptionScreen> {
  String length = "";
  String imageChoice = "";
  bool _continue = false;
  List<bool> isSelected = [false, false, false, false];
  //_GalleryScreenState(this.length);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Scaffold(
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
                    'Choose a new hair color.',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                    ),
                  ))),
              GridView.count(
                padding: EdgeInsets.only(left: 20, right: 20),
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                shrinkWrap: true,
                children: List.generate(isSelected.length, (i) {
                  return ImageButton(
                    width: 125,
                    height: 128,
                    image: 'assets/images/color/color_${i + 1}.jpg',
                    //image: 'assets/images/$length/${length}_${i + 1}.png',
                    onTap: () {
                      setState(() => {
                            isSelected[i] = !isSelected[i],
                            _continue = isSelected[i],
                            for (int j = 0; j < 4; j++)
                              {
                                if (j != i) {isSelected[j] = false}
                              },
                            //imageChoice =
                            globals.hairColor = '/color/color_${i + 1}.png'
                          });
                    },
                    isSelected: isSelected[i],
                  );
                }),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: ElevatedButton(
                    style: continueButton(_continue),
                    child: const Text(
                      'continue',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.black,
                          fontFamily: 'Montserrat'),
                    ),
                    onPressed: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SelectionScreen()));
                      });
                    }),
              )
            ])));
  }
}
