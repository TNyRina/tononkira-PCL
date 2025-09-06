class Lyric {
  late final int id;
  late final String title;
  late final String release;
  late final String author;
  late final String composer;
  late final List<String> verses;
  late final String refrain;
  late final List<int> categories;

  Lyric({
    required this.id,
    required this.title,
    required this.release,
    required this.author,
    required this.composer,
    required this.verses,
    required this.refrain,
    required this.categories,
  });

  factory Lyric.fromJson(Map<String, dynamic> json) {
    return Lyric(
      id: json['id'],
      title: json['title'],
      release: json['release'],
      author: json['author'],
      composer: json['composer'],
      verses: List<String>.from(json['verse']),
      refrain: json['refrain'],
      categories: List<int>.from(json['categories'] ?? []),
    );
  }

  
}
