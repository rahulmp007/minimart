import 'package:flutter/material.dart';

class CategoryFilter extends StatefulWidget {
  final ValueChanged<String?> onChanged;
  final List<String> categories;

  const CategoryFilter({
    super.key,
    required this.onChanged,
    this.categories = const ["All", "Electronics", "Clothing", "Home", "Books", "Sports"],
  });

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  String? selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: selectedCategory,
      onChanged: (value) {
        setState(() => selectedCategory = value);
        widget.onChanged(value);
      },
      items: widget.categories.map((cat) {
        return DropdownMenuItem(
          value: cat,
          child: Text(cat),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: "Category",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
