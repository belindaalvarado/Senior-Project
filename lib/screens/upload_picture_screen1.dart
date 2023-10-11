import 'package:flutter/material.dart';
import 'package:senior_project/screens/selection_screen.dart';
import 'package:whatsapp_camera/whatsapp_camera.dart';
import 'dart:io';

class UploadPictureScreen1 extends StatefulWidget {
  const UploadPictureScreen1({Key? key}) : super(key: key);

  @override
  _UploadPictureScreen1State createState() => _UploadPictureScreen1State();
}

class _UploadPictureScreen1State extends State<UploadPictureScreen1> {
  final files = ValueNotifier(<File>[]);
  bool _continue = false;

  @override
  void initState() {
    files.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    files.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Column(children: [
        const Padding(
            padding: EdgeInsets.only(top: 100),
            child: Align(
                // alignment: Alignment.bottomCenter,
                child: Text(
              'Upload a picture of yourself.',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 15,
              ),
            ))),

        //display the picture
        Expanded(
          child: ValueListenableBuilder<List<File>>(
            valueListenable: files,
            builder: (context, value, child) {
              if (value.isEmpty) {
                return Center(child: Image.asset('assets/empty.jpg'));
              }

              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  //download the image to local storage

                  return Image.file(
                    value[index],
                    //resize the image to fit the screen
                    width: 300,
                    height: 400,
                    fit: BoxFit.contain,
                  );
                },
              );
            },
          ),
        ),

        //buttons to take picture and button to confirm picture
        Padding(
            padding: EdgeInsets.only(bottom: 70.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Color.fromRGBO(168, 199, 183, 1),
                  child: const Icon(Icons.camera_alt),
                  onPressed: () async {
                    List<File>? res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WhatsappCamera(),
                      ),
                    );
                    if (res != null) {
                      files.value = res;
                      _continue = !_continue;
                    }
                  },
                ),
                FloatingActionButton(
                  elevation: 0,
                  backgroundColor: _continue == true ? Color.fromRGBO(168, 199, 183, 1) : Color.fromRGBO(217, 217, 217, 1),
                  child: const Icon(
                    Icons.check_circle_outline,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (_continue) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectionScreen()));
                    }
                  },
                )
              ],
            ))
      ]),
    );
  }
}
