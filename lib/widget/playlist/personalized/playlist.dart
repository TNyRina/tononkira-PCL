import 'package:flutter/material.dart';

import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/entity/playlist.dart';
import 'package:tononkira_pcl/service/playlist_service.dart';
import 'package:tononkira_pcl/widget/shared/class/list_lyric.dart';
import 'package:tononkira_pcl/widget/shared/drawer.dart';

import 'package:tononkira_pcl/widget/shared/head.dart';

class PersonalizedPlaylist extends StatefulWidget {
  final Playlist playlist;

  const PersonalizedPlaylist({super.key, required this.playlist});

  @override
  State<StatefulWidget> createState() => _PersonalizedPlaylist();
}

class _PersonalizedPlaylist extends State<PersonalizedPlaylist> {
  late List<Lyric> songList;
  late Future<List<Lyric>> lyrics;
  @override
  void initState() {
    super.initState();
    lyrics = PlaylistService.loadPlaylistSongs(widget.playlist);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: head(context, "My Playlist ${widget.playlist.name}"),
      drawer: drawer(context),
      body: body(),
    );
  }

  Widget body() {
    return FutureBuilder<List<Lyric>>(
        future: lyrics,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Aucune chanson dans la playlist"));
          } else {
            return ListLyric(
              songList: snapshot.data!,
              playlist: widget.playlist,
              deletable: true,
            );
          }
        },
      );
  }
}
