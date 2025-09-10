import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/utility/convert_date.dart';

class Playlist {
  final String name;
  final List<int> songsID;
  final String? description;
  final DateTime? createdAt;

  Playlist({
    required this.name,
    required this.songsID,
    this.description,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      name: json['name'],
      songsID: List<int>.from(json['songs']),
      description: json['description'],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'songs': songsID,
      'description': description,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  String? getCreatedDate() {
    return ConvertDate(datetime: createdAt!).formatFR();
  }

  String getDate(){
    return createdAt!.toString();
  }

  bool hasName(String name) {
    return this.name.toLowerCase() == name.toLowerCase();
  }

  void appendLyric(Lyric lyric) {
    songsID.toSet().toList();

    if (!songsID.contains(lyric.id)) {
      songsID.add(lyric.id);
    }
  }

  void deleteLyric(Lyric lyric) {
    songsID.toSet().toList();

    if (songsID.contains(lyric.id)) {
      songsID.remove(lyric.id);
    }
  }
}
