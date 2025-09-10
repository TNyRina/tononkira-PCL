import "package:flutter/material.dart";
import "package:tononkira_pcl/entity/lyric.dart";
import "package:tononkira_pcl/entity/playlist.dart";
import "package:tononkira_pcl/service/playlist_service.dart";
import "package:tononkira_pcl/widget/playlist/personalized/my_playlist.dart";
import "package:tononkira_pcl/widget/playlist/personalized/shared/playlist_list.dart";

class AddToPlaylist extends StatefulWidget {
  final Lyric lyric;
  const AddToPlaylist({super.key, required this.lyric});

  @override
  State<StatefulWidget> createState() => _AddToPlaylist();
}

class _AddToPlaylist extends State<AddToPlaylist> {
  late Future<List<Playlist>> playlists;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _playlistNameController = TextEditingController();
  final TextEditingController _playlistDescriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

    playlists = PlaylistService.loadPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(), body: PlaylistList(lyric: widget.lyric));
  }

  AppBar appBar() {
    return AppBar(
      title: Text("Ajouter dans un playlist"),
      actions: [
        IconButton(
          onPressed: () => onPressedAddButton(widget.lyric),
          icon: Icon(Icons.add_box),
        ),
      ],
    );
  }

  void onPressedAddButton(Lyric lyric) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Créer un nouveau playlist"),
          content: form(),
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
                if (_formKey.currentState!.validate()) {
                  newPlaylist(_playlistNameController.text, [widget.lyric], _playlistDescriptionController.text);

                  Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) => MyPlaylist()));
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _playlistNameController,
            decoration: const InputDecoration(hintText: 'Playlist name'),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _playlistDescriptionController,
            decoration: const InputDecoration(hintText: 'Playlist description')
          )
        ],
      ),
    );
  }

  void newPlaylist(String name, List<Lyric> songs, String? description) {
    PlaylistService.newPlaylist(name, [widget.lyric.id], description!);
  }
}
