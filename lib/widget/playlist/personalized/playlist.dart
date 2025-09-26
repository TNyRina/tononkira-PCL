import 'package:flutter/material.dart';

import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/entity/playlist.dart';
import 'package:tononkira_pcl/service/playlist_service.dart';
import 'package:tononkira_pcl/widget/playlist/personalized/my_playlist.dart';
import 'package:tononkira_pcl/widget/playlist/personalized/shared/playlist_form.dart';
import 'package:tononkira_pcl/widget/shared/class/head.dart';
import 'package:tononkira_pcl/widget/shared/class/listSongs/deletable_list_songs.dart';
import 'package:tononkira_pcl/widget/shared/drawer.dart';
import 'package:tononkira_pcl/widget/shared/floating_action_button.dart';
import 'package:tononkira_pcl/widget/shared/notification.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';
import 'package:tononkira_pcl/widget/theme/tfont.dart';

class PersonalizedPlaylist extends StatefulWidget {
  final Playlist playlist;
  final String? notification;

  const PersonalizedPlaylist({
    super.key,
    required this.playlist,
    this.notification,
  });

  @override
  State<StatefulWidget> createState() => _PersonalizedPlaylist();
}

class _PersonalizedPlaylist extends State<PersonalizedPlaylist> {
  late String title;
  late List<Lyric> songList, newSongsPlaylist;
  late Future<List<Lyric>> lyrics;
  late bool enabledSaveButton;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _playlistNameController = TextEditingController();
  final TextEditingController _playlistDescriptionController =
      TextEditingController();

  @override
  void initState() {
    super.initState();

    enabledSaveButton = false;
    title = "My Playlist ${widget.playlist.name}";

    lyrics = PlaylistService.loadPlaylistSongs(widget.playlist);

    _playlistNameController.text = widget.playlist.name;
    _playlistDescriptionController.text = widget.playlist.description!;

    if (widget.notification != null) {
      notification(context, widget.notification!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Head(context: context, title: title).build(),
      body: body(),
      floatingActionButton: _floatingbuttonAction(),
      drawer: drawer(context),
    );
  }

  Widget _floatingbuttonAction() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        floatingActionButton(
          () => onPressedActionButton("Modifier le playlist"),
          Icons.edit_note_rounded,
        ),
        SizedBox(height: 12.0),
        FloatingActionButton(
          onPressed: () async {
            await PlaylistService.updatePlaylistSongs(
              widget.playlist,
              newSongsPlaylist,
            );

            setState(() {
              enabledSaveButton = false;
              newSongsPlaylist = [];
            });

            notification(context, "Ordre playlist sauvegardé !");
          },
          backgroundColor: TColor.teritary,
          elevation: enabledSaveButton ? 2 : 0,
          child: Icon(
            Icons.save_alt_rounded,
            color: enabledSaveButton ? TColor.primary : Colors.white,
          ),
        ),
      ],
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
          return buildBody(context, snapshot);
        }
      },
    );
  }

  Widget buildBody(BuildContext context, AsyncSnapshot<List<Lyric>> snapshot) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.playlist.name,
                style: TextStyle(
                  fontSize: TFont.h1,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.playlist.description!,
                style: TextStyle(color: TColor.textSecondary),
              ),
            ],
          ),
        ),
        Expanded(
          child: DeletableListLyric(
            songList: snapshot.data!,
            playlist: widget.playlist,
            enabledSaveButton: setEnabledSavedButton,
            getNewSongsPlaylist: getNewSongsPlaylist,
          ),
        ),
      ],
    );
  }

  void setEnabledSavedButton(bool enable) {
    setState(() {
      enabledSaveButton = enable;
    });
  }

  void getNewSongsPlaylist(List<Lyric> songs) {
    setState(() {
      newSongsPlaylist = songs;
    });
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
    await PlaylistService.updatePlaylist(
        widget.playlist,
        _playlistNameController.text,
        _playlistDescriptionController.text,
      );

    notification(context, "Le playlist est bien modifié");
    Navigator.of(
      context,
    ).push(MaterialPageRoute<void>(builder: (context) => MyPlaylist()));
  }
}
