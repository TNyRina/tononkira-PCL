import 'dart:convert';
import 'package:tononkira_pcl/dao/utility.dart';
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/entity/playlist.dart';
import 'package:tononkira_pcl/utility/exception.dart';

class PlaylistDAO {
  static Future<List<Playlist>> loadPlaylist() async {
    try {
      final files = await getAllPlaylistFile();
      final playlists = <Playlist>[];

      for (var file in files) {
        if (await isJsonFileExists(file)) {
          final data = readAndDecodeFile(file);
          playlists.add(Playlist.fromJson(await data));
        }
      }

      return sortObjectByAttribut(playlists, (p) => p.name);
    } catch (e, stack) {
      logError("Erreur lors du chargement des playlists", e, stack);

      return [];
    }
  }

  static Future<dynamic> getPlaylistJsonByName(String name) async {
    try {
      final files = await getAllPlaylistFile();
      late dynamic json;

      for (var file in files) {
        if (await isJsonFileExists(file)) {
          String playlistName = getPlaylistNameFromFileSystem(file);
          json = (name == playlistName) ? readAndDecodeFile(file) : null;
        }
      }

      return json;
    } catch (e, stack) {
      logError("Erreur lors du chargement de JSON playlist", e, stack);

      return null;
    }
  }

  static Future<Playlist?> getPlaylistByName(String name) async {
    try {
      final List<Playlist> playlits = await loadPlaylist();

      return playlits.firstWhere((p) => p.hasName(name));
    } catch (e, stack) {
      logError("Erreur lors du chargement du playlist $name", e, stack);
      return null;
    }
  }

  static Future<List<Lyric>> loadPlaylistSongs(Playlist playlist) async {
    try {
      final files = await getAllPlaylistFile();
      late List<Lyric> playlists;

      for (var file in files) {
        if (await isJsonFileExists(file)) {
          String playlistName = getPlaylistNameFromFileSystem(file);
          if (playlist.hasName(playlistName)) {
            playlists = await generatePlaylistSongFromJson(file);
          } 
        }
      }

      return playlists;
    } catch (e, stack) {
      logError(
        "Erreur lors du chargement des songs du playlist ${playlist.name}",
        e,
        stack,
      );

      return [];
    }
  }

  static Future<void> createPlaylist(Playlist playlist) async {
    try {
      if (!(await arleadyExistsInFileSystem(playlist.name))) {
        await _savePlaylist(playlist);
      } else {
        throw Exception("Le playlist ${playlist.name} exists deja !");
      }
    } catch (e, stack) {
      logError(
        "Erreur lors de la sauvegarde du playlist ${playlist.name}",
        e,
        stack,
      );

      throw Exception(getExceptionMessage(e.toString()));
    }
  }

  static Future<void> updatePlaylist(Playlist playlist, String oldName) async {
    if (oldName.isNotEmpty && !playlist.hasName(oldName)) {
      await deletePlaylist(Playlist(name: oldName, songsID: []));
    }
    await _savePlaylist(playlist);
  }

  static Future<void> deletePlaylist(Playlist playlist) async {
    try {
      final file = await getPlaylistFile(playlist);

      if (await file.exists()) {
        await file.delete();
      }
    } catch (e, stack) {
      logError(
        "Erreur lors de la suppression du playlist ${playlist.name}",
        e,
        stack,
      );
    }
  }

  static Future<void> addLyricToPlaylist(Playlist playlist, Lyric lyric) async {
    playlist.appendLyric(lyric);
    _savePlaylist(playlist);
  }

  static Future<void> updatePlaylistSongs(
    Playlist playlist,
    List<int> lyricsID,
  ) async {
    playlist.newLyricsID(lyricsID);
    _savePlaylist(playlist);
  }

  static Future<void> deleteLyricOnPlaylist(Playlist playlist,Lyric lyric,) async {
    playlist.deleteLyric(lyric);
    _savePlaylist(playlist);
  }

  static Future<void> _savePlaylist(Playlist playlist) async {
    try {
      final file = await getPlaylistFile(playlist);

      String jsonString = jsonEncode(playlist.toJson());

      await file.writeAsString(jsonString);
    } catch (e, stack) {
      logError(
        "Erreur lors de la sauvegarde du playlist ${playlist.name}",
        e,
        stack,
      );
    }
  }
}
