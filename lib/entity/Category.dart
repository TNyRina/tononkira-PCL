class Category {
  final Map<String, String> event;
  final Map<String, String> rhythm;

  Category({
    required this.event,
    required this.rhythm,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      event: Map<String, String>.from(json['event']),
      rhythm: Map<String, String>.from(json['rhythm']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'event': event,
      'rhythm': rhythm,
    };
  }
}
