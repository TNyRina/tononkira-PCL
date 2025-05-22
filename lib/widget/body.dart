import 'package:flutter/material.dart';
import 'package:tononkira_pcl/entity/Lyric.dart';

Widget body(Future<List<Lyric>> lyrics) {
  return Column(
    children: [
      Row(
        children: [
          Text("Filter"),
          Expanded(child: TextField()),
          SizedBox(width: 20),
        ],
      ),
      Expanded(
        child: FutureBuilder<List<Lyric>>(
          future: lyrics,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur : ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Aucune chanson trouvée'));
              } else {
                final songList = snapshot.data!;
                return ListView.builder(
                  itemCount: songList.length,
                  itemBuilder: (context, index) {
                    final song = songList[index];
                    return ListTile(
                      title: Text(song.title),
                    );
                  },
                );
              }
          },
        ),
      ),
    ],
  );
}