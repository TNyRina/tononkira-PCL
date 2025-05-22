import 'package:flutter/material.dart';
import 'package:tononkira_pcl/entity/Lyric.dart';

class LyricDetail extends StatelessWidget {
  final Lyric lyric;
  const LyricDetail({required this.lyric});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lyric.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...lyric.verse.map((v) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              v,
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            ),
          )),
          Text(
            lyric.refrain,
            textAlign: TextAlign.justify,
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
        ]
      )
    );
  }
}

