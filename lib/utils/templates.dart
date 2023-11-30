import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

//make stateful widget called ImageButton

class StorageService {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadFile(String filePath, String fileName, String picName) async {
    File uploadedimage = File(filePath);

    //convert uploadedimage to PNG format
    //img.Image? image = img.decodeImage(uploadedimage.readAsBytesSync());
    //img.Image? resizedImage = img.copyResize(image!);
    //uploadedimage = File(filePath)
     // ..writeAsBytesSync(img.encodePng(image!));

    //rename uploadedimage
    fileName = picName + ".jpg";

    try {
      await firebaseStorage.ref(fileName).putFile(uploadedimage).then(
        (p0) {
          print("File Uploaded" + fileName);

        },
      );
    } on FirebaseException catch (e) {
      print(e);
    }

    return fileName;
  }

}

  Future<String> getImageURL(Reference file) async {
  final String downloadURL = await file.getDownloadURL();
  return downloadURL;
}

class ImageButton extends StatefulWidget {
  final String image;
  final double width;
  final double height;
  final Function onTap;
  final bool isSelected;

  ImageButton({
    required this.image,
    required this.width,
    required this.height,
    required this.onTap,
    required this.isSelected,
  });

  @override
  _ImageButtonState createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: InkWell(
        onTap: () {
          widget.onTap();
        },
        child: widget.isSelected == true
            ? Stack(
              children: <Widget>[
                Container(
                  child: Image.asset(
                    widget.image,
                    fit: BoxFit.contain,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                  'assets/icons/circle_check_mark.png',
                  ),
                ),
              ])
            : Container(
                child: Image.asset(
                widget.image,
                fit: BoxFit.contain,
            ),
          )));
                
  }
}
