import 'package:senior_project/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp_camera/whatsapp_camera.dart';
import 'dart:io';



class UploadPictureScreen2 extends StatefulWidget {
  const UploadPictureScreen2({Key? key}) : super(key: key);

  @override
  _UploadPictureScreen2State createState() => _UploadPictureScreen2State();
}

class _UploadPictureScreen2State extends State<UploadPictureScreen2>{

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

              children: [

                const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Align(
                    // alignment: Alignment(0, 10),
                    child: Text(
                      'Upload a picture of a hairstyle you like',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15,
                      ),
                    )
                  )
                ),

              //display the picture
                Expanded(
                child: ValueListenableBuilder<List<File>>(
                  valueListenable: files,
                  builder: (context, value, child){

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

              //button to take picture
              FloatingActionButton(
                  child: const Icon(Icons.camera),
                  onPressed: () async {
                    List<File>? res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WhatsappCamera(),
                      ),
                    );
                  if (res != null) files.value = res;
                  },
                ),

              //buttons to navigate screens
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  Align(
                  alignment: Alignment.bottomLeft,
                  child:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Icon(Icons.arrow_back),    
                        // style:          
                      ),
                    )
                  ),

                Align(
                  alignment: Alignment.bottomRight,
                  child:
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen()));
                        },
                        child: const Icon(Icons.arrow_forward),    
                        // style:          
                      ),
                    )
                  ),

                ],
              )
              
            ]
        ),
    ));
  }



}