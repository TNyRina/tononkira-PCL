import 'dart:convert';

import 'package:flutter/foundation.dart' as fondation;
import 'package:flutter/services.dart';
import 'package:tononkira_pcl/entity/lyric.dart';

import '../entity/category.dart';


class LyricDAO {
  static const String _dataLyric = 'assets/data/lyric.json';
  static const String _dataCategory = 'assets/data/category.json';

  /// Charge tous les lyrics depuis le JSON
  static Future<List<Lyric>> loadLyrics() async {
    try {
      final String response = await rootBundle.loadString(_dataLyric);
      final List<dynamic> data = json.decode(response);

      return data.map((json) => Lyric.fromJson(json)).toList();
    } catch (e, stack) {
      _logError("Erreur lors du chargement des lyrics", e, stack);
      return [];
    }
  }

  /// Charge toutes les catégories depuis le JSON
  static Future<List<Category>> loadCategories() async {
    try {
      final String response = await rootBundle.loadString(_dataCategory);
      final List<dynamic> data = json.decode(response);

      return data.map((json) => Category.fromJson(json)).toList();
    } catch (e, stack) {
      _logError("Erreur lors du chargement des catégories", e, stack);
      return [];
    }
  }

  /// Récupère une catégorie par ID
  static Future<Category?> getCategory(int id) async {
    try {
      List<Category> allCategories = await loadCategories();
      return allCategories.firstWhere(
        (cat) => cat.id == id,
        orElse: () => Category(id: -1, name: "Inconnu"), // ou `null` si tu préfères
      );
    } catch (e, stack) {
      _logError("Erreur lors de la recherche de la catégorie $id", e, stack);
      return null;
    }
  }

  /// Logger d'erreurs
  static void _logError(String message, Object error, StackTrace stack) {
    if (fondation.kDebugMode) {
      print("$message : $error");
    }
    fondation.FlutterError.reportError(
      fondation.FlutterErrorDetails(
        exception: error,
        stack: stack,
        library: "LyricDAO",
        context: fondation.ErrorDescription(message),
      ),
    );
  }
}