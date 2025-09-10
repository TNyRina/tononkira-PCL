import 'package:flutter/material.dart';

import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/service/lyric_service.dart';
import 'package:tononkira_pcl/utility/debugJSON.dart';
import 'package:tononkira_pcl/widget/shared/class/list_lyric.dart';
import 'package:tononkira_pcl/widget/shared/drawer.dart';
import 'package:tononkira_pcl/widget/shared/class/search_bar.dart' as sb;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Lyric>> lyrics;
  final textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    debugListJsonFiles();
    loadLyric();
    textEditingController.addListener(loadLyric);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: head(context),
      drawer: drawer(context),
      body: body(),
    );
  }

  Widget body() {
    return Column(
      children: [
        sb.SearchBar(controller: textEditingController),
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

                return ListLyric(songList: songList);
              }
            },
          ),
        ),
      ],
    );
  }

  void loadLyric() {
    String filter = textEditingController.text;
    setState(() {
      lyrics =
          (filter.isEmpty)
              ? LyricService.loadLyrics()
              : LyricService.filterByTitleLyrics(filter);
    });
  }

  AppBar head(BuildContext context) {
    return AppBar(
      title: Text('Tononkira PCL'),
      centerTitle: true,
      leading: Padding(
        padding: EdgeInsets.all(8.0),
        child: Image.asset('assets/img/logo_pcl.png'),
      ),
      actions: [
        Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            );
          },
        ),
      ],
    );
  }
}
