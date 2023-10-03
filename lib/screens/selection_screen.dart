import 'package:senior_project/screens/choices_screen.dart';
import 'package:flutter/material.dart';
import 'package:senior_project/screens/upload_picture_screen2.dart';
import 'dart:io';



class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen>{

  final files = ValueNotifier(<File>[]);

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
      onWillPop: () async{
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: 
         Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Align(
                    // alignment: Alignment(0, 10),
                    child: Text(
                      'What would you like to do?',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                      ),
                    )
                  )
                ),

                //add 2 buttons for upload picture and select picture
                Align(
                  alignment: Alignment.center,
                  child:
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            side: BorderSide(color: Color.fromRGBO(140, 201, 170, 0.475), width: 3),
                          ) ,
                          onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => UploadPictureScreen2()));
                          },
                          child: const Text('Upload a picture', style: TextStyle(fontFamily:'Montserrat', color: Colors.black)),
                        ),


                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                            side: BorderSide(color: Color.fromRGBO(140, 201, 170, 0.475), width: 3),
                          ) ,
                          onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ChoicesScreen()));
                          },
                          child: const Text('Choose from app gallery', style: TextStyle(fontFamily:'Montserrat', color: Colors.black)),
                        ),
                    ],
                    )
                
                ),
            ]
        ),
    ));
  }



}