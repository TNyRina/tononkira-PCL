import 'package:tononkira_pcl/dao/lyric_dao.dart';
import 'package:tononkira_pcl/entity/category.dart';
import 'package:tononkira_pcl/entity/lyric.dart';

class LyricService {
  static Future<List<Lyric>> loadLyrics() async {
    return await LyricDAO.loadLyrics();
  }

  static Future<List<Lyric>> filterByTitleLyrics(String filter) async {
    return await LyricDAO.filterByTitleLyrics(filter);
  }

  static Future<List<Lyric>> filterByTitleAndCategoryLyrics(
    Category category,
    String filter,
  ) async {
    return await LyricDAO.filterByTitleAndCategoryLyrics(category, filter);
  }

  static Future<List<Lyric>> filterByCategoryLyrics(Category category) async {
    return await LyricDAO.filterByCategoryLyrics(category);
  }
}
