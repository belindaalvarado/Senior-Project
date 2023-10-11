import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:senior_project/utils/buttons.dart';

class GalleryScreen extends StatefulWidget {
  final String length;
  const GalleryScreen(this.length, {Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String imageChoice = '';
  bool isImageSelected = false;

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
        body: Column(
          children: [
            const Padding(
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
                style: continueButton(isImageSelected),
                child: const Text(
                  'continue',
                  style: TextStyle(fontSize: 10, color: Colors.black, fontFamily: 'Montserrat'),
                ),
                onPressed: () async {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => GeneratingScreen()));
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (_) {
                        return const Dialog(
                            backgroundColor: Colors.white,
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // The loading indicator
                                    CircularProgressIndicator(),
                                    SizedBox(height: 15),
                                    // Some text
                                    Text('Loading...',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat')),
                                  ],
                                )));
                      });
                  // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
                  await Future.delayed(const Duration(seconds: 3));

                  // Close the dialog programmatically
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ));
  }
}
