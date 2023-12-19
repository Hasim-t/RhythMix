import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rhythmix/nowPlaying.dart';

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
  final _audioplayer = AudioPlayer();
  playsong(String? uri) {
    try {
      _audioplayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      _audioplayer.play();
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
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(13)),
                ),
                height: screenHeight * 0.20,
                width: screenWidth * 0.50,
                child: Icon(Icons.music_note),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<SongModel>>(
                future: _audioQuert.querySongs(
                  sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,
                ),
                builder: (context, item) {
                  if (item.data == null) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (item.data!.isEmpty) {
                    return Text('no song fond');
                  }
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(5),
                        child: ListTile(
                          onTap: () {
                            playsong(item.data![index].uri);
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return NowPlaying();
                              
                            }));
                          },
                          title: Text(item.data![index].displayNameWOExt),
                          subtitle: Text('${item.data![index].artist}'),
                          leading: Icon(Icons.music_note),
                          trailing: SizedBox(
                            width: 60,
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      playsong(item.data![index].uri);
                                    },
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
                      );
                    },
                    itemCount: item.data!.length,
                  );
                },
              ),
            ),
            Container(
              height: screenHeight * 0.06,
              width: screenWidth,
              color: Color.fromARGB(77, 5, 122, 247),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.play_arrow),
                    iconSize: screenHeight * 0.04,
                  ),
                  Expanded(
                      child: Slider(
                    value: 0.0,
                    onChanged: (value) {},
                    thumbColor: Colors.white,
                  )),
                  IconButton(
                      onPressed: () {}, icon: Icon(Icons.favorite_border))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
