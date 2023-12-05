import 'package:senior_project/screens/hair_color_option.dart';
import 'package:senior_project/utils/templates.dart';
import 'package:flutter/material.dart';
//import 'package:senior_project/screens/selection_screen.dart';
//import 'package:whatsapp_camera/whatsapp_camera.dart';
import 'dart:io';
import 'package:camera_camera/camera_camera.dart';

class UploadPictureScreen1 extends StatefulWidget {
  const UploadPictureScreen1({Key? key}) : super(key: key);

  @override
  _UploadPictureScreen1State createState() => _UploadPictureScreen1State();
}

class _UploadPictureScreen1State extends State<UploadPictureScreen1> {
  //final files = ValueNotifier(<File>[]);
  final pictures = <File>[];
  StorageService service = StorageService();
  bool _continue = false;
  Future<String>? filen;

  String p = "";
  String fileName = "";

  //@override
  // void initState() {
  //   files.addListener(() => setState(() {}));
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   files.dispose();
  //   super.dispose();
  // }

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
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 40),
            child: Align(
                // alignment: Alignment.bottomCenter,
                child: Container(
                    width: 300,
                    height: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)),
                    child: pictures.length == 0
                        ? Image.asset("assets/empty.jpg")
                        : Image.file(pictures[0]) 
                        ))),
          //buttons to take picture and button to confirm picture
          Padding(
            padding: EdgeInsets.only(bottom: 70.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: (){
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
                    });},
                    )));
                    },

                    child: Icon(Icons.camera_alt),
                    backgroundColor: Color.fromRGBO(168, 199, 183, 1),
                    elevation: 0,
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
                        if (_continue) {
                          p = pictures[0].path;
                          filen = service.uploadFile(p, fileName, "user_pic_1");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ColorHairScreen()));
                        }

//         //display the picture
//         Expanded(
//           //child: ValueListenableBuilder<List<File>>(
//             //valueListenable: files,
//             //builder: (context, value, child) {
//             //  if (value.isEmpty) {
//              //   return Center(child: Image.asset('assets/empty.jpg'));
//             //  }

//               return ListView.builder(
//                 itemCount: value.length,
//                 itemBuilder: (context, index) {
//                   return Image.file(
//                     value[index],
//                     //resize the image to fit the screen
//                     width: 300,
//                     height: 400,
//                     fit: BoxFit.contain,
//                   );
//                 },
//               );
//             },
//           ),
//         ),

//         //buttons to take picture and button to confirm picture
//         Padding(
//             padding: EdgeInsets.only(bottom: 70.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 FloatingActionButton(
//                   onPressed: () async {
//                     List<File>? res = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const WhatsappCamera(),
//                       ),
//                     );
//                     if (res != null) {
//                       files.value = res;
//                     }
//                     if (res == null) {
//                       print("Error: No file selected");
//                     } else {
//                       String path = res.single.path;
//                       p = path;
//                       _continue = true;
//                     }
//                   },
//                   child: Icon(Icons.camera_alt),
//                   backgroundColor: Color.fromRGBO(168, 199, 183, 1),
//                   elevation: 0,
//                 ),
//                 FloatingActionButton(
//                   elevation: 0,
//                   backgroundColor: _continue == true
//                       ? Color.fromRGBO(168, 199, 183, 1)
//                       : Color.fromRGBO(217, 217, 217, 1),
//                   child: const Icon(
//                     Icons.check_circle_outline,
//                     color: Colors.black,
//                   ),
//                   onPressed: () {
//                     if (_continue) {
//                       filen = service.uploadFile(p, fileName, "user_pic_1");
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => ColorHairScreen()));
//                     }
//                   },
//                 )
//               ],
//             ))
                      })
                ]),
          )
        ]));
  }
}
