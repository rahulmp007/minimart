import 'package:flutter/material.dart';

class FilterBar extends StatefulWidget {
  final Function(Map<String, dynamic>) onFilterChanged;

  const FilterBar({super.key, required this.onFilterChanged});

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  final Map<String, dynamic> _filters = {};

  final List<String> _categories = ["All", "Books", "Electronics", "Clothing"];
  final List<String> _tags = ["New", "Popular", "Discount"];
  final double _minPrice = 0;
  final double _maxPrice = 1000;
  double _selectedPrice = 500;
  String _selectedCategory = "All";
  String _selectedTag = "New";
  int _selectedRating = 0;

  void _updateFilter(String key, dynamic value) {
    setState(() {
      _filters[key] = value;
    });
    widget.onFilterChanged(_filters);
  }

  void _resetFilters() {
    setState(() {
      _filters.clear();
      _selectedCategory = "All";
      _selectedTag = "New";
      _selectedRating = 0;
      _selectedPrice = 500;
    });
    widget.onFilterChanged({});
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔍 Search bar
            TextField(
              decoration: const InputDecoration(
                hintText: "Search products",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onChanged: (val) => _updateFilter("title", val),
            ),
            const SizedBox(height: 8),

            // 🏷️ Compact Filters
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                // Category
                _buildDropdown("Category", _categories, _selectedCategory, (
                  val,
                ) {
                  _selectedCategory = val!;
                  _updateFilter("category", val);
                }),

                // Rating
                _buildDropdown(
                  "Rating",
                  ["Any", "1+", "2+", "3+", "4+", "5"],
                  _selectedRating == 0 ? "Any" : "$_selectedRating+",
                  (val) {
                    _selectedRating = val == "Any" ? 0 : int.parse(val![0]);
                    _updateFilter("rating", _selectedRating);
                  },
                ),

                // Tag
                _buildDropdown("Tag", _tags, _selectedTag, (val) {
                  _selectedTag = val!;
                  _updateFilter("tags", [val]);
                }),

                // Price Slider (compact)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.grey.shade50,
                  ),
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Max Price", style: TextStyle(fontSize: 12)),
                      Slider(
                        min: _minPrice,
                        max: _maxPrice,
                        value: _selectedPrice,
                        onChanged: (val) {
                          _selectedPrice = val;
                          _updateFilter("price", val);
                        },
                      ),
                      Text(
                        "\$${_selectedPrice.toStringAsFixed(0)}",
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // 🔄 Reset Button
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: _resetFilters,
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text("Reset"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.redAccent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  minimumSize: Size.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(
    String label,
    List<String> items,
    String selected,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: DropdownButton<String>(
        value: selected,
        underline: const SizedBox(),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}





