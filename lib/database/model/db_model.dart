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
 
  

  MusicModel({
    required this.artrist,
    required this.songid,
    required this.songname,
    required this.uri,
    
   
  });
}

@HiveType(typeId: 2)
class FavorateSong extends HiveObject {
  @HiveField(0)
  int likedid;

  FavorateSong({required this.likedid});
}

@HiveType(typeId: 3)
class Recently extends HiveObject {
  @HiveField(0)
  int recentid;

  Recently({required this.recentid});
}

@HiveType(typeId: 4) // Use a different typeId for Playlist
class PlaylistModel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> playlistsong = [];

  PlaylistModel({required this.name, required this.playlistsong});
}
