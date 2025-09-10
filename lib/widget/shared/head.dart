import 'package:flutter/material.dart';

AppBar head(BuildContext context, String title) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.of(context).pop(); 
      }
    ),
    actions: [
      Builder(
        builder: (context) {
          return IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: Icon(Icons.menu),
          );
        },
      ),
    ],
  );
}
