import 'package:flutter/material.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';

class SearchBar extends StatefulWidget {
  final TextEditingController controller;
  const SearchBar({super.key, required this.controller});

  @override
  State<StatefulWidget> createState() => _SearchBar();
}

class _SearchBar extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: TColor.primary, width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search, color: TColor.primary),
              ),
            ),
            Expanded(
              flex: 4,
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Hitady tononkira",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
