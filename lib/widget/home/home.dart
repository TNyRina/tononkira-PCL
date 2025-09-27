import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io'; 
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/service/lyric_service.dart';
import 'package:tononkira_pcl/widget/shared/class/head.dart';
import 'package:tononkira_pcl/widget/shared/class/listSongs/default_list_songs.dart';
import 'package:tononkira_pcl/widget/shared/drawer.dart';
import 'package:tononkira_pcl/widget/shared/class/search_bar.dart' as sb;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Lyric>> lyrics;
  final filterEdtingController = TextEditingController();

  @override
  void dispose() {
    filterEdtingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadLyric();
    filterEdtingController.addListener(loadLyric);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }

        if (await _onWillPop(context)) {
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          }
        }
      },
      child: Scaffold(appBar: Head(context: context, home: true).build(), drawer: drawer(context), body: body()),
    );

    
  }

  Future<bool> _onWillPop(BuildContext context) async{
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirmer la sortie'),
            content: const Text('Voulez-vous vraiment quitter l\'application ?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Non'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Oui'),
              ),
            ],
          ),
        ) ?? false;
  }

  Widget body() {
    return Column(
      children: [
        sb.SearchBar(controller: filterEdtingController),
        Expanded(
          child: FutureBuilder<List<Lyric>>(
            future: lyrics,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur : ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Aucune chanson trouvée'));
              } else {
                final List<Lyric> songList = snapshot.data!;

                return DefaultListSongs(songList: songList);
              }
            },
          ),
        ),
      ],
    );
  }

  void loadLyric() {
    String filter = filterEdtingController.text;
    setState(() {
      lyrics = (filter.isEmpty) ? LyricService.loadLyrics() : LyricService.filterByTitleLyrics(filter);
    });
  }
}
