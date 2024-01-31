import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:text_scroll/text_scroll.dart';

class Lyrics extends StatefulWidget {
  final String songName;
  final String artistName;

  const Lyrics({Key? key, required this.songName, required this.artistName, required int songId})
      : super(key: key);

  @override
  _LyricsState createState() => _LyricsState();
}

class _LyricsState extends State<Lyrics> {
  String? lyrics;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _getLyrics();
  }

  Future<void> _getLyrics() async {
    final apiKey = '9e01bdb166e06b520fd08397ee762ca0';
    final searchUrl =
        'https://api.musixmatch.com/ws/1.1/track.search?q_track=${widget.songName}&q_artist=${widget.artistName}&apikey=$apiKey';

    final searchResponse = await http.get(Uri.parse(searchUrl));

    if (searchResponse.statusCode == 200) {
      final searchJson = json.decode(searchResponse.body);
      final trackList = searchJson['message']['body']['track_list'] as List;

      if (trackList.isNotEmpty) {
        final trackId = trackList[0]['track']['track_id'];

        final lyricsUrl =
            'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$trackId&apikey=$apiKey';

        final lyricsResponse = await http.get(Uri.parse(lyricsUrl));

        if (lyricsResponse.statusCode == 200) {
          final lyricsJson = json.decode(lyricsResponse.body);
          final lyricsText = lyricsJson['message']['body']['lyrics']['lyrics_body'];

          setState(() {
            lyrics = lyricsText;
          });
        } else {
          _showLyricsNotFoundSnackBar();
        }
      } else {
        _showLyricsNotFoundSnackBar();
      }
    } else {
      _showLyricsNotFoundSnackBar();
    }

    // Hide the loading indicator after fetching
    setState(() {
      loading = false;
    });
  }

  void _showLyricsNotFoundSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(

        content: Text('Lyrics not found for ${widget.songName} by ${widget.artistName}'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(232, 5, 122, 247),
              Color.fromARGB(255, 255, 255, 255)
            ])),
        child:Scaffold(
          backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text('Lyrics',
        style: GoogleFonts.archivo(
          textStyle: TextStyle(
            fontSize: 30
          )
        ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: loading
                ? CircularProgressIndicator() 
                : TextScroll(
                    lyrics ?? 'Lyrics not found',
                    style: TextStyle(fontSize: 16),
                  ),
          ),
        ),
      ),
    ));
  }
  
}