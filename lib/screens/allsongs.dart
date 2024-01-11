import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/database/function/db_function.dart';
import 'package:rhythmix/database/function/functions.dart';
import 'package:rhythmix/database/model/db_model.dart';
import 'package:rhythmix/provider/songprovider.dart';
import 'package:rhythmix/screens/Home.dart';
import 'package:rhythmix/screens/nowPlaying.dart';
import 'package:text_scroll/text_scroll.dart';

class All_Songs extends StatefulWidget {
  const All_Songs({super.key});

  @override
  State<All_Songs> createState() => _All_SongsState();
}

class _All_SongsState extends State<All_Songs> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text('all songs',style: songstext()
        ),),
      
      body: SafeArea(
      
        child: FutureBuilder<List<MusicModel>>(
                  future:getAllSongs() ,
                  builder: (context, item) {
                    if (item.data == null) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (item.data!.isEmpty) {
                      return Text('no song found');
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              right: screenWidth * 0.04,
                              left: screenWidth * 0.04,
                              top: screenHeight*0.02
                              ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(76, 0, 0, 0),
                            ),
                            child: ListTile(
                              onTap: () {
                                context
                                    .read<songModelprovider>()
                                    .setId(item.data![index].songid);
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return NowPlaying(
                                    songModel: item.data![index],
                                    audioPlayer: audioplayer, playlist:item.data!, currentIndex: index,  
                                  );
                                }));
                              },
                              title: TextScroll(item.data![index].songname),
                              subtitle:
                                  TextScroll('${item.data![index].artrist}'),
                              leading: QueryArtworkWidget(
                                id: item.data![index].songid,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: ClipRRect(
                                  child: Image.asset('asset/the black boy.jpeg'),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              trailing: InkWell(
                                  onTap: () {
                                    bottomsheet(context,item.data![index] );
                                  },
                                  child: Icon(Icons.more_vert,)),
                            ),
                          ),
                        );
                      },
                      itemCount: item.data!.length,
                    );
                  },
                ),
      ),
    );
  }
}