import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/database/function/db_function.dart';
import 'package:rhythmix/database/model/db_model.dart';

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
