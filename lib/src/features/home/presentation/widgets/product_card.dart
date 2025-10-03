import 'package:flutter/material.dart';
import 'package:minimart/src/features/products/domain/entity/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: LayoutBuilder(
        builder: (contex, constraints) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            height: constraints.minHeight / 2,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: constraints.minHeight / 4,
                    child: Image.network(
                      height: 200,
                      product.thumbnail ?? 'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        Expanded(flex: 5, child: Text('${product.title}')),
                        Flexible(flex: 2, child: Text('\$${product.price}')),
                      ],
                    ),
                  ),
                ),
                // LayoutBuilder(
                //   builder: (context, constraints) {
                //     return Container(
                //       color: Colors.pink,
                //       height: constraints.maxHeight / 3, // or any height you want

                //       child: ClipRRect(
                //         borderRadius: const BorderRadius.vertical(
                //           top: Radius.circular(12),
                //         ),
                //         child: Image.network(
                //           scale: 0.2,
                //           product.thumbnail ?? 'https://via.placeholder.com/150',
                //           fit: BoxFit.cover,
                //           errorBuilder: (context, error, stackTrace) => Image.asset(
                //             'assets/images/placeholder.png',
                //             fit: BoxFit.cover,
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     product.title ?? '',
                //     maxLines: 1,
                //     overflow: TextOverflow.ellipsis,
                //     style: const TextStyle(fontWeight: FontWeight.bold),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8),
                //   child: Text(
                //     "\$${product.price}",
                //     style: const TextStyle(
                //       fontSize: 16,
                //       color: Colors.green,
                //       fontWeight: FontWeight.w600,
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //   child: Row(
                //     children: [
                //       Icon(Icons.star, color: Colors.amber, size: 16),
                //       Text(product.rating.toString()),
                //     ],
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
