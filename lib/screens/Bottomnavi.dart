import 'package:flutter/material.dart';
import 'package:rhythmix/screens/Home.dart';
import 'package:rhythmix/screens/account.dart';
import 'package:rhythmix/screens/library.dart';
import 'package:rhythmix/screens/search.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List _pages = [Home(), Search(), Library(), Account()];
  @override
  Widget build(BuildContext context) {
    //  double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
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

          extendBody: true,
          body: _pages[_selectedIndex],
          backgroundColor: Colors.transparent,
          bottomNavigationBar: Container(
            
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Padding(
                //   padding:  EdgeInsets.only(bottom:screenHeight*0.07),
                   
                //   child: Container(
                //     height: screenHeight*0.09,
                //     width:screenWidth ,
                //    decoration: BoxDecoration(
                 
                //     color: Colors.blue[200],
                   
                //    ),
                //     child:ListTile(
                //       leading: Icon(Icons.abc),
                //       title: TextScroll('song'),
                //       subtitle: TextScroll('artist'),
                //       trailing: Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: [
                //         IconButton(onPressed: (){}, icon: Icon(Icons.skip_previous)),
                //         IconButton(onPressed: (){}, icon: Icon(Icons.pause_outlined)),
                //         IconButton(onPressed: (){}, icon: Icon(Icons.skip_next)),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                BottomNavigationBar(
                  
                  backgroundColor: Colors.transparent,
                    unselectedItemColor: Colors.black,
                    selectedItemColor: Color.fromARGB(232, 5, 122, 247),
                    currentIndex: _selectedIndex,
                    onTap: _onItemTapped,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.search), label: ''),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.queue_music), label: ''),
                      BottomNavigationBarItem(
                          icon: Icon(Icons.person_outlined), label: ''),
                    ]),
              ],
            ),
          ),
        ));
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
