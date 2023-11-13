import 'package:flutter/material.dart';
import 'package:senior_project/utils/buttons.dart';
import 'package:senior_project/utils/templates.dart';
import 'package:senior_project/screens/result_screen.dart';
import '../utils/model.dart';

Model model = Model();

class GalleryScreen extends StatefulWidget {
  final String length;
  const GalleryScreen(this.length, {Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState(length);
}

class _GalleryScreenState extends State<GalleryScreen> {
  String imageChoice = '';
  List<bool> isSelected = [false, false, false, false];
  String length = '';
  bool _continue = false;

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
            GridView.count(
              padding: EdgeInsets.only(left: 20, right: 20),
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              shrinkWrap: true,
              children: List.generate(isSelected.length, (i) {
                return ImageButton(
                  width: 125,
                  height: 128,
                  image: 'assets/images/$length/${length}_${i + 1}.png',
                  onTap: () {
                    setState(() => {
                          isSelected[i] = !isSelected[i],
                          _continue = isSelected[i],
                          for (int j = 0; j < 4; j++)
                            {
                              if (j != i) {isSelected[j] = false}
                            },
                          imageChoice =
                              'assets/images/$length/${length}_${i + 1}.png'
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

                  try {
                    String image1 =
                        // "https://firebasestorage.googleapis.com/v0/b/trimming-trends.appspot.com/o/gallery_pictures%2Flong%2Flong_0.png?alt=media&token=c0e1dd69-9eb7-4afd-a301-23a0857b5486";
                        "https://firebasestorage.googleapis.com/v0/b/trimming-trends-c1485.appspot.com/o/man_1.png?alt=media&token=48d6f110-4a43-4630-9830-3101fa772c58";
                    String image2 =
                        // "https://firebasestorage.googleapis.com/v0/b/trimming-trends.appspot.com/o/gallery_pictures%2Flong%2Flong_3.png?alt=media&token=53e804a4-bad8-4387-a5e5-22621b959876";
                        "https://firebasestorage.googleapis.com/v0/b/trimming-trends-c1485.appspot.com/o/man_2.png?alt=media&token=de06f794-251a-4dca-84b8-09fe0cb565e7";

                    //create requests to model
                    await model.http_post_request(image1, image2);
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
