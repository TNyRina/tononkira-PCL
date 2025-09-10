import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:tononkira_pcl/dao/lyric_dao.dart';
import 'package:tononkira_pcl/dao/utility.dart';
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/entity/playlist.dart';

class PlaylistDAO {
  static Future<List<Playlist>> loadPlaylist() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final files = dir.listSync();

      final playlists = <Playlist>[];

      for (var file in files) {
        if (file is File && file.path.endsWith('.json')) {
          if (await file.exists()) {
            // ✅ sécurité ajoutée
            final content = await file.readAsString();
            final data = jsonDecode(content);
            playlists.add(Playlist.fromJson(data));
          }
        }
      }

      return playlists;
    } catch (e, stack) {
      logError("Erreur lors du chargement des playlists", e, stack);

      return [];
    }
  }

  static Future<dynamic> getPlaylistJsonByName(String name) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final files = dir.listSync();

      late dynamic json;

      for (var file in files) {
        if (file is File && file.path.endsWith('.json')) {
          String jsonName = p.basename(file.path);
          String playlistName = jsonName.replaceAll(".json", "");
          if (name == playlistName) {
            final content = await file.readAsString();
            json = jsonDecode(content);
          }
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
      final dir = await getApplicationDocumentsDirectory();
      final files = dir.listSync();

      final playlists = <Lyric>[];

      for (var file in files) {
        if (file is File && file.path.endsWith(".json")) {
          String jsonName = p.basename(file.path);
          String playlistName = jsonName.replaceAll(".json", "");
          if (playlist.hasName(playlistName)) {
            final content = await file.readAsString();
            final json = jsonDecode(content);
            final songsID = json['songs'];
            for (var id in songsID) {
              Lyric? lyric = await LyricDAO.getLyricByID(id);
              if (lyric != null) {
                playlists.add(lyric);
              }
            }
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

  static Future<void> savePlaylist(Playlist playlist) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${playlist.name}.json');

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

  static Future<void> deletePlaylist(Playlist playlist) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/${playlist.name}.json');

      if (await file.exists()) {
        await file.delete();
      }
    } catch (e, stack) {
      logError(
        "Erreur lors de la sauvegarde du playlist ${playlist.name}",
        e,
        stack,
      );
    }
  }

  static Future<void> addLyricToPlaylist(Playlist playlist, Lyric lyric) async {
    playlist.appendLyric(lyric);
    savePlaylist(playlist);
  }

  static Future<void> deleteLyricOnPlaylist(Playlist playlist, Lyric lyric,) async {
    playlist.deleteLyric(lyric);
    savePlaylist(playlist);
  }
}
