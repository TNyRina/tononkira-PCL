import 'package:flutter/material.dart';
import 'package:tononkira_pcl/widget/home/home.dart';


void main() {
  runApp(TononkiraPCL());
}

class TononkiraPCL extends StatelessWidget {
  const TononkiraPCL({super.key});

  @override
	Widget build(BuildContext context) {
		return MaterialApp(
		  title: "Tonokira PCL",
		  home: Home(),
		  debugShowCheckedModeBanner: false,
		);
	}
}

