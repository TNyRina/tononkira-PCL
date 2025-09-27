import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' as fondation;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:tononkira_pcl/dao/lyric_dao.dart';
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/entity/playlist.dart';

void logError(String message, Object error, StackTrace stack) {
  if (fondation.kDebugMode) {
    print("$message : $error");
  }
  fondation.FlutterError.reportError(
    fondation.FlutterErrorDetails(
      exception: error,
      stack: stack,
      library: "DAO",
      context: fondation.ErrorDescription(message),
    ),
  );
}

void log(String message) {
  if (fondation.kDebugMode) {
    print("$message : $message");
  }
}

String getPlaylistNameFromFileSystem(FileSystemEntity file) {
  String jsonName = path.basename(file.path);
  return jsonName.replaceAll(".json", "");
}

bool isJsonFile(FileSystemEntity file) {
  return (file is File && file.path.endsWith(".json"));
}

Future<bool> arleadyExistsInFileSystem(String name) async {
  final dir = await getApplicationDocumentsDirectory();
  final files = await dir.list().toList();

  final playlistsName = <String>[];

  for (var file in files) {
    if (file is File && isJsonFile(file)) {
      if (await file.exists()) {
        playlistsName.add(getPlaylistNameFromFileSystem(file));
      }
    }
  }

  return playlistsName.contains(name);
}

List<T> sortObjectByAttribut<T>(
  List<T> object,
  Comparable Function(T) getAttr,
) {
  object.sort((a, b) => getAttr(a).compareTo(getAttr(b)));

  return object;
}

Future<bool> isJsonFileExists(FileSystemEntity file) async {
  return (isJsonFile(file) && await file.exists());
}

Future<dynamic> readAndDecodeFile(FileSystemEntity entity) async {
  final file = entity as File;
  final content = await file.readAsString();

  return jsonDecode(content);
}

Future<List<Lyric>> generatePlaylistSongFromJson(FileSystemEntity file) async {
  final playlists = <Lyric>[];

  final json = await readAndDecodeFile(file);
  final songsID = json['songs'];
  for (var id in songsID) {
    Lyric? lyric = await LyricDAO.getLyricByID(id);
    if (lyric != null) {
      playlists.add(lyric);
    }
  }

  return playlists;
}

Future<File> getPlaylistFile(Playlist playlist) async {
  final directory = await getApplicationDocumentsDirectory();

  return  File('${directory.path}/${playlist.name.toLowerCase()}.json',
      );
}

Future<List<FileSystemEntity>> getAllPlaylistFile() async{
  final dir = await getApplicationDocumentsDirectory();
  return  await dir.list().toList();
}
