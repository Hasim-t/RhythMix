import 'package:hive_flutter/adapters.dart';
part 'db_model.g.dart';

@HiveType(typeId: 1)
class MusicModel {
  @HiveField(0)
  int songid;
  @HiveField(1)
  String songname;
  @HiveField(2)
  String artrist;
  @HiveField(3)
  String uri;
  MusicModel(
      {required this.artrist,
      required this.songid,
      required this.songname,
      required this.uri});
}

@HiveType(typeId: 2)
class FavorateSong extends HiveObject {
  @HiveField(0)
   int likedid;

  FavorateSong({required this.likedid});
}
