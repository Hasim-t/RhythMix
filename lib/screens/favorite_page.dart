import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/database/function/favorite_db.dart';
import 'package:rhythmix/database/function/functions.dart';
import 'package:rhythmix/database/model/db_model.dart';
import 'package:rhythmix/provider/songprovider.dart';
import 'package:rhythmix/screens/Home.dart';
import 'package:rhythmix/screens/now_playing.dart';

import 'package:text_scroll/text_scroll.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  

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
        appBar: AppBar(
          title: Text(
            'Favorite Song',
            style: titletext(),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<List<MusicModel>>(
          future: showlikedsong(),
          builder: (context, item) {
            if (item.data == null) {
              return Center(child: CircularProgressIndicator());
            }
            if (item.data!.isEmpty) {
              return Center(
                  child: Text(
                'no song found',
                style: songstextbalck(),
              ));
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      right: screenWidth * 0.04,
                      left: screenWidth * 0.04,
                      top: screenHeight * 0.02),
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
                              audioPlayer: audioplayer,
                              playlist: item.data!,
                              currentIndex: index,
                            );
                          }))..then((value) {
                            setState(() {
                              
                            });
                          });
                        },
                        title: TextScroll(item.data![index].songname),
                        subtitle: TextScroll('${item.data![index].artrist}'),
                        leading: QueryArtworkWidget(
                          id: item.data![index].songid,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: ClipRRect(
                            child: Image.asset('asset/the black boy.jpeg'),
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          
                          children: [
                            InkWell(
                                onTap: () {
                                  removelikedsong(item.data![index].songid);
                                  iflikedsong();
                                  setState(() {});
                                },
                                child: Icon(Icons.favorite)),
                              SizedBox(width: 10),
                                InkWell(
                                  onTap: () {
                                    bottomsheet(context,item.data![index]);
                                    
                                  },
                                  child: Icon(Icons.more_vert))
                          ],
                        )),
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
