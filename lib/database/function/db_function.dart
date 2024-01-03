

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
    print(m.artrist);
  }
}

Future<List<MusicModel>> getAllSongs() async {
  final songDB = await Hive.openBox<MusicModel>('song_model');
  List<MusicModel> songs = songDB.values.toList();
  return songs;
}

Future<void> addfavToDB({required List<MusicModel> favsong}) async {
  final favsongDB = await Hive.openBox<FavorateSong>('Fav');
  if (favsongDB.isEmpty) {
    for (MusicModel m in favsong) {
      final likedsong = await FavorateSong(likedid: m.songid);
      favsongDB.add(likedsong);
    }
  }

  for (FavorateSong f in favsongDB.values) {
    print(f);
  }
}
