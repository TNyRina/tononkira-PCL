import 'package:flutter/material.dart';
import 'package:tononkira_pcl/entity/lyric.dart';

class ShowLyric extends StatelessWidget {
  final Lyric lyric;
  const ShowLyric({super.key, required this.lyric});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(lyric.title)),
      body: lyricBody()
    );
  }

  Widget lyricBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...lyric.verses.map(
              (v) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  v,
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Text(
              lyric.refrain,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
