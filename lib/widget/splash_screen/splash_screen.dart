import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tononkira_pcl/widget/home/home.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 4), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SizedBox.expand(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/img/logo_pcl.png', height: 100, width: 100,),
                    Text("Tononkira PCL", style: TextStyle(color: TColor.primary, fontSize: 35, fontWeight: 
                    FontWeight.bold, fontFamily: "midfilder")),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("développé par TNR"),
              )
          ],
          ),
    )
    );
  }
}
