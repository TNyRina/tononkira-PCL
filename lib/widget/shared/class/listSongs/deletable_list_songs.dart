import 'package:flutter/material.dart';
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/entity/playlist.dart';
import 'package:tononkira_pcl/service/playlist_service.dart';
import 'package:tononkira_pcl/widget/shared/class/listSongs/list_songs.dart';
import 'package:tononkira_pcl/widget/shared/notification.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';

class DeletableListLyric extends ListSongs {
  final Playlist playlist;
  final Function(bool) enabledSaveButton;
  final Function(List<Lyric>) getNewSongsPlaylist;

  const DeletableListLyric({
    super.key,
    required super.songList,
    required this.playlist,
    required this.enabledSaveButton,
    required this.getNewSongsPlaylist,
  });

  @override
  State<StatefulWidget> createState() => _DeletableListLyricState();
}

class _DeletableListLyricState extends ListSongsState<DeletableListLyric> {
  late bool elementIsDragged;

  @override
  void initState() {
    super.initState();
    elementIsDragged = false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ReorderableListView(
        children: [
          for (int index = 0; index < songs.length; index++)
            Container(
              key: ValueKey(songs[index].id), // clé unique
              margin: const EdgeInsets.only(bottom: 5), // espace entre éléments
              color: TColor.teritary,
              child: buildListTile(songs[index]),
            ),
        ],
        onReorder: (int oldIndex, int newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex -= 1;
            final song = songs.removeAt(oldIndex);
            songs.insert(newIndex, song);
            widget.getNewSongsPlaylist(songs);
            widget.enabledSaveButton(true);
          });
        },
      ),
    );
  }

  @override
  Widget buildListTile(Lyric song) {
    return ListTile(
      onTap: () => nextPage(song),
      title: Text(song.title),
      trailing: IconButton(
        icon: Icon(Icons.delete, color: TColor.danger),
        onPressed: () => showDeleteDialog(song),
      ),
    );
  }

  void showDeleteDialog(Lyric lyric) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            iconColor: TColor.danger,
            icon: Icon(Icons.warning),
            content: Text(
              "Voulez vous vraiment supprimer \"${lyric.title}\" du playlist \"${widget.playlist.name}\"?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Annuler"),
              ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(TColor.danger)),
                onPressed: () async {
                  await deleteLyric(lyric);
                  notification(context, "Suppression reussit !");
                  Navigator.pop(context);
                },
                child: const Text("Supprimer", style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
    );
  }



  Future<void> deleteLyric(Lyric lyric) async {
    await PlaylistService.deleteLyricOnPlaylist(widget.playlist, lyric);
    setState(() => songs.remove(lyric));
  }
}
