

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/provider/songprovider.dart';
import 'package:rhythmix/splash.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context)=>songModelprovider(),
  child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rhythmix',
      home: SplashScreen(),
    );
  }
}
