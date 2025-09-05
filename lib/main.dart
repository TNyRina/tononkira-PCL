import 'package:flutter/material.dart';
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/service/lyric_service.dart';
import 'package:tononkira_pcl/widget/head.dart';
import 'package:tononkira_pcl/widget/body.dart';

void main() {
  runApp(TononkiraPCL());
}

class TononkiraPCL extends StatefulWidget {
  const TononkiraPCL({super.key});

	@override
	State<TononkiraPCL> createState() => _TononkiraPCL();
}

class _TononkiraPCL extends State<TononkiraPCL> {
	late Future<List<Lyric>> lyrics;

  @override
  void initState() {
    super.initState();
    lyrics = LyricService.loadLyrics();
  }

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
		  title: "Tonokira PCL",
		  home: Scaffold(appBar: head(), body: body(lyrics)),
		  debugShowCheckedModeBanner: false,
		);
	}
}
