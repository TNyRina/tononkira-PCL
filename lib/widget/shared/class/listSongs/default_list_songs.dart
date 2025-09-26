import 'package:flutter/material.dart';
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/widget/playlist/personalized/add_to_playlist.dart';
import 'package:tononkira_pcl/widget/shared/class/listSongs/list_songs.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';

class DefaultListSongs extends ListSongs {
  const DefaultListSongs({super.key, required super.songList});

  @override
  State<StatefulWidget> createState() => _DefaultListSongs();
}

class _DefaultListSongs extends ListSongsState<DefaultListSongs> {
  @override
  Widget buildListTile(Lyric song) {
    return ListTile(
      onTap: () => nextPage(song),
      title: Text(song.title),
      trailing: IconButton(
        icon: Icon(Icons.playlist_add, color: TColor.primary),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddToPlaylist(lyric: song)),
          );
        },
      ),
    );
  }
}
