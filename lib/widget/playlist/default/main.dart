import 'package:flutter/material.dart';
import 'package:tononkira_pcl/entity/category.dart';
import 'package:tononkira_pcl/service/category_service.dart';
import 'package:tononkira_pcl/widget/playlist/default/playlist.dart';

import 'package:tononkira_pcl/widget/shared/head.dart';
import 'package:tononkira_pcl/widget/shared/drawer.dart';
import 'package:tononkira_pcl/widget/theme/tcolor.dart';
import 'package:tononkira_pcl/widget/theme/tfont.dart';
import 'package:tononkira_pcl/widget/theme/tradius.dart';

class Playlist extends StatefulWidget {
  const Playlist({super.key});

  @override
  State<StatefulWidget> createState() => _Playlist();
}

class _Playlist extends State<Playlist> {
  late Future<List<Category>> categories;

  @override
  void initState() {
    super.initState();

    categories = CategoryService.loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: head(context, "Playlist"),
      drawer: drawer(context),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Expanded(
          child: FutureBuilder<List<Category>>(
            future: categories,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Erreur : ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('Aucun playlist trouvé'));
              } else {
                final List<Category> categoryList = snapshot.data!;
                return listView(categoryList);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget listView(List<Category> categoryList) {
    return ListView.separated(
      itemCount: categoryList.length,
      itemBuilder: (context, index) {
        final Category category = categoryList[index];
        return listTile(context, category);
      },
      separatorBuilder: (context, index) => SizedBox(height: 5),
    );
  }

  Container listTile(BuildContext context, Category category) {
    return Container(
      decoration: BoxDecoration(
        color: TColor.primary,
        borderRadius: BorderRadius.circular(TRadius.small),
      ),
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              builder: (context) => DefaultPlaylist(category: category),
            ),
          );
        },
        title: Text(
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: TFont.h2,
          ),
          category.name,
        ),
      ),
    );
  }
}
