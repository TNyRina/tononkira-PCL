import 'package:flutter/material.dart';
import 'package:tononkira_pcl/entity/lyric.dart';
import 'package:tononkira_pcl/widget/shared/class/head.dart';
import 'package:tononkira_pcl/widget/shared/drawer.dart';
import 'package:tononkira_pcl/widget/shared/floating_action_button.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';
import 'package:tononkira_pcl/widget/theme/tfont.dart';

class ShowLyric extends StatefulWidget {
  final Lyric lyric;
  const ShowLyric({super.key, required this.lyric});

  @override
  State<StatefulWidget> createState() => _ShowLyric();
}

class _ShowLyric extends State<ShowLyric> {
  late double _fontSize;
  @override
  void initState() {
    super.initState();

    _fontSize = 16.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Head(context: context).build(),
      body: Padding(padding: const EdgeInsets.all(12.0), child: body()),
      drawer: drawer(context),
      floatingActionButton: floatButton(),
    );
  }

  Widget floatButton() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        floatingActionButton(() => _incrementFontSize(), Icons.add_box_rounded),
        SizedBox(height: 12.0),
        floatingActionButton(
          () => _decrementFontSize(),
          Icons.indeterminate_check_box,
        ),
      ],
    );
  }

  void _incrementFontSize() {
    setState(() {
      if (_fontSize < TFont.h1) {
        _fontSize++;
      }
    });
  }

  void _decrementFontSize() {
    setState(() {
      if (_fontSize > 10) {
        _fontSize--;
      }
    });
  }

  Widget body() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          infoTitle(),
          SizedBox(height: 30),
          lyricBody(),
        ],
      ),
    );
  }

  Widget infoTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.lyric.title,
          style: TextStyle(
            fontSize: TFont.h1,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          widget.lyric.description,
          style: TextStyle(
            fontSize: TFont.h2,
            color: TColor.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget lyricBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...widget.lyric.verses.map(
          (v) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              v,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: _fontSize),
            ),
          ),
        ),
        Text(((widget.lyric.refrain).isNotEmpty)?"Refrain: ":"", style: TextStyle(fontSize: _fontSize,),),
        Text(
          widget.lyric.refrain,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: _fontSize,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
