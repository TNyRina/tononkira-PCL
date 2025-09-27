import 'package:flutter/material.dart';
import 'package:tononkira_pcl/widget/shared/class/head.dart';
import 'package:tononkira_pcl/widget/shared/drawer.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';
import 'package:tononkira_pcl/widget/theme/tfont.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: Head(context: context).build(), drawer: drawer(context), body: body());
  }

  Widget body() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Tononkira PCL', style: TextStyle(fontSize: TFont.h2, fontWeight: FontWeight.bold)),
          Text('"Tononkira PCL" est un application pour accéder aux paroles des chants du choral "Les Petits Chanteurs de la Louange" de l\'ecar Fo Masin\'i Jesoa Ambodivona. Simple et intuitive, elle permet aux choristes de retrouver rapidement les textes des chansons, de les lire et de se préparer pour les répétitions et les concerts.'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Version: 1.0.0', style: TextStyle(color: TColor.textSecondary),),
                Text("Développé par : RATOVOARISON Tsiory Ny Rina", style: TextStyle(color: TColor.textSecondary)),
                Text("Email : nyrinaratovo@gmail.com", style: TextStyle(color: TColor.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
