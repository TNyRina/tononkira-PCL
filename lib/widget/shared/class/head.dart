import 'package:flutter/material.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';

class Head {
  final BuildContext context;
  final String title;
  final bool home;

  Head({required this.context, this.title = "Tononkira PCL", this.home = false});

  AppBar build() {
    return AppBar(
      backgroundColor: TColor.primary,
      title: Text(
        title,
        style: TextStyle(color: TColor.secondary, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      leading: home ? _leadingButtonForHome() : _leadingButtonBack(),
      actions: [
        Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu, color: TColor.secondary),
            );
          },
        ),
      ],
    );
  }

  IconButton _leadingButtonBack() {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: TColor.secondary,),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget _leadingButtonForHome() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Image.asset('assets/img/logo_pcl.png'),
    );
  }
}
