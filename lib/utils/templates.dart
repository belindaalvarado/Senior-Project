import 'package:flutter/material.dart';

//make stateful widget called ImageButton

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
