import 'package:tononkira_pcl/entity/Category.dart';

class Lyric {
  late final int id;
  late final String title;
  late final String release;
  late final String author;
  late final String composer;
  late final List<String> verse;
  late final String refrain;
  // late final Category category;

  Lyric({
    required this.id,
    required this.title,
    required this.release,
    required this.author,
    required this.composer,
    required this.verse,
    required this.refrain,
    // required this.category,
  });

  factory Lyric.fromJson(Map<String, dynamic> json) {
    return Lyric(
      id: json['id'],
      title: json['title'],
      release: json['release'],
      author: json['author'],
      composer: json['composer'],
      verse: List<String>.from(json['verse']),
      refrain: json['refrain'],
      // category: Category.fromJson(json['category']),
    );
  }
}
