import 'package:flutter/material.dart';
import 'package:tononkira_pcl/entity/category.dart';

import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/service/lyric_service.dart';
import 'package:tononkira_pcl/widget/shared/class/list_lyric.dart';
import 'package:tononkira_pcl/widget/shared/drawer.dart';

import 'package:tononkira_pcl/widget/shared/head.dart';
import 'package:tononkira_pcl/widget/shared/class/search_bar.dart' as sb;

class DefaultPlaylist extends StatefulWidget {
  final Category category;

  const DefaultPlaylist({super.key, required this.category});

  @override
  State<StatefulWidget> createState() => _DefaultPlaylist();
}

class _DefaultPlaylist extends State<DefaultPlaylist> {
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

    loadLyric();
    textEditingController.addListener(loadLyric);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: head(context, "Playlist ${widget.category.name}"),
      drawer: drawer(context),
      body: body()
    );
  }

 void loadLyric() {
    String filter = textEditingController.text;
    setState(() {
      lyrics =
          (filter.isEmpty)
              ? LyricService.filterByCategoryLyrics(widget.category)
              : LyricService.filterByTitleAndCategoryLyrics(widget.category, filter);
    });
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
}
