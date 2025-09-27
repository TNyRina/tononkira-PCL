import 'package:tononkira_pcl/dao/playlist_dao.dart';
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/entity/playlist.dart';
import 'package:tononkira_pcl/utility/exception.dart';

class PlaylistService {
  static Future<List<Playlist>> loadPlaylist() async {
    return await PlaylistDAO.loadPlaylist();
  }

  static Future<List<Lyric>> loadPlaylistSongs(Playlist playlist) async {
    return await PlaylistDAO.loadPlaylistSongs(playlist);
  }

  static Future<void> newPlaylist(
    String name,
    List<int> songs,
    String description,
  ) async {
    try{
      await PlaylistDAO.createPlaylist(
      Playlist(name: name, songsID: songs, description: description),
    );
    } catch (e) {
      throw Exception(getExceptionMessage(e.toString())); 
    }
  }

  static Future<void> updatePlaylist(
    Playlist playlist,
    String name,
    String description,
  ) async {
    String oldName = playlist.name;
    playlist.name = name;
    playlist.description = description;
    await PlaylistDAO.updatePlaylist(playlist, oldName);
  }

  static Future<void> addLyricToPlaylist(Playlist playlist, Lyric lyric) async {
    await PlaylistDAO.addLyricToPlaylist(playlist, lyric);
  }

  static Future<void> updatePlaylistSongs(
    Playlist playlist,
    List<Lyric> lyrics,
  ) async {
    List<int> newSongsID = [];
    for (var lyric in lyrics) {
      newSongsID.add(lyric.id);
    }
    
    await PlaylistDAO.updatePlaylistSongs(playlist, newSongsID);
  }

  static Future<void> deletePlaylist(Playlist playlist) async {
    await PlaylistDAO.deletePlaylist(playlist);
  }

  static Future<void> deleteLyricOnPlaylist(
    Playlist playlist,
    Lyric lyric,
  ) async {
    await PlaylistDAO.deleteLyricOnPlaylist(playlist, lyric);
  }
}
