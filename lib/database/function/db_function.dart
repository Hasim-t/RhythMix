

import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmix/database/model/db_model.dart';

Future<void> addSongToDb({required List<SongModel> songs}) async {
  final songDB = await Hive.openBox<MusicModel>('song_model');

  if (songDB.isEmpty) {
    for (SongModel m in songs) {
      songDB.add(MusicModel(
        artrist: m.artist.toString(),
        songid: m.id,
        songname: m.title,
        uri: m.uri.toString(), 
        
        
        
      ));
    }
  }

  for (MusicModel m in songDB.values) {
    print(m.songid);
  }
}

Future<List<MusicModel>> getAllSongs() async {
  final songDB = await Hive.openBox<MusicModel>('song_model');
  List<MusicModel> songs = songDB.values.toList();
  return songs;
}





