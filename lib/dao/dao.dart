import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tononkira_pcl/dao/utility.dart';

abstract class DAO<T> {

  String get dataPath;
  
  T fromJson(Map<String, dynamic> json);
  Comparable<dynamic> sortKey(T obj);

  Future<List<T>> loadData() async {
    try {
      final String response = await rootBundle.loadString('assets/data/testAdmin/$dataPath');
      final List<dynamic> data = json.decode(response);

      List<T> list = data.map((json) => fromJson(json)).toList();
      return sortObjectByAttribut(list, sortKey);
    } catch (e, stack) {
      logError("Erreur lors du chargement des données", e, stack);
      return [];
    }
  }
}
