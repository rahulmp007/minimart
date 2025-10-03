// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:minimart/src/features/categories/domain/entity/category.dart';
import 'package:minimart/src/features/categories/presentation/mappers/category_ui_mapper.dart';

class CategoryItem extends StatelessWidget {
  final Category category;
  const CategoryItem({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 55,
            width: 40,
            padding: EdgeInsets.only(left: 2, right: 2, top: 4, bottom: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.transparent, Colors.black54, Colors.black87],
                stops: [0.2, 0.7, 1.0],
              ),
              borderRadius: BorderRadius.circular(8),
              color: Colors.black87.withValues(alpha: 0.6),
            ),
            child: Center(child: Icon(mapCategoryToUI(category).icon)),
          ),

          Text(
            category.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
