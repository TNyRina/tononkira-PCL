import 'package:flutter/material.dart';

import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/service/lyric_service.dart';
import 'package:tononkira_pcl/utility/debugJSON.dart';
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
    debugListJsonFiles();
    loadLyric();
    filterEdtingController.addListener(loadLyric);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Head(context: context, home: true).build(),
      drawer: drawer(context),
      body: body(),
    );
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
      lyrics =
          (filter.isEmpty)
              ? LyricService.loadLyrics()
              : LyricService.filterByTitleLyrics(filter);
    });
  }
}
