import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:rhythmix/database/function/db_function.dart';
import 'package:rhythmix/database/model/db_model.dart';

Future<void> addPlaylistToHive(String playlistName, List<int> song) async {
  final playlistBox = await Hive.openBox<PlaylistModel>('playlists');
  final playlistModel = PlaylistModel(
    name: playlistName,
    playlistsong: [],
  );
  await playlistBox.add(playlistModel);
}

Future<List<PlaylistModel>> getallplaylis() async {
  final playlistBox = await Hive.openBox<PlaylistModel>('playlists');
  return playlistBox.values.toList();
}

Future<void> deleteplaylist(int key) async {
  final playlistBox = await Hive.openBox<PlaylistModel>('playlists');
  playlistBox.delete(key);
}

Future<void> editPlaylistInHive(int key, String editedName) async {
  final playlistBox = await Hive.openBox<PlaylistModel>('playlists');
  final PlaylistModel playlist = playlistBox.get(key)!;
  playlist.name = editedName;
  await playlistBox.put(key, playlist);
}

List<int> songIds = [];
Future<void> addsongsToPlylist1(MusicModel song, int key) async {
  final plyalistBox = await Hive.openBox<PlaylistModel>('playlists');
  final box = plyalistBox.get(key);
  box?.playlistsong.add(song.songid);

  plyalistBox.put(key, box!);
  getallplaylis();
}

Future<List<MusicModel>> getallsongstoPlaylist(int key) async {
  final playlistBox = await Hive.openBox<PlaylistModel>('playlists');
  final box = playlistBox.get(key);

  List<int> listsong = [];
  listsong.addAll(box!.playlistsong);

  return await showPlaylistSongs(listsong);
}

Future<bool> ifsongcontian(MusicModel song, int key) async {
  bool contain = false;
  final playlistBox = await Hive.openBox<PlaylistModel>('playlists');
  final box = playlistBox.get(key);
  List<int> ids = box!.playlistsong;
  for (int i = 0; i < ids.length; i++) {
    if (ids[i] == song.songid) {
      contain = true;
    }
  }
  return contain;
}

Future<List<MusicModel>> showPlaylistSongs(List<int> songids) async {
  List<MusicModel> playListsong = [];
  List<MusicModel> song = await getAllSongs();
  for (int i = 0; i < songids.length; i++) {
    for (int j = 0; j < song.length; j++) {
      if (song[j].songid == songids[i]) {
        playListsong.add(song[j]);
      }
    }
  }
  return playListsong;
}

Future<void> removeSongFromPlaylist(int key, int songId) async {
  final playlistBox = await Hive.openBox<PlaylistModel>('playlists');
  final box = playlistBox.get(key);
  box!.playlistsong.remove(songId);
}
