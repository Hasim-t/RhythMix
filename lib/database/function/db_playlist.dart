import 'package:hive/hive.dart';
import 'package:rhythmix/database/model/db_model.dart';


Future<void> addPlaylistToHive(String playlistName) async {
    final playlistBox = await Hive.openBox<PlaylistModel>('playlists');
    final playlistModel = PlaylistModel(name: playlistName, playlistsong: [],);
    await playlistBox.add(playlistModel);
  }
