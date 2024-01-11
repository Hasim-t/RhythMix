import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythmix/database/function/db_function.dart';
import 'package:rhythmix/database/model/db_model.dart';

TextStyle songstext() {
  return GoogleFonts.archivo(
      textStyle: TextStyle(fontSize: 23, color: Colors.white));
}

TextStyle songstextbalck() {
  return GoogleFonts.archivo(
      textStyle: TextStyle(fontSize: 23, color: Color.fromARGB(255, 0, 0, 0)));
}

TextStyle titletext() {
  return GoogleFonts.archivo(
      textStyle: TextStyle(fontSize: 32, color: Color.fromARGB(255, 0, 0, 0)));
}

void bottomsheet(BuildContext context, MusicModel item) {
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  showModalBottomSheet(
      context: context,
      builder: (
        context,
      ) {
        return Container(
          height: screenHeight * 0.285,
          width: screenWidth,
          color: Colors.transparent,
          child: Expanded(
            child: Column(
              children: [
                favsongss.contains(item.songid)
                    ? InkWell(
                        onTap: () {
                          removelikedsong(item.songid);
                          iflikedsong();
                        },
                        child: Container(
                          height: screenHeight * 0.08,
                          width: screenWidth,
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                size: 35,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: screenWidth * 0.09,
                              ),
                              Text(
                                'Remove from Favorite',
                                style: songstextbalck(),
                              )
                            ],
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () async {
                          await addfavToDB(item.songid);
                          iflikedsong();
                          
                        },
                        child: Container(
                          height: screenHeight * 0.08,
                          width: screenWidth,
                          child: Row(
                            children: [
                              Icon(
                                Icons.favorite,
                                size: 35,
                                color: Colors.black,
                              ),
                              SizedBox(
                                width: screenWidth * 0.09,
                              ),
                              Text(
                                'Add To Favorite',
                                style: songstextbalck(),
                              )
                            ],
                          ),
                        ),
                      ),
                Divider(),
                Container(
                  height: screenHeight * 0.08,
                  width: screenWidth,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        size: 50,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: screenWidth * 0.09,
                      ),
                      Text(
                        'Add Playlist',
                        style: songstextbalck(),
                      )
                    ],
                  ),
                ),
                Divider(),
                Container(
                  height: screenHeight * 0.08,
                  width: screenWidth,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add,
                        size: 50,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: screenWidth * 0.09,
                      ),
                      Text(
                        'Share',
                        style: songstextbalck(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
