import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tononkira_pcl/entity/lyric.dart';

import '../entity/category.dart';

class LyricDAO {
  static final  String _dataLyric = 'assets/data/lyric.json';
  static final  String _dataCtegory = 'assets/data/category.json';

  static Future<List<Lyric>> loadLyrics() async {
    final String response = await rootBundle.loadString(_dataLyric);
    final List<dynamic> data = json.decode(response);

    return data.map((json) => Lyric.fromJson(json)).toList();
  }

  static Future<List<Category>> loadCategories() async {
    final String response = await rootBundle.loadString(_dataCtegory);
    final List<dynamic> data = json.decode(response);

    return data.map((json) => Category.fromJson(json)).toList();
  }

  static Future<Category?> getCategory(int id) async {
    List<Category> allCategories = await loadCategories();

    final filtered = allCategories.where((cat) => cat.id == id);
    
    return filtered.isNotEmpty ? filtered.first : null;
  }
}
