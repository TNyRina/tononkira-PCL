import 'package:tononkira_pcl/dao/lyric_dao.dart';
import 'package:tononkira_pcl/entity/category.dart';
import 'package:tononkira_pcl/entity/lyric.dart';

class LyricService {
  static Future<List<Lyric>> loadLyrics() async {
    return LyricDAO.loadLyrics();
  }

  static Future<List<Lyric>> filterByTitleLyrics(String filter) async {
    return LyricDAO.filterByTitleLyrics(filter);
  }

  static Future<List<Lyric>> filterByTitleAndCategoryLyrics(
    Category category,
    String filter,
  ) async {
    return LyricDAO.filterByTitleAndCategoryLyrics(category, filter);
  }

  static Future<List<Lyric>> filterByCategoryLyrics(Category category) async {
    return LyricDAO.filterByCategoryLyrics(category);
  }
}
