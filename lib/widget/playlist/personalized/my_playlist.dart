import 'package:flutter/material.dart';
import 'package:tononkira_pcl/widget/playlist/personalized/shared/playlist_list.dart';
import 'package:tononkira_pcl/widget/shared/drawer.dart';
import 'package:tononkira_pcl/widget/shared/head.dart';

class MyPlaylist extends StatefulWidget {
  const MyPlaylist({super.key});

  @override
  State<StatefulWidget> createState() => _MyPlaylist();
}

class _MyPlaylist extends State<MyPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: head(context, "My playlist"),
      body: PlaylistList(),
      drawer: drawer(context),
    );
  }
}
