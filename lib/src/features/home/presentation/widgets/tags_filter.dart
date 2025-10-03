import 'package:flutter/material.dart';

class TagsFilter extends StatefulWidget {
  final ValueChanged<List<String>> onChanged;
  final List<String> tags;

  const TagsFilter({
    super.key,
    required this.onChanged,
    this.tags = const ["New", "Sale", "Popular", "Limited", "Trending"],
  });

  @override
  State<TagsFilter> createState() => _TagsFilterState();
}

class _TagsFilterState extends State<TagsFilter> {
  final List<String> selectedTags = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: widget.tags.map((tag) {
        final isSelected = selectedTags.contains(tag);
        return ChoiceChip(
          label: Text(tag),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                selectedTags.add(tag);
              } else {
                selectedTags.remove(tag);
              }
              widget.onChanged(selectedTags);
            });
          },
        );
      }).toList(),
    );
  }
}
