import 'package:flutter/material.dart';

class RatingFilter extends StatefulWidget {
  final ValueChanged<int> onChanged;

  const RatingFilter({super.key, required this.onChanged});

  @override
  State<RatingFilter> createState() => _RatingFilterState();
}

class _RatingFilterState extends State<RatingFilter> {
  int selectedRating = 0;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<int>(
      initialValue: selectedRating,
      onChanged: (value) {
        setState(() => selectedRating = value ?? 0);
        widget.onChanged(selectedRating);
      },
      items: [
        const DropdownMenuItem(value: 0, child: Text("All Ratings")),
        for (int i = 1; i <= 5; i++)
          DropdownMenuItem(
            value: i,
            child: Row(
              children: List.generate(i, (index) => const Icon(Icons.star, size: 16, color: Colors.amber)),
            ),
          ),
      ],
      decoration: InputDecoration(
        labelText: "Rating",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
