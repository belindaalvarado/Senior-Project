import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

class ChoicesScreen extends StatefulWidget {
  const ChoicesScreen({Key? key}) : super(key: key);

  @override
  _ChoicesScreenState createState() => _ChoicesScreenState();
}

class _ChoicesScreenState extends State<ChoicesScreen>{

  @override
  Widget build(BuildContext context){

    return const Scaffold (
      body: Column(
        children:[
          Text('Choices Screen'),
        ]
      )
    );
  }
}
