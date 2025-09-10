import 'package:flutter/material.dart';
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/entity/playlist.dart';
import 'package:tononkira_pcl/service/playlist_service.dart';
import 'package:tononkira_pcl/widget/playlist/personalized/my_playlist.dart';
import 'package:tononkira_pcl/widget/playlist/personalized/playlist.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';
import 'package:tononkira_pcl/widget/theme/tfont.dart';
import 'package:tononkira_pcl/widget/theme/tradius.dart';

class PlaylistList extends StatefulWidget {
  final Lyric? lyric;
  const PlaylistList({super.key, this.lyric});
  const PlaylistList.addLyric({super.key, required this.lyric});

  @override
  State<StatefulWidget> createState() => _PlaylistList();
}

class _PlaylistList extends State<PlaylistList> {
  late Future<List<Playlist>> playlists;

  @override
  void initState() {
    super.initState();

    playlists = PlaylistService.loadPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Playlist>>(
      future: playlists,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Aucun playlist trouvé'));
        } else {
          final List<Playlist> playlists = snapshot.data!;
          return listContainer(playlists);
        }
      },
    );
  }

  Widget listContainer(List<Playlist> playlists) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final Playlist playlist = playlists[index];
          return listTile(context, playlist);
        },
        separatorBuilder: (context, index) => SizedBox(height: 5),
      ),
    );
  }

  Widget listTile(BuildContext context, Playlist playlist) {
    return Container(
      decoration: BoxDecoration(
        color: TColor.primary,
        borderRadius: BorderRadius.circular(TRadius.small),
      ),
      child: ListTile(
        onTap: () async {
          if (widget.lyric != null) {
            await PlaylistService.addLyricToPlaylist(
              playlist,
              widget.lyric as Lyric,
            );

            if (!mounted) return;
            Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) => MyPlaylist()));
          } else {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => PersonalizedPlaylist(playlist: playlist),
              ),
            );
          }
        },
        title: Text(
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: TFont.h2,
          ),
          playlist.name,
        ),
        subtitle: Text(playlist.getCreatedDate()!),
        trailing: IconButton(
          onPressed: () => showDeleteDialog(playlist),
          icon: Icon(Icons.delete_rounded, color: TColor.danger),
        ),
      ),
    );
  }

  void showDeleteDialog(Playlist playlist) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Avertissement", style: TextStyle(color: TColor.danger)),
          icon: Icon(Icons.dangerous),
          content: Text(
            "Voulez vous vraiment supprimer le playlis ${playlist.name}",
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
                deletePlaylist(playlist);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void deletePlaylist(Playlist playlist) async {
    await PlaylistService.deletePlaylist(playlist);
    
    setState(() {
      playlists = PlaylistService.loadPlaylist(); 
    });
  }
}
