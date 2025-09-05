import 'package:flutter/material.dart';
import 'package:tononkira_pcl/dao/lyric_dao.dart';
import 'package:tononkira_pcl/entity/category.dart';
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/widget/Lyric.dart';

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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LyricDetail(lyric: song),
                        ),
                      );
                    },
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          song.categories.map((id) {
                            return FutureBuilder<Category?>(
                              future: LyricDAO.getCategory(id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Text("Chargement...");
                                } else if (snapshot.hasError ||
                                    !snapshot.hasData) {
                                  return Text("Inconnu");
                                } else {
                                  return Text(snapshot.data!.name);
                                }
                              },
                            );
                          }).toList(),
                    ),
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
