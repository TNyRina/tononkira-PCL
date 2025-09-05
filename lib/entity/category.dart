import 'package:tononkira_pcl/dao/lyric_dao.dart';

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(MapEntry<String, dynamic> entry) {
    return Category(id: int.parse(entry.key), name: entry.value);
  }

  String getName(int id) {
    return name;
  }
}
