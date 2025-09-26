import 'package:flutter/material.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';

FloatingActionButton floatingActionButton(Function callable, IconData? icon) {
    return FloatingActionButton(
      onPressed: () {
        callable();
      },
      elevation: 1,
      backgroundColor: TColor.teritary,
      child: Icon(icon, color: TColor.primary),
      
    );
  }