import "package:flutter/material.dart";
import "package:toastification/toastification.dart";
import "package:tononkira_pcl/entity/lyric.dart";
import "package:tononkira_pcl/entity/playlist.dart";
import "package:tononkira_pcl/service/playlist_service.dart";
import "package:tononkira_pcl/utility/exception.dart";
import "package:tononkira_pcl/widget/playlist/personalized/my_playlist.dart";
import "package:tononkira_pcl/widget/playlist/personalized/shared/playlist_form.dart";
import "package:tononkira_pcl/widget/playlist/personalized/shared/playlist_list.dart";
import "package:tononkira_pcl/widget/shared/class/head.dart";
import "package:tononkira_pcl/widget/shared/drawer.dart";
import "package:tononkira_pcl/widget/shared/floating_action_button.dart";
import "package:tononkira_pcl/widget/shared/notification.dart";
import "package:tononkira_pcl/widget/theme/tcolor.dart";

class AddToPlaylist extends StatefulWidget {
  final Lyric lyric;
  const AddToPlaylist({super.key, required this.lyric});

  @override
  State<StatefulWidget> createState() => _AddToPlaylist();
}

class _AddToPlaylist extends State<AddToPlaylist> {
  late String title;
  late Future<List<Playlist>> playlists;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _playlistNameController = TextEditingController();
  final TextEditingController _playlistDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    title = "Ajouter dans un playlist";
    playlists = PlaylistService.loadPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Head(context: context, title: title).build(),
      body: PlaylistList(lyric: widget.lyric),
      floatingActionButton: floatingActionButton(
        () => onPressedActionButton("Créer un nouveau playlist"),
        Icons.add_box,
      ),
      drawer: drawer(context),
    );
  }

  void onPressedActionButton(String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              color: TColor.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: PlaylistForm.build(
            formKey: _formKey,
            nameController: _playlistNameController,
            descritpionController: _playlistDescriptionController,
          ),
          actions: [
            TextButton(
              child: const Text("Annuler"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(TColor.primary),
                iconColor: WidgetStatePropertyAll(TColor.secondary),
              ),
              icon: Icon(Icons.save),
              label: const Text(
                "Enregistrer",
                style: TextStyle(color: TColor.secondary),
              ),
              onPressed:
                  () => {
                    if (_formKey.currentState!.validate()) {onSubmit()},
                  },
            ),
          ],
        );
      },
    );
  }

  void onSubmit() async {
    await newPlaylist(_playlistNameController.text, [
      widget.lyric,
    ], _playlistDescriptionController.text);

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder:
            (context) => MyPlaylist(),
      ),
    );
  }

  Future<void> newPlaylist(
    String name,
    List<Lyric> songs,
    String? description,
  ) async {
    try {
      await PlaylistService.newPlaylist(name, [widget.lyric.id], description!);
      notification(context, "Le playlist ${_playlistNameController.text} est bien créé");
    } catch (e) {
      notification(context, getExceptionMessage(e.toString()), ToastificationType.error);
    }
  }
}
