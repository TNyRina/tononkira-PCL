import 'package:tononkira_pcl/dao/playlist_dao.dart';
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/entity/playlist.dart';

class PlaylistService {
  static Future<List<Playlist>> loadPlaylist() async {
    return PlaylistDAO.loadPlaylist();
  }

  static Future<List<Lyric>> loadPlaylistSongs(Playlist playlist) async {
    return PlaylistDAO.loadPlaylistSongs(playlist);
  }

  static Future<void> newPlaylist(String name, List<int> songs, String description) async {
    PlaylistDAO.savePlaylist(Playlist(name: name, songsID: songs, description: description));
  }

  static Future<void> addLyricToPlaylist(Playlist playlist, Lyric lyric) async {
    PlaylistDAO.addLyricToPlaylist(playlist, lyric);
  }

  static Future<void> deletePlaylist(Playlist playlist) async {
    PlaylistDAO.deletePlaylist(playlist);
  }

  static Future<void> deleteLyricOnPlaylist(Playlist playlist, Lyric lyric) async {
    PlaylistDAO.deleteLyricOnPlaylist(playlist, lyric);
  }
}
