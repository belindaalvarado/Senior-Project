import 'package:flutter/material.dart';
import 'dart:async';


class BegginingScreen extends StatefulWidget {

  @override
  _BegginingScreenState createState() => _BegginingScreenState();
}

class _BegginingScreenState extends State<BegginingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
    width: 375,
    height: 670,
    padding: const EdgeInsets.only(
        top: 223,
        left: 62,
        right: 62,
        bottom: 266,
    ),
    clipBehavior: Clip.antiAlias,
    decoration: const BoxDecoration(color: Colors.white),
    child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            const SizedBox(
                width: 251,
                height: 84,
                child: Text(
                    'Let’s get started',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontFamily: 'Lobster Two',
                        fontWeight: FontWeight.w400,
                        height: 0,
                    ),
                ),
            ),
            const SizedBox(height: 43),
            Container(
                width: 190,
                height: 54,
                child: Stack(
                    children: [
                        Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                                width: 190,
                                height: 54,
                                decoration: ShapeDecoration(
                                    color: Color(0xFFA8C6B6),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                    ),
                                ),
                            ),
                        ),
                        const Positioned(
                            left: 32,
                            top: 19,
                            child: SizedBox(
                                width: 126,
                                height: 15,
                                child: Text(
                                    'continue',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                    ),
                                ),
                            ),
                        ),
                    ],
                ),
            ),
        ],
    ),
),
    );
  }
}

