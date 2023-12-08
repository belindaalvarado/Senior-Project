import 'package:senior_project/screens/hair_color_option.dart';
import 'package:senior_project/utils/templates.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:camera_camera/camera_camera.dart';

class UploadPictureScreen1 extends StatefulWidget {
  const UploadPictureScreen1({Key? key}) : super(key: key);

  @override
  _UploadPictureScreen1State createState() => _UploadPictureScreen1State();
}

class _UploadPictureScreen1State extends State<UploadPictureScreen1> {
  // array to ftore picture files
  final pictures = <File>[];
  StorageService service = StorageService();
  // continue button status
  bool _continue = false;
  Future<String>? filen;

  String p = "";
  String fileName = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
// Display helper text for the user.
        body: Column(children: [
          const Padding(
              padding: EdgeInsets.only(top: 100),
              child: Align(
                  child: Text(
                'Upload a picture of yourself.',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                ),
              ))),
//display the picture that the user uploads
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
                              : Image.file(pictures[pictures.length - 1]))))),
//buttons to take picture and button to confirm picture
          Padding(
            padding: EdgeInsets.only(bottom: 70.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
  //button to take/re-take a photo
                  FloatingActionButton(
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
                    },
                    child: Icon(Icons.camera_alt),
                    backgroundColor: Color.fromRGBO(168, 199, 183, 1),
                    elevation: 0,
                  ),
  //button to confirm the uploaded picture
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
                      onPressed: () {
                        if (_continue) {
                          p = pictures[pictures.length - 1].path;
                          filen = service.uploadFile(p, fileName, "user_pic_1");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ColorHairScreen()));
                        }
                      })
                ]),
          )
        ]));
  }
}
