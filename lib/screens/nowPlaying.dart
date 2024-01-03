import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:rhythmix/database/function/db_function.dart';
import 'package:rhythmix/database/function/functions.dart';
import 'package:rhythmix/database/model/db_model.dart';
import 'package:rhythmix/provider/songprovider.dart';
import 'package:google_fonts/google_fonts.dart';

class NowPlaying extends StatefulWidget {
  NowPlaying({
    super.key,
    required this.songModel,
    required this.audioPlayer,
  });
  final MusicModel songModel;
  final AudioPlayer audioPlayer;

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool _isplaying = false;
  bool _isMounted = false;
  bool _isfavorite = false;

  @override
  void initState() {
    super.initState();
    _isMounted = true;
    playsong();
  }

  @override
  void dispose() {
    _isMounted = false;
    super.dispose();
  }

  void playsong() {
    try {
      widget.audioPlayer
          .setAudioSource(AudioSource.uri(Uri.parse(widget.songModel.uri)));
      widget.audioPlayer.play();
      _isplaying = true;
    } on Exception {
      print('Error playing song: ');
    }
    widget.audioPlayer.durationStream.listen((d) {
      if (_isMounted) {
        setState(() {
          _duration = d!;
        });
      }
    });

    widget.audioPlayer.positionStream.listen((p) {
      if (_isMounted) {
        setState(() {
          _position = p;
        });
      }
    });
  }

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
            Color.fromARGB(255, 255, 255, 255),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 13, right: 13),
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
                  height: screenHeight * 0.04,
                ),
                Container(
                  height: screenHeight * 0.4,
                  width: screenWidth * 0.9,
                  child: const Artworkwidget(),
                ),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                MarqueeText(
                  alwaysScroll: true,
                  speed: 25,
                  text: TextSpan(
                    text: widget.songModel.songname,
                    style: TextStyle(fontSize: 35),
                  ),
                ),

                SizedBox(
                  height: screenHeight * 0.01,
                ),
                MarqueeText(
                    speed: 25,
                    text: TextSpan(
                      text: widget.songModel.artrist.toString(),
                      style: songstextbalck(),
                    )),
                SizedBox(
                  height: screenHeight * 0.0,
                ),
                //Lyrics
                TextButton(
                    onPressed: () {},
                    child: Text('Lyrics',
                        style: GoogleFonts.archivo(
                            textStyle: TextStyle(color: Colors.white)))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    favsongss.contains(widget.songModel.songid)
                        ? IconButton(
                            onPressed: () {
                              removelikedsong(widget.songModel.songid);
                              iflikedsong();
                              setState(() {});
                            },
                            icon: Icon(Icons.favorite))
                        : IconButton(
                            onPressed: () async {
                              await addfavToDB(widget.songModel.songid);
                              iflikedsong();
                              setState(() {
                                
                              });
                            },
                            icon: Icon(Icons.favorite_border_outlined))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13, right: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_position.toString().split('.')[0]),
                      Text(_duration.toString().split('.')[0]),
                    ],
                  ),
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
                    min: Duration(microseconds: 0).inSeconds.toDouble(),
                    value: _position.inSeconds.toDouble(),
                    max: _duration.inSeconds.toDouble(),
                    onChanged: (value) {
                      setState(() {
                        changedtoseconds(value.toInt());
                        value = value;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.repeat),
                      iconSize: 32,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.skip_previous_rounded),
                      iconSize: 35,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (_isplaying) {
                            print("Pausing...");
                            widget.audioPlayer.pause();
                          } else {
                            print("Playing...");
                            widget.audioPlayer.play();
                          }
                          _isplaying = widget.audioPlayer.playing;
                          print("_isplaying: $_isplaying");
                        });
                      },
                      icon: Icon(
                        _isplaying ? Icons.pause_circle : Icons.play_arrow,
                      ),
                      iconSize: 35,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.skip_next_rounded),
                      iconSize: 35,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.shuffle),
                      iconSize: 32,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void changedtoseconds(int second) {
    Duration duration = Duration(seconds: second);
    widget.audioPlayer.seek(duration);
  }
}

class Artworkwidget extends StatelessWidget {
  const Artworkwidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: QueryArtworkWidget(
        id: context.watch<songModelprovider>().id,
        type: ArtworkType.AUDIO,
        artworkFit: BoxFit.cover,
        nullArtworkWidget: Image.asset('asset/the black boy.jpeg'),
      ),
    );
  }
}
