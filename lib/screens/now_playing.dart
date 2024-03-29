import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';


import 'package:rhythmix/database/function/favorite_db.dart';
import 'package:rhythmix/database/function/functions.dart';
import 'package:rhythmix/database/function/recently.dart';

import 'package:rhythmix/database/model/db_model.dart';
import 'package:rhythmix/provider/songprovider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rhythmix/screens/lyrics.dart';


// ignore: must_be_immutable
class NowPlaying extends StatefulWidget {
  NowPlaying({
    super.key,
    required this.songModel,
    required this.audioPlayer,
    required this.playlist,
    required this.currentIndex,
  });
  MusicModel songModel;
  final AudioPlayer audioPlayer;
  List<MusicModel> playlist;
  int currentIndex;
  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  Duration _duration = const Duration();
  Duration _position = const Duration();
  bool _isplaying = false;
  bool _isMounted = false;
  bool _isRepeatMode = false;
  bool _isShuffleMode = false;

  void updateson(MusicModel newsong) {
    widget.songModel = newsong;

    // Use context.read to directly access the provider value
    final songModelProvider = context.read<songModelprovider>();

    // Update the ID and notify listeners
    songModelProvider.setId(newsong.songid);

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    addrecently(widget.songModel.songid);
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


      widget.audioPlayer.setShuffleModeEnabled(_isShuffleMode);

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

          // Check if the song has completed and move to the next song
          if (_position >= _duration && _duration > Duration.zero) {
            // Song has completed, go to the next song
            skipToNextSong();
          }
        });
      }
    });
  }

  Future<bool> checkLyricsAvailability() async {
  final apiKey = '9e01bdb166e06b520fd08397ee762ca0';
  final searchUrl =
      'https://api.musixmatch.com/ws/1.1/track.search?q_track=${widget.songModel.songname}&q_artist=${widget.songModel.artrist}&apikey=$apiKey';

  final searchResponse = await http.get(Uri.parse(searchUrl));

  if (searchResponse.statusCode == 200) {
    final searchJson = json.decode(searchResponse.body);
    final trackList = searchJson['message']['body']['track_list'] as List;

    return trackList.isNotEmpty;
  }

  return false;
}


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
     final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

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
            padding:  EdgeInsets.only(left: 13, right: 13,bottom:keyboardHeight ),
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
  onPressed: () async {
    // Check if lyrics are available
    bool hasLyrics = await checkLyricsAvailability();

    if (hasLyrics) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) {
          return Lyrics(
            songName: widget.songModel.songname,
            artistName: widget.songModel.artrist, songId: widget.songModel.songid,
          );
        }),
      );
    } else {
      // Show Snackbar if lyrics are not available
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Lyrics not available for this song.'),
        ),
      );
    }
  },
  child: Text(
    'Lyrics',
    style: GoogleFonts.archivo(
      textStyle: TextStyle(color: Colors.white),
    ),
  ),
),

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
                              setState(() {});
                            },
                            icon: Icon(Icons.favorite_border_outlined)),
                    IconButton(
                        onPressed: () {
                          showPlaylistBottomSheet(context, widget.songModel);
                        },
                        icon: Icon(Icons.format_list_bulleted_add))
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
                      onPressed: () {
                        loopmode();
                      },
                      icon: Icon(Icons.repeat),
                      iconSize: 32,
                      color: _isRepeatMode
                          ? Colors.blue
                          : null, 
                    ),
                    IconButton(
                      onPressed: skipToPreviousSong,
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
                      onPressed: skipToNextSong,
                      icon: Icon(Icons.skip_next_rounded),
                      iconSize: 35,
                    ),
                    IconButton(
                      onPressed: () {
                        shuffleSongs();
                      },
                      icon: Icon(Icons.shuffle),
                      iconSize: 32,
                      color: _isShuffleMode ? Colors.blue : null,
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
  void skipToPreviousSong() {
    int currentIndex = widget.currentIndex;
    currentIndex--;
    if (currentIndex >= 0) {
      MusicModel previousSong = widget.playlist[currentIndex];
      setState(() {
        widget.currentIndex = currentIndex;
        widget.audioPlayer
            .setAudioSource(AudioSource.uri(Uri.parse(previousSong.uri)));
        widget.audioPlayer.play();
        updateson(previousSong);
      });
    } else {
      currentIndex = widget.playlist.length - 1;
      MusicModel lastSong = widget.playlist[currentIndex];
      setState(() {
        widget.currentIndex = currentIndex;
        widget.audioPlayer
            .setAudioSource(AudioSource.uri(Uri.parse(lastSong.uri)));
        widget.audioPlayer.play();
        updateson(lastSong);
      });
    }
  }

  void loopmode() {
    setState(() {
      _isRepeatMode = !_isRepeatMode;
      if (_isRepeatMode) {
        widget.audioPlayer.setLoopMode(LoopMode.one);
      } else {
        widget.audioPlayer.setLoopMode(LoopMode.off);
      }
    });
  }

  void skipToNextSong() {
    int currentIndex = widget.currentIndex;
    currentIndex++;
    if (currentIndex < widget.playlist.length) {
      MusicModel nextSong = widget.playlist[currentIndex];
      setState(() {
        widget.currentIndex = currentIndex;
        widget.audioPlayer
            .setAudioSource(AudioSource.uri(Uri.parse(nextSong.uri)));
        widget.audioPlayer.play();
        updateson(nextSong);
      });
    } else {}
  }
  void shuffleSongs() {
    setState(() {
      _isShuffleMode = !_isShuffleMode;
      widget.audioPlayer.setShuffleModeEnabled(_isShuffleMode);
      if (_isShuffleMode) {
        List<MusicModel> shuffledSongs = List.from(widget.playlist);
        shuffledSongs.shuffle();
        widget.playlist = shuffledSongs;
        widget.currentIndex = widget.playlist.indexOf(widget.songModel);
      } else {
        widget.playlist = List.from(widget.playlist);
        widget.currentIndex = widget.playlist.indexOf(widget.songModel);
        widget.audioPlayer
            .setAudioSource(AudioSource.uri(Uri.parse(widget.songModel.uri)));
        widget.audioPlayer.play();
        updateson(widget.songModel);
      }
    });
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
    print(
        'Building Artworkwidget for song ID: ${context.watch<songModelprovider>().id}');
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: QueryArtworkWidget(
        key: Key(context.watch<songModelprovider>().id.toString()),
        id: context.watch<songModelprovider>().id,
        type: ArtworkType.AUDIO,
        artworkFit: BoxFit.cover,
        nullArtworkWidget: Image.asset('asset/the black boy.jpeg'),
      ),
    );
  }
}
