

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


//Fav


Future<void> addfavToDB(int favid) async {
  final favsongDB = await Hive.openBox<FavorateSong>('Fav');
  final likedsong = FavorateSong(likedid: favid);
  await favsongDB.add(likedsong);
  print(favsongDB.length);
}

List<int> favsongss = [];
iflikedsong() async {
  favsongss.clear();
  final favsongDb = await Hive.openBox<FavorateSong>('Fav');
  final List<FavorateSong> likeson = favsongDb.values.toList();
  for (FavorateSong element in likeson) {
    favsongss.add(element.likedid);
  }
}

Future<void> removelikedsong(int sondId) async {
  final favsongDB = await Hive.openBox<FavorateSong>('Fav');

  for (FavorateSong element in favsongDB.values.toList()) {
    if (sondId == element.likedid) {
      favsongDB.delete(element.key);
    }
  }
}

Future<List<MusicModel>> showlikedsong() async {
  final favsongDB = await Hive.openBox<FavorateSong>('Fav');
  List<MusicModel> likedsong = [];
  List<MusicModel> song = await getAllSongs();

  for (int i = 0; i < song.length; i++) {
    for (int j = 0; j < favsongDB.length; j++) {
      if (favsongDB.values.toList()[j].likedid == song[i].songid) {
        likedsong.add(song[i]);
      }
    }
  }
  return likedsong;
}
