import 'package:flutter/material.dart';
import 'package:rhythmix/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rhythmix',
      home: SplashScreen() ,
    );
  }
}
