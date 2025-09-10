import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<void> debugListJsonFiles() async {
  try {
    final dir = await getApplicationDocumentsDirectory();
    final files = dir.listSync().where((f) => f.path.endsWith('.json'));

    if (files.isEmpty) {
      print("Aucun fichier JSON trouvé dans ${dir.path}");
      return;
    }

    print("Fichiers JSON dans ${dir.path} :");
    for (var file in files) {
      if (file is File) {
        final content = await file.readAsString();
        print("-----");
        print("Nom : ${file.path.split('/').last}");
        print("Contenu : $content");
      }
    }
  } catch (e) {
    print("Erreur lors de la lecture des fichiers JSON : $e");
  }
}