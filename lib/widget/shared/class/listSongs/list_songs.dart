import 'package:flutter/material.dart';
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/widget/lyric/lyric.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';

abstract class ListSongs extends StatefulWidget {
  final List<Lyric> songList;
  const ListSongs({super.key, required this.songList});

  @override
  State<StatefulWidget> createState();
}

abstract class ListSongsState<T extends ListSongs> extends State<T> {
  late List<Lyric> songs;

  @override
  void initState() {
    super.initState();
    songs = List.from(widget.songList);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: songs.length,
        separatorBuilder: (context, index) => SizedBox(height: 5),
        itemBuilder: (context, index) {
          final song = songs[index];
          return Container(
            color: TColor.teritary,
            child: buildListTile(song)
          );
        },
      ),
    );
  }

  Widget buildListTile(Lyric song);

  void nextPage(Lyric song) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ShowLyric(lyric: song)),
    );
  }
}
