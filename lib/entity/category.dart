class Category {
  final int id;
  final String name;
  set name(String value) => name = value;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    final dynamic rawId = json['id'];

    return Category(
      id: rawId is int ? rawId : int.tryParse(rawId.toString()) ?? -1,
      name: json['name'].toString(),
    );
  }
}
