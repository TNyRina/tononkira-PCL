import 'package:flutter/material.dart';

import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/service/lyric_service.dart';

import 'package:tononkira_pcl/widget/home/head.dart';
import 'package:tononkira_pcl/widget/home/body.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Lyric>> lyrics;

  @override
  void initState() {
    super.initState();
    lyrics = LyricService.loadLyrics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: head(), body: body(lyrics));
  }
}
