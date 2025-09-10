import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tononkira_pcl/dao/utility.dart';

import '../entity/category.dart';

class CategoryDAO {
  static const String _dataCategory = 'assets/data/category.json';

  static Future<List<Category>> loadCategories() async {
    try {
      final String response = await rootBundle.loadString(_dataCategory);
      final List<dynamic> data = json.decode(response);

      return data.map((json) => Category.fromJson(json)).toList();
    } catch (e, stack) {
      logError("Erreur lors du chargement des catégories", e, stack);
      return [];
    }
  }

  static Future<Category?> getCategory(int id) async {
    try {
      List<Category> allCategories = await loadCategories();
      return allCategories.firstWhere(
        (cat) => cat.id == id,
        orElse:
            () => Category(id: -1, name: "Inconnu"), 
      );
    } catch (e, stack) {
      logError("Erreur lors de la recherche de la catégorie $id", e, stack);
      return null;
    }
  }
}
