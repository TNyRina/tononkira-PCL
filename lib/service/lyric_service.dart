import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tononkira_pcl/entity/Lyric.dart';

class SongService {
  static Future<List<Lyric>> loadLyrics() async {
    final String response = await rootBundle.loadString(
      'assets/data/lyric.json',
    );
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Lyric.fromJson(json)).toList();
  }
}
