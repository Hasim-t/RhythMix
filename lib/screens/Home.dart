import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/database/function/db_function.dart';
import 'package:rhythmix/database/function/functions.dart';
import 'package:rhythmix/database/model/db_model.dart';
import 'package:rhythmix/screens/allsongs.dart';

import 'package:rhythmix/provider/songprovider.dart';
import 'package:rhythmix/screens/now_playing.dart';
import 'package:text_scroll/text_scroll.dart';

final audioplayer = AudioPlayer();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    requestpermission();
  }

  void requestpermission() {
    Permission.storage.request();
  }

  final _audioQuert = OnAudioQuery();

  Future<List<MusicModel>> fechsong() async {
    List<SongModel> songlist = await _audioQuert.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
   
    addSongToDb(songs: songlist);
    return getAllSongs();
  }

  playsong(String? uri) {
    try {
      audioplayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioplayer.play();
    } on Exception {
      print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'asset/musicapp logo.png',
                    height: 40,
                    width: 40,
                  ),
                ),
                SizedBox(
                  width: screenWidth * 0.02,
                ),
                Text("RhythMix", style: TextStyle(fontSize: 23)),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: screenWidth*0.001,left:screenWidth*0.01,top: screenHeight*0.01 ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                ),
                height: screenHeight * 0.20,
                width: screenWidth * 0.88,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child:
                      Image.asset('asset/homepage.jpeg', fit: BoxFit.cover),
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return All_Songs();
                  }));
                },
                icon: Icon(Icons.view_headline_sharp)),
            Expanded(
              child: FutureBuilder<List<MusicModel>>(
                future: fechsong(),
                builder: (context, item) {
                  if (item.data == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (item.data!.isEmpty) {
                    return Text('no song found');
                  }
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(
                            right: screenWidth * 0.04,
                            left: screenWidth * 0.04,
                            bottom: screenWidth * 0.02),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(130, 53, 102, 186),
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
                                  bottomsheet(context,item.data![index]);
                                },
                                child: Icon(
                                  Icons.more_vert,
                                )),
                          ),
                        ),
                      );
                    },
                    itemCount: item.data!.length,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
