import 'package:flutter/material.dart';
import 'package:senior_project/utils/buttons.dart';
import 'package:senior_project/utils/templates.dart';
import 'package:senior_project/screens/result_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../utils/globals.dart' as globals;
import './upload_picture_screen1.dart';

class GalleryScreen extends StatefulWidget {
  final String length;
  const GalleryScreen(this.length, {Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState(length);
}

class _GalleryScreenState extends State<GalleryScreen> {
  String imageChoice = '';
  List<bool> isSelected = [false, false, false, false, false, false];
  String length = '';
  bool _continue = false;

  Future<String> urlForDatabase1 = Future<String>.value("");
  Future<String> urlForDatabase2 = Future<String>.value("");
  Future<String> urlForDatabase3 = Future<String>.value("");

  FirebaseStorage storage = FirebaseStorage.instance;

  _GalleryScreenState(this.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color.fromRGBO(168, 199, 183, 1),
              )),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30, bottom: 20),
              child: Text(
                'Choose a hairstyle',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            GridView.count(
              padding: EdgeInsets.only(left: 10, right: 10),
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              shrinkWrap: true,
              children: List.generate(isSelected.length, (i) {
                return ImageButton(
                  width: 10,
                  height: 10,
                  image: 'assets/images/$length/${length}_${i}.png',
                  onTap: () {
                    setState(() => {
                          isSelected[i] = !isSelected[i],
                          _continue = isSelected[i],
                          for (int j = 0; j < isSelected.length; j++)
                            {
                              if (j != i) {isSelected[j] = false}
                            },
                          imageChoice =
                              '/gallery_pictures/$length/${length}_${i}.jpg'
                        });
                  },
                  isSelected: isSelected[i],
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: ElevatedButton(
                style: continueButton(_continue),
                child: const Text(
                  'continue',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontFamily: 'Montserrat',
                  ),
                ),
                onPressed: () async {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 15),
                              Text('Loading...',
                                  style: TextStyle(fontFamily: 'Montserrat')),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                  Reference ref1 = storage.ref('user_pic_1.jpg');
                  Reference ref2 = storage.ref(imageChoice);
                  Reference ref3 = storage.ref(globals.hairColor);

                  print("Ref1 PATH: ${ref1.fullPath}");
                  print("Ref2 PATH: ${ref2.fullPath}");
                  print("Ref3 PATH: ${ref3.fullPath}");

                  urlForDatabase1 = getImageURL(ref1);
                  urlForDatabase2 = getImageURL(ref2);
                  urlForDatabase3 = getImageURL(ref3);

                  print("url1 PATH: ${urlForDatabase1}");
                  print("url2 PATH: ${urlForDatabase2}");
                  print("url3 PATH: ${urlForDatabase3}");

                  try {
                    String image1 = await urlForDatabase1;
                    String image2 = await urlForDatabase2;
                    String image3 = await urlForDatabase3;

                    //create requests to model
                    await model.http_post_request(image1, image2, image3);
                    await model.current_status();
                    await model.result();

                    // Close the loading dialog
                    Navigator.of(context).pop();

                    // Navigate to the next page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ResultScreen()),
                    );
                  } catch (error) {
                    // catch errors
                    print("Error: $error");
                    // Close the loading dialog
                    Navigator.of(context).pop();
                  }
                },
              ),
            )
          ],
        ));
  }
}
