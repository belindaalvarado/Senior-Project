import 'package:senior_project/screens/choices_screen.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/screens/upload_picture_screen2.dart';
import 'dart:io';
import 'package:senior_project/utils/buttons.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  final files = ValueNotifier(<File>[]);
  bool _upload_pic = false;
  bool _choose_pic = false;
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
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color.fromRGBO(168, 199, 183, 1),
                )),
          ),
          backgroundColor: Color(0xffFFFFFF),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Align(
                      child: Text(
                    'What would you like to do?',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 15,
                    ),
                  ))),
              Padding(
                  padding: const EdgeInsets.fromLTRB(19, 24, 19, 24),
                  child: Container(
                    width: 337,
                    height: 96,
                    constraints: const BoxConstraints(maxHeight: 96),
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 2,
                            color: const Color.fromRGBO(168, 199, 183, 1)),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: Column(children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_upload_pic) {
                            _upload_pic = !_upload_pic;
                            _continue = !_continue;
                          } else {
                            _upload_pic = !_upload_pic;
                            _choose_pic = false;
                            _continue = true;
                          }
                          setState(() {});
                        },
                        style: buttonStyleType(true),
                        child: Row(children: [
                          const Text(
                            'Upload a picture',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Montserrat',
                                fontSize: 10),
                          ),
                          Spacer(),
                          Icon(Icons.check,
                              color: _upload_pic
                                  ? Colors.black
                                  : Colors.transparent),
                        ]),
                      ),
                      const Divider(
                        height: 1,
                        thickness: 2,
                        color: Color.fromRGBO(168, 199, 183, 1),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_choose_pic) {
                            _choose_pic = !_choose_pic;
                            _continue = !_continue;
                          } 
                          else {
                            _choose_pic = !_choose_pic;
                            _upload_pic = false;
                            _continue = true;
                          }
                          setState(() {});
                        },
                        style: buttonStyleType(true),
                        child: Row(children: [
                          const Text(
                            'Choose a picture',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat',
                              fontSize: 10,
                            ),
                          ),
                          Spacer(),
                          Icon(Icons.check,
                              color: _choose_pic
                                  ? Colors.black
                                  : Colors.transparent),
                        ]),
                      ),
                    ]),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_continue) {
                          if (_upload_pic) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UploadPictureScreen2()));
                          } else if (_choose_pic) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChoicesScreen()));
                          }
                        }
                      });
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
                  ))
            ],
          )),
    );
  }
}
