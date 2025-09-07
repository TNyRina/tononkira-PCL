import 'package:flutter/material.dart';
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/dao/lyric_dao.dart';
import 'package:tononkira_pcl/entity/category.dart';
import 'package:tononkira_pcl/widget/lyric/Lyric.dart';
import 'package:tononkira_pcl/widget/lyric/playlist.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';
import 'package:tononkira_pcl/widget/theme/tfont.dart';
import 'package:tononkira_pcl/widget/theme/tradius.dart';

Widget body(Future<List<Lyric>> lyrics) {
  return Container(
    color: const Color(0xFFFFFFFF),
    child: Column(
      children: [
        /**
         * Search bar
         */
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: TColor.primary, width: 2),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search, color: TColor.primary),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Hitady tononkira",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: 20),

        /**
         * List of lyric
         */
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
                final List<Lyric> songList = snapshot.data!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    itemCount: songList.length,
                    itemBuilder: (context, index) {
                      final Lyric song = songList[index];
                      return listTile(context, song);
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 5),
                  ),
                );
              }
            },
          ),
        ),
      ],
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
      onTap: () { Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => LyricDetail(lyric: song),
            ),
          );},
      title: Text(
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: TFont.h2,
        ),
        song.title,
      ),
      //   subtitle: Wrap(
      //     spacing: 5,
      //     runSpacing: 5,
      //     children:
      //         song.categories.map((id) {
      //           return FutureBuilder<Category?>(
      //             future: LyricDAO.getCategory(id),
      //             builder: (context, snapshot) {
      //               if (snapshot.connectionState == ConnectionState.waiting) {
      //                 return Text("Chargement...");
      //               } else if (snapshot.hasError || !snapshot.hasData) {
      //                 return Text("Inconnu");
      //               } else {
      //                 return Container(
      //                   decoration: BoxDecoration(
      //                     color: TColor.secondary,
      //                     borderRadius: BorderRadius.circular(TRadius.small),
      //                   ),
      //                   child: Padding(
      //                     padding: const EdgeInsets.all(4.0),
      //                     child: Text(
      //                       style: TextStyle(color: TColor.text),
      //                       snapshot.data!.name,
      //                     ),
      //                   ),
      //                 );
      //               }
      //             },
      //           );
      //         }).toList(),
      //   ),
      trailing: IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => Playlist(),
            ),
          );
        },
        icon: Icon(Icons.playlist_add_circle_rounded, color: TColor.secondary),
      ),
    ),
  );
}
