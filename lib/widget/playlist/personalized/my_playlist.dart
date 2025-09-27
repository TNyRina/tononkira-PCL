import 'package:flutter/material.dart';
import 'package:tononkira_pcl/widget/playlist/personalized/shared/playlist_list.dart';
import 'package:tononkira_pcl/widget/shared/class/head.dart';
import 'package:tononkira_pcl/widget/shared/drawer.dart';

class MyPlaylist extends StatefulWidget {
  const MyPlaylist({super.key});

  @override
  State<StatefulWidget> createState() => _MyPlaylist();
}

class _MyPlaylist extends State<MyPlaylist> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Head(context: context, title: "My plylist").build(),
      body: PlaylistList(),
      drawer: drawer(context),
    );
  }
}
