import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class GalleryScreen extends StatefulWidget {
  final String length;
  const GalleryScreen(this.length, {Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String imageChoice = '';
  bool isImageSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 100, bottom: 20),
          child: Text(
            'Choose a hairstyle',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 15,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 125,
                height: 128,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isImageSelected = !isImageSelected;
                      imageChoice = '/short/short_1';
                    });
                  },
                  child: isImageSelected == true
                      ? Stack(children: <Widget>[
                          Container(
                            // margin: EdgeInsets.only(top: 10),
                            child: Image.asset(
                              'assets/images/short/short_1.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/icons/circle_check_mark.png',
                              // fit: BoxFit.contain,
                            ),
                          )
                        ])
                      : Container(
                          // margin: EdgeInsets.only(top: 10),
                          child: Image.asset(
                            'assets/images/short/short_1.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                )),
            Container(
              width: 125,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(0),
              ),
              child: IconButton(
                icon: Image.asset(
                  'assets/images/short/short_2.png',
                  fit: BoxFit.contain,
                ),
                onPressed: () {
                  imageChoice = '/short/short_2';
                },
              ),
            )
          ],
        ),
        Row(),
        Row(),
        Padding(
          padding: EdgeInsets.only(top: 100),
          child: ElevatedButton(
            child: Text(
              'continue',
              style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
            ),
            onPressed: () {

              // Navigator.push(context, MaterialPageRoute(builder: (context) => GeneratingScreen()));

            },
          ),
        )
      ],
    ));
  }
}
