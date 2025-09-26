import 'package:flutter/material.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';

class FloatingButton {
  final Function callable;
  final IconData? icon;
  late final bool enable;

  FloatingButton({
    required this.callable,
    required this.icon,
    this.enable = true,
  });

  FloatingActionButton build() {
    return FloatingActionButton(
      onPressed: () {
        callable();
      },
      backgroundColor: TColor.teritary,
      elevation: enable ? 2 : 0,
      child: Icon(icon, color: enable ? TColor.primary : Colors.white),
    );
  }

  void desable() {
    enable = false;
  }
}
