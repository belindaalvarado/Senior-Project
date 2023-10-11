import 'package:flutter/material.dart';

ButtonStyle buttonStyleType(bool isTop) {
  return ButtonStyle(
      elevation: MaterialStateProperty.all<double>(0),
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minimumSize: MaterialStateProperty.all<Size>(Size.fromHeight(44)),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: isTop
                  ? BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0))
                  : BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0)))),
      foregroundColor: MaterialStateProperty.all<Color>(
          Color.fromRGBO(140, 201, 170, 0.475)));
}

// Continue button style given state
ButtonStyle continueButton(bool state) {
  return ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(Size(143, 54)),
      foregroundColor: state
          ? MaterialStateProperty.all<Color>(Color(0xFFFFFFFF))
          : MaterialStateProperty.all<Color>(Color(0xFFFFFFFF)),
      backgroundColor: state
          ? MaterialStateProperty.all<Color>(Color.fromRGBO(168, 199, 183, 1))
          : MaterialStateProperty.all<Color>(Color.fromRGBO(217, 217, 217, 1)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ));
}

ButtonStyle lengthButton(bool state) {
  return ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(Size(110, 110)),
      foregroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFFFFF)),
      backgroundColor: state
          ? MaterialStateProperty.all<Color>(Color.fromRGBO(168, 199, 183, 1))
          : MaterialStateProperty.all<Color>(Color.fromRGBO(217, 217, 217, 1)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      )));
}

// Button Style for the done button
ButtonStyle doneButton() {
  return ButtonStyle(
      fixedSize: MaterialStateProperty.all<Size>(Size(280, 46)),
      foregroundColor: MaterialStateProperty.all<Color>(Color(0xFFFFFFFF)),
      backgroundColor: MaterialStateProperty.all<Color>(
          Color.fromRGBO(140, 201, 170, 0.475)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      )));
}
