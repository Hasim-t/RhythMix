import 'package:flutter/material.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({super.key});

  @override
  Widget build(BuildContext context) {
      double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new))
                ],
              ),
              SizedBox(
           height: screenHeight*0.04,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                 borderRadius: BorderRadius.circular(20) 
                ),
                height: screenHeight*0.24,
                width: screenWidth*0.6,
                child: Icon(Icons.music_note),
              ),
              SizedBox(
                height: screenHeight*0.02,
              ),
              Text('Song name',style: TextStyle(fontSize: 35),),
              SizedBox(height: screenHeight*0.01,),
              Text('artist',style: TextStyle(fontSize: 23),),
           SizedBox(
            height: screenHeight*0.2,
           ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border),iconSize: 28,),
                  IconButton(onPressed: (){}, icon: Icon(Icons.format_list_bulleted_add),iconSize: 28,),
                  
                ],
              ),
             SliderTheme(
  data: SliderThemeData(
    activeTrackColor: Colors.black, 
    inactiveTrackColor: Colors.black.withOpacity(0.3), 
    thumbColor: Colors.black, 
    overlayColor: Colors.black.withOpacity(0.2), 
    valueIndicatorColor: Colors.black, 
  ),
  child: Slider(
    value: 0.4,
    onChanged: (double value) {
     
    },
  ),
),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   IconButton(onPressed: (){}, icon: Icon(Icons.repeat),iconSize: 32,),
                   IconButton(onPressed: (){}, icon: Icon(Icons.skip_previous_rounded),iconSize: 35,),
                   IconButton(onPressed: (){}, icon: Icon(Icons.pause_circle),iconSize: 35,),
                   IconButton(onPressed: (){}, icon: Icon(Icons.skip_next_rounded),iconSize: 35,),
                   IconButton(onPressed: (){}, icon: Icon(Icons.shuffle),iconSize: 32,),
                
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
