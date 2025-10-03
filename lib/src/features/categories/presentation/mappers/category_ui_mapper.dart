
import 'package:minimart/src/features/categories/domain/entity/category.dart';

import 'package:flutter/material.dart';

class CategoryUI {
  final Category category;
  final IconData icon;
  final Color color;

  const CategoryUI({
    required this.category,
    required this.icon,
    required this.color,
  });
}

CategoryUI mapCategoryToUI(Category category) {
  switch (category.name) {
    case "For You":
      return CategoryUI(
        category: category,
        icon: Icons.shopping_bag,
        color: Colors.blue,
      );
    case "Fashion":
      return CategoryUI(
        category: category,
        icon: Icons.checkroom,
        color: Colors.pink,
      );
    case "Mobile":
      return CategoryUI(
        category: category,
        icon: Icons.phone_android,
        color: Colors.green,
      );
    case "Electronics":
      return CategoryUI(
        category: category,
        icon: Icons.laptop_mac,
        color: Colors.orange,
      );
    case "Appliances":
      return CategoryUI(
        category: category,
        icon: Icons.kitchen,
        color: Colors.teal,
      );
    case "Beauty":
      return CategoryUI(
        category: category,
        icon: Icons.brush,
        color: Colors.purple,
      );
    default:
      return CategoryUI(
        category: category,
        icon: Icons.category,
        color: Colors.grey,
      );
  }
}
