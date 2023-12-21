import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:rhythmix/database/model/db_model.dart';

addSongtodb({required List<SongModel> song}) async {
  final songDB = await Hive.openBox<MusicModel>('song_model');

  if (songDB.isEmpty) {
    for (SongModel m in song) {
      songDB.add(MusicModel(
          artrist: m.artist.toString(),
          songid: m.id,
          songname: m.title,
          uri: m.uri.toString()));
    }
  }
  for (MusicModel m in songDB.values) {
    print(m.artrist);
  }
}
