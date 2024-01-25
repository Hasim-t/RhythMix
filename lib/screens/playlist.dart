import 'package:flutter/material.dart';

class OtherPage extends StatelessWidget {
  final String itemName;

  const OtherPage({Key? key, required this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
      ),
      body: Center(
        child: Text(
          'This is the $itemName page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
