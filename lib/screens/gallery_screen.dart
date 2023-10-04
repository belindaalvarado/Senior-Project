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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [

       Padding( 
        padding: EdgeInsets.only(top: 100),
        child: Text(
          'Choose a hairstyle',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 15,
          ),
        ),),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: 125,
                height: 128,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/short/short_1.png',
                    fit: BoxFit.contain,
                  ),
                  onPressed: () {
                    print('selected');
                  },
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
          child: FloatingActionButton(
            child: Text('Next'),
            onPressed: () {
              
            },
          ),
        )
      ],
    ));
  }
}
