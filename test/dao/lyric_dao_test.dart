import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tononkira_pcl/entity/category.dart';

void main() {
  test('Charge les catégories depuis un fichier JSON', () async {
    // Charger le fichier JSON depuis les assets (comme le fait la méthode)
    final String response = await rootBundle.loadString(
      'assets/data/categories.json',
    );

    final List<dynamic> data = json.decode(response);
    final List<Category> categories =
        data.map((json) => Category.fromJson(json)).toList();

    categories.forEach((cat) {
      print(cat);
    });

    expect(categories.isNotEmpty, true);
    expect(categories.first, isA<Category>());
    expect(categories.first.id, isNotNull); // adapte selon ta classe
  });
}
