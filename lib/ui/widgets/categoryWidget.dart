import 'package:flutter/material.dart';
import 'package:maan_api_project/providers/homeProvider.dart';
import 'package:provider/provider.dart';

class CategoryWidget extends StatelessWidget {
  String title;

  CategoryWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<HomeProvider>(context, listen: false)
            .selectedCategories(title);
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Text(
          title.toString()[0].toUpperCase() + title.toString().substring(1),
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        decoration: BoxDecoration(
            color: Provider.of<HomeProvider>(context).selectedCategory == title
                ? Colors.purple
                : Colors.white,
            borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}
