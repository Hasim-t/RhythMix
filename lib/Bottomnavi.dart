import 'package:flutter/material.dart';
import 'package:rhythmix/Home.dart';
import 'package:rhythmix/account.dart';
import 'package:rhythmix/library.dart';
import 'package:rhythmix/search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List _pages=[
    Home(),
    Search(),
    Library(),
    Account()
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(232, 5, 122, 247),
              Color.fromARGB(255, 255, 255, 255)
            ])),
        child: Scaffold(
          body:_pages[_selectedIndex],
          backgroundColor: Colors.transparent,
          bottomNavigationBar: BottomNavigationBar(
             unselectedItemColor: Colors.black, 
              selectedItemColor: Color.fromARGB(232, 5, 122, 247),
              
              
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.queue_music), label: ''),
                BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: ''),
                
              ]),
        ));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
