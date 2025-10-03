import 'package:flutter/material.dart';

class PriceFilter extends StatefulWidget {
  final ValueChanged<RangeValues> onChanged;

  const PriceFilter({super.key, required this.onChanged});

  @override
  State<PriceFilter> createState() => _PriceFilterState();
}

class _PriceFilterState extends State<PriceFilter> {
  RangeValues priceRange = const RangeValues(0, 500);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Price Range"),
        RangeSlider(
          values: priceRange,
          min: 0,
          max: 1000,
          divisions: 20,
          labels: RangeLabels(
            "\$${priceRange.start.round()}",
            "\$${priceRange.end.round()}",
          ),
          onChanged: (values) {
            setState(() => priceRange = values);
            widget.onChanged(values);
          },
        ),
      ],
    );
  }
}
