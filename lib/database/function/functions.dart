
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle songstext() {
  return GoogleFonts.archivo(
    textStyle: TextStyle(
      fontSize: 23,
      color: Colors.white 

    )
  );
}
TextStyle songstextbalck() {
  return GoogleFonts.archivo(
    textStyle: TextStyle(
      fontSize: 23,
      color:  Color.fromARGB(255, 0, 0, 0) 

    )
  );
}
  void bottomsheet(BuildContext context) {
    
   double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
 showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return Container(
                                          height:screenHeight*0.5,
                                          width: screenWidth,
                                          color: Colors.black,
                                        child: Column(
                                          children: [
                                            Container(
                                              height: screenHeight*0.08,
                                              width: screenWidth,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.add,size: 50,color: Colors.white,),
                                                  SizedBox(
                                                  width:  screenWidth*0.09,
                                                  ),
                                                  Text('Add Playlist',
                                                style: songstext(),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                            Container(
                                              height: screenHeight*0.08,
                                              width: screenWidth,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.add,size: 50,color: Colors.white,),
                                                  SizedBox(
                                                  width:  screenWidth*0.09,
                                                  ),
                                                  Text('Add Playlist',
                                                style: songstext(),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                            Container(
                                              height: screenHeight*0.08,
                                              width: screenWidth,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.add,size: 50,color: Colors.white,),
                                                  SizedBox(
                                                  width:  screenWidth*0.09,
                                                  ),
                                                  Text('Add Playlist',
                                                style: songstext(),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Divider(),Container(
                                              height: screenHeight*0.08,
                                              width: screenWidth,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.add,size: 50,color: Colors.white,),
                                                  SizedBox(
                                                  width:  screenWidth*0.09,
                                                  ),
                                                  Text('Add Playlist',
                                                style: songstext(),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Divider(),Container(
                                              height: screenHeight*0.08,
                                              width: screenWidth,
                                              child: Row(
                                                children: [
                                                  Icon(Icons.add,size: 50,color: Colors.white,),
                                                  SizedBox(
                                                  width:  screenWidth*0.09,
                                                  ),
                                                  Text('Add Playlist',
                                                style: songstext(),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                          ],
                                        ),
                                      
                                        );
                                      });
    }
  

   
  
