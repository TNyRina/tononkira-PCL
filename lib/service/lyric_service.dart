import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tononkira_pcl/dao/lyric_dao.dart';
import 'package:tononkira_pcl/entity/lyric.dart';

class LyricService {
  static Future<List<Lyric>> loadLyrics() async {
    return LyricDAO.loadLyrics();
  }
}
