import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/database/function/db_playlist.dart';

import 'package:rhythmix/database/function/functions.dart';
import 'package:rhythmix/database/model/db_model.dart';
import 'package:rhythmix/provider/songprovider.dart';
import 'package:rhythmix/screens/Home.dart';
import 'package:rhythmix/screens/add_song_to_playlist.dart';
import 'package:rhythmix/screens/now_playing.dart';
import 'package:text_scroll/text_scroll.dart';

class OtherPage extends StatefulWidget {
  final String itemName;
  final int id;

  const OtherPage({
    Key? key,
    required this.itemName,
    required this.id,
  }) : super(key: key);

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
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
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            actions: [
              InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return addsongplaylist(
                        id: widget.id,
                      );
                    }));
                  },
                  child: Icon(Icons.add,size: 35,)),
                  SizedBox(width: 20,)
            ],
            title: Text(
              widget.itemName,
            ),
          ),
          body: FutureBuilder<List<MusicModel>>(
            future: getallsongstoPlaylist(widget.id),
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
                            }))
                              ..then((value) {
                                setState(() {});
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
                          trailing: InkWell(
                              onTap: () {
                                removeSongFromPlaylist(
                                    widget.id, item.data![index].songid);
                                setState(() {});
                              },
                              child: Icon(Icons.close))),
                    ),
                  );
                },
                itemCount: item.data!.length,
              );
            },
          ),
        ));
  }
}
