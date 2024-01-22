import 'package:hive_flutter/hive_flutter.dart';
import 'package:rhythmix/database/function/db_function.dart';
import 'package:rhythmix/database/model/db_model.dart';

Future<void> addrecently(int recentid) async {
  final recentDB = await Hive.openBox<Recently>('recently');
  final recentlsong = Recently(recentid: recentid);

  await recentDB.add(recentlsong);
  print('song added $recentid');
}

Future<List<MusicModel>> showrecenty() async {
  final recentDB = await Hive.openBox<Recently>('recently');
  List<Recently> showrec = recentDB.values.toList();

 
  List<MusicModel> musicModelsList = await getAllSongs();

  List<MusicModel> convertedList = showrec.map((recently) {
    MusicModel associatedMusicModel = musicModelsList
        .firstWhere((musicModel) => musicModel.songid == recently.recentid);

    return associatedMusicModel;
  }).toList();

  
  convertedList = convertedList.reversed.toSet().toList();

  return convertedList;
}
