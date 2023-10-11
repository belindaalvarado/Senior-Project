import 'package:flutter/material.dart';
import 'package:senior_project/utils/buttons.dart';
import 'package:senior_project/utils/templates.dart';

class GalleryScreen extends StatefulWidget {
  final String length;
  const GalleryScreen(this.length, {Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  String imageChoice = '';
  List<bool> isSelected = [false, false, false, false];
  String length = '';
  _GalleryScreenState() {
    length = widget.length;
  }

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
        Padding(
          padding: EdgeInsets.only(top: 100, bottom: 20),
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
              image: 'assets/images/$length/${length}_$i.png',
              onTap: () {
                setState(() => {
                      isSelected[i] = !isSelected[i],
                      for (int j = 0; j < 4; j++)
                        {
                          if (j != i) {isSelected[j] = false}
                        },
                      imageChoice = 'assets/images/$length/${length}_$i.png'
                    });
              },
              isSelected: isSelected[i],
            );
          }),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: ElevatedButton(
            child: const Text(
              'continue',
              style: TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
            ),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => GeneratingScreen()));
            },
          ),
        )
      ],
    ));
  }
}
