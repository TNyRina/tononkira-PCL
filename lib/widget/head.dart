import 'package:flutter/material.dart';

AppBar head(){
	return AppBar(
		title: Text('Tononkira PCL Dev'),
		centerTitle: true,
		leading: Padding(
			padding: EdgeInsets.all(8.0),
			child: Image.asset('assets/img/logo_pcl.png'),
		),
		actions: [IconButton(onPressed: () {}, icon: Icon(Icons.info))],
		elevation: 0.5,
	);
}
