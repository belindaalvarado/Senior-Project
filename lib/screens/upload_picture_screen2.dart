import 'package:senior_project/screens/result_screen.dart';
//import 'package:senior_project/screens/hair_color_option.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_camera/whatsapp_camera.dart';
import 'dart:io';

class UploadPictureScreen2 extends StatefulWidget {
  const UploadPictureScreen2({Key? key}) : super(key: key);

  @override
  _UploadPictureScreen2State createState() => _UploadPictureScreen2State();
}

class _UploadPictureScreen2State extends State<UploadPictureScreen2> {
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
                      backgroundColor: _continue == true
                          ? Color.fromRGBO(168, 199, 183, 1)
                          : Color.fromRGBO(217, 217, 217, 1),
                      child: const Icon(
                        Icons.check_circle_outline,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (_) {
                              return const Dialog(
                                  backgroundColor: Colors.white,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20),
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
                        Future.delayed(Duration(seconds: 2), () {
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  //builder: (context) => ColorHairScreen()));
                          builder: (context) => ResultScreen()));
                        });
                      },
                    )
                  ],
                )),
          ]),
        ));
  }
}
