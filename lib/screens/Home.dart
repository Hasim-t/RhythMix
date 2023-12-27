import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/database/function/db_function.dart';
import 'package:rhythmix/screens/nowPlaying.dart';
import 'package:rhythmix/provider/songprovider.dart';

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

  Future<List<SongModel>> fechsong() async {
    List<SongModel> songlist = await _audioQuert.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );
    addSongtodb(song: songlist);
    return songlist;
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
    EdgeInsetsGeometry padding = EdgeInsets.all(screenWidth * 0.05);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: SingleChildScrollView(
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
                padding: padding,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(13)),
                  ),
                  height: screenHeight * 0.20,
                  width: screenWidth * 0.50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: Image.asset('asset/sampleimage.jpg', fit: BoxFit.cover),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.6, // Adjust the height as needed
                child: FutureBuilder<List<SongModel>>(
                  future: fechsong(),
                  builder: (context, item) {
                    if (item.data == null) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (item.data!.isEmpty) {
                      return Text('no song found');
                    }
                    return ListView.builder(
                      physics: NeverScrollableScrollPhysics(), // Add this line
                      shrinkWrap: true, // Add this line
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(5),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(130, 53, 102, 186),
                            ),
                            child: ListTile(
                              onTap: () {
                                context
                                    .read<songModelprovider>()
                                    .setId(item.data![index].id);
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return NowPlaying(
                                    songModel: item.data![index],
                                    audioPlayer: audioplayer,
                                  );
                                }));
                              },
                              title: Text(item.data![index].displayNameWOExt),
                              subtitle: Text('${item.data![index].artist}'),
                              leading: QueryArtworkWidget(
                                id: item.data![index].id,
                                type: ArtworkType.AUDIO,
                                nullArtworkWidget: Icon(Icons.music_note),
                              ),
                              trailing: SizedBox(
                                width: 60,
                                child: Row(
                                  children: [
                                    InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.play_arrow,
                                        )),
                                    SizedBox(
                                      width: screenWidth * 0.03,
                                    ),
                                    InkWell(
                                        onTap: () {}, child: Icon(Icons.more_vert)),
                                  ],
                                ),
                              ),
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
      ),
    );
  }
}

