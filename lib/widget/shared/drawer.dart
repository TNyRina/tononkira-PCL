import 'package:flutter/material.dart';
import 'package:tononkira_pcl/widget/home/home.dart';
import 'package:tononkira_pcl/widget/playlist/default/main.dart';
import 'package:tononkira_pcl/widget/playlist/personalized/my_playlist.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';
import 'package:tononkira_pcl/widget/theme/tfont.dart';

Drawer drawer(BuildContext context){
  return Drawer(
  child: ListView(
    padding: EdgeInsets.zero, 
    children: [
      DrawerHeader(
        decoration: BoxDecoration(color: TColor.primary),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.asset('assets/img/logo_pcl.png', width: 70, height: 70,),
            ),
            Text(style: TextStyle(color: TColor.secondary, fontSize: TFont.h1, fontWeight: FontWeight.bold), "Tononkira PCL")
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),
        title: const Text('Accueil'),
        onTap: () {
           Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => Home(),
            ),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.playlist_add_sharp),
        title: const Text('Playlist'),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => Playlist(),
            ),
          );
        },
      ),
       ListTile(
        leading: Icon(Icons.playlist_add_sharp),
        title: const Text('My Playlist'),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => MyPlaylist(),
            ),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.info),
        title: const Text('A propos'),
        onTap: () {
          // Update the state of the app.
          // ...
        },
      ),
    ],
  ),
);
}