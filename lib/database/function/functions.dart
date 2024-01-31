
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythmix/database/function/db_playlist.dart';
import 'package:rhythmix/database/function/favorite_db.dart';
import 'package:rhythmix/database/model/db_model.dart';
import 'package:on_audio_query_platform_interface/src/models/playlist_model.dart'
    as AudioQueryPlaylistModel;
import 'package:rhythmix/database/model/db_model.dart' as RhythmixPlaylistModel;

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
        child: Column(
          children: [
            favsongss.contains(item.songid)
                ? InkWell(
                    onTap: () {
                      removelikedsong(item.songid);
                      iflikedsong();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 19),
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
                    ),
                  )
                : InkWell(
                    onTap: () async {
                      await addfavToDB(item.songid);
                      iflikedsong();
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: screenHeight * 0.08,
                      width: screenWidth,
                      child: Row(
                        children: [
  SizedBox(width: 20,),
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
            InkWell(
              onTap: () async {
                
                showPlaylistBottomSheet(context, item);
              },
              child: Container(
                height: screenHeight * 0.08,
                width: screenWidth,
                child: Row(
                  children: [
                    SizedBox(width: 15,),
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
                    ),
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
                SizedBox(width: 16,),
                  Icon(
                    Icons.share,
                    size: 35,
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
      );
    },
  );
}

void showPlaylistBottomSheet(BuildContext context, MusicModel song) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return buildPlaylistBottomSheet(context, song);
    },
  );
}

Widget buildPlaylistBottomSheet(BuildContext context, MusicModel song) {
  double screenWidth = MediaQuery.of(context).size.width;

  return SingleChildScrollView(
    child: Container(
      padding: EdgeInsets.all(16),
      constraints: BoxConstraints(
        minHeight: 200, // Set a minimum height for the container
        minWidth: screenWidth, // Set a fixed width for the container
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Add to Playlist',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          FutureBuilder<List<RhythmixPlaylistModel.PlaylistModel>>(
            future: getallplaylis(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                if (snapshot.data!.isEmpty) {
                  return Column(
                    children: [
                      Text('No playlists available'),
                      SizedBox(height: 16),
                      Container(
                        width: screenWidth, // Set the desired width
                        child: ElevatedButton(
                          onPressed: () {
                            // Show an alert dialog to add a new playlist
                            showAddPlaylistDialog(context, song);
                          },
                          child: Text('Add Playlist',
                              style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      RhythmixPlaylistModel.PlaylistModel playlist =
                          snapshot.data![index];
                      return ListTile(
                        title: Text(
                          playlist.name,
                          style: TextStyle(fontSize: 16),
                        ),
                        onTap: () {
                          addsongsToPlylist1(song, playlist.key);
                          Navigator.pop(context); // Close the bottom sheet
                        },
                      );
                    },
                  );
                }
              }
            },
          ),
        ],
      ),
    ),
  );
}

Future<void> showAddPlaylistDialog(
    BuildContext context, MusicModel song) async {
  String newPlaylistName = '';

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Add New Playlist'),
        content: TextField(
          onChanged: (value) {
            newPlaylistName = value;
          },
          decoration: InputDecoration(
            hintText: 'Enter playlist name',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (newPlaylistName.isNotEmpty) {
                await addPlaylistToHive(newPlaylistName, []);
                addsongsToPlylist1(song, await getNewPlaylistKey());
                Navigator.pop(context);
              }
            },
            child: Text('Add'),
          ),
        ],
      );
    },
  );
}

Future<int> getNewPlaylistKey() async {
  final playlists = await getallplaylis();
  return playlists.length > 0 ? playlists.last.key + 1 : 1;
}
