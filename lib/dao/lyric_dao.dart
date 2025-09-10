import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tononkira_pcl/dao/utility.dart';
import 'package:tononkira_pcl/entity/lyric.dart';

import '../entity/category.dart';

class LyricDAO {
  static const String _dataLyric = 'assets/data/lyric.json';

  static Future<List<Lyric>> loadLyrics() async {
    try {
      final String response = await rootBundle.loadString(_dataLyric);
      final List<dynamic> data = json.decode(response);

      return data.map((json) => Lyric.fromJson(json)).toList();
    } catch (e, stack) {
      logError("Erreur lors du chargement des lyrics", e, stack);
      return [];
    }
  }

  static Future<Lyric?> getLyricByID(int id) async {
    try {
      final List<Lyric> lyrics = await loadLyrics();

      return lyrics.firstWhere(
      (l) => l.id == id
    );
    } catch (e, stack) {
      logError("Erreur lors du chargement du lyric avec l'ID $id", e, stack);
      return null;
    }
  }

  static Future<List<Lyric>> filterByTitleLyrics(String filter) async {
    List<Lyric> allLyric = await loadLyrics();

    return allLyric
        .where(
          (lyric) =>
              ((lyric.title).toLowerCase()).contains(filter.toLowerCase()),
        )
        .toList();
  }

  static Future<List<Lyric>> filterByCategoryLyrics(Category category) async {
    List<Lyric> allLyric = await loadLyrics();

    return allLyric
        .where((lyric) => (lyric.categories).contains(category.id))
        .toList();
  }

  static Future<List<Lyric>> filterByTitleAndCategoryLyrics(
    Category category,
    String filter,
  ) async {
    List<Lyric> lyricFilteredByCategory = await filterByCategoryLyrics(
      category,
    );

    return lyricFilteredByCategory
        .where(
          (lyric) =>
              ((lyric.title).toLowerCase()).contains(filter.toLowerCase()),
        )
        .toList();
  }
}