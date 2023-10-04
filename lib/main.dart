import 'package:flutter/material.dart';
import 'package:senior_project/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trimming Trends',
      theme: ThemeData(
        fontFamily: 'Lobster Two',
        // This is the theme of your application.
        //
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(168, 199, 183, 1)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}


