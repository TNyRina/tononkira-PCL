import 'package:flutter/material.dart';
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/entity/playlist.dart';
import 'package:tononkira_pcl/service/playlist_service.dart';
import 'package:tononkira_pcl/widget/lyric/lyric.dart';
import 'package:tononkira_pcl/widget/playlist/personalized/add_to_playlist.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';
import 'package:tononkira_pcl/widget/theme/tfont.dart';
import 'package:tononkira_pcl/widget/theme/tradius.dart';

class ListLyric extends StatefulWidget {
  final List<Lyric> songList;
  final bool? deletable;
  final Playlist? playlist;
  const ListLyric({super.key, required this.songList, this.deletable = false, this.playlist});

  @override
  State<StatefulWidget> createState() => _ListLyric();
}

class _ListLyric extends State<ListLyric> {
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
        itemBuilder: (context, index) {
          final Lyric song = songs[index];
          return listTile(context, song);
        },
        separatorBuilder: (context, index) => SizedBox(height: 5),
      ),
    );
  }

  Container listTile(BuildContext context, Lyric song) {
    return Container(
      decoration: BoxDecoration(
        color: TColor.primary,
        borderRadius: BorderRadius.circular(TRadius.small),
      ),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => ShowLyric(lyric: song),
            ),
          );
        },
        title: Text(
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: TFont.h2,
          ),
          song.title,
        ),
        trailing: trailing(song),
      ),
    );
  }

  Widget trailing(Lyric song) {
    return widget.deletable!
        ? IconButton(
          onPressed: () {
            showDeleteDialog(widget.playlist!, song);
          },
          icon: Icon(Icons.delete_rounded, color: TColor.danger),
        )
        : IconButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => AddToPlaylist(lyric: song),
              ),
            );
          },
          icon: Icon(Icons.playlist_add_sharp, color: TColor.secondary),
        );
  }

  void showDeleteDialog(Playlist playlist, Lyric lyric) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Avertissement", style: TextStyle(color: TColor.danger)),
          icon: Icon(Icons.dangerous),
          content: Text(
            "Voulez vous vraiment supprimer ${lyric.title} dans le playlist ${playlist.name} ?",
          ),
          actions: [
            TextButton(
              child: const Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text("OK"),
              onPressed: () {
                deleteLyric(playlist, lyric);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deleteLyric(Playlist playlist, Lyric lyric) async {
    await PlaylistService.deleteLyricOnPlaylist(playlist, lyric);

    setState(() {
      songs.remove(lyric);
    });
  }
}
