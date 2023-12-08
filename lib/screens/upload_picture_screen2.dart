import 'package:senior_project/utils/templates.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:senior_project/screens/result_screen.dart';
import '../utils/model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../utils/globals.dart' as globals;

//make a reference to the model
Model model = Model();

class UploadPictureScreen2 extends StatefulWidget {
  const UploadPictureScreen2({Key? key}) : super(key: key);

  @override
  _UploadPictureScreen2State createState() => _UploadPictureScreen2State();
}

class _UploadPictureScreen2State extends State<UploadPictureScreen2> {
  // array to ftore picture files
  final pictures = <File>[];
  StorageService service = StorageService();
  // continue button status
  bool _continue = false;
  Future<String>? filen;

  Future<String> urlForDatabase1 = Future<String>.value("");
  Future<String> urlForDatabase2 = Future<String>.value("");
  Future<String> urlForDatabase3 = Future<String>.value("");

  FirebaseStorage storage = FirebaseStorage.instance;

  String p = "";
  String fileName = "";

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
            backgroundColor: Color(0xffFFFFFF),
            body: Column(children: [
              const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Align(
                      child: Text(
                    'Upload a picture of a style you like.',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                    ),
                  ))),

//display the picture
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 40),
                      child: Align(
                          child: Container(
                              width: 300,
                              height: 400,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: pictures.length == 0
                                  ? Image.asset("assets/empty.jpg")
                                  : Image.file(
                                      pictures[pictures.length - 1]))))),

//buttons to take picture and button to confirm picture
              Padding(
                  padding: EdgeInsets.only(bottom: 70.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
  //button to take/re-take the photo from user
                        FloatingActionButton(
                            elevation: 0,
                            backgroundColor: Color.fromRGBO(168, 199, 183, 1),
                            child: const Icon(Icons.camera_alt),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CameraCamera(
                                            onFile: (file) {
                                              pictures.add(file);
                                              Navigator.pop(context);
                                              setState(() {
                                                if (pictures.length != 0) {
                                                  _continue = true;
                                                }
                                              });
                                            },
                                          )));
                            }),
  //button to confirm the photo uploaded by the user
                        FloatingActionButton(
                            elevation: 0,
                            backgroundColor: _continue == true
                                ? Color.fromRGBO(168, 199, 183, 1)
                                : Color.fromRGBO(217, 217, 217, 1),
                            child: const Icon(
                              Icons.check_circle_outline,
                              color: Colors.black,
                            ),
// if the user confirms the uploaded photo, upload it to firebase
                            onPressed: () async {
                              if (_continue) {
                                p = pictures[pictures.length - 1].path;
                                filen = service.uploadFile(
                                    p, fileName, "user_pic_2");
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (_) {
                                    return Dialog(
                                      backgroundColor: Colors.white,
                                      child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircularProgressIndicator(),
                                            SizedBox(height: 15),
                                            Text('Loading...',
                                                style: TextStyle(
                                                    fontFamily: 'Montserrat')),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );

// Create references to the desired photos (user picture, desired hair style, desired hair color) in firebase
                                Reference ref1 = storage.ref('user_pic_1.jpg');
                                Reference ref2 = storage.ref('user_pic_2.jpg');
                                Reference ref3 = storage.ref(globals.hairColor);

// Get the URL locations for the firebase references to feed into the model                                
                                urlForDatabase1 = getImageURL(ref1);
                                urlForDatabase2 = getImageURL(ref2);
                                urlForDatabase3 = getImageURL(ref3);

                                try {
                                  String image1 = await urlForDatabase1;
                                  String image2 = await urlForDatabase2;
                                  String image3 = await urlForDatabase3;

                                  //create requests to model
                                  await model.http_post_request(
                                      image1, image2, image3);
                                  await model.current_status();
                                  await model.result();

                                  // Close the loading dialog
                                  Navigator.of(context).pop();

                                  // Navigate to the next page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ResultScreen()),
                                  );
                                } catch (error) { 
                                  // catch errors
                                  print("Error: $error");

                                  // Close the loading dialog
                                  Navigator.of(context).pop();
                                }
                              }
                            })
                      ]))
            ])));
  }
}
