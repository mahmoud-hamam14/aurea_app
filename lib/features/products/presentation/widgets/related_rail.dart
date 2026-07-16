import 'package:flutter/material.dart';
import 'package:nti_ecommerce_team4/features/products/data/models/product_model.dart';
import 'related_card.dart';

class RelatedRail extends StatelessWidget {
  final List<ProductItem> relatedProducts;
  final void Function(String name) onQuickAdd;
  final VoidCallback onQuickRemove;

  const RelatedRail({
    super.key,
    required this.relatedProducts,
    required this.onQuickAdd,
    required this.onQuickRemove,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double railHeight = constraints.maxWidth > 600 ? 220 : 200;

        return SizedBox(
          height: railHeight,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: relatedProducts.length,
            separatorBuilder: (_, _) => const SizedBox(width: 14),
            itemBuilder: (context, i) {
              final item = relatedProducts[i];
              return RelatedCard(
                item: item,
                onQuickAdd: onQuickAdd,
                onQuickRemove: onQuickRemove,
              );
            },
          ),
        );
      },
    );
  }
}
