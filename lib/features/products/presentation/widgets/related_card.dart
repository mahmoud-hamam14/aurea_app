import 'package:flutter/material.dart';
import 'package:nti_ecommerce_team4/core/routes/app_routes.dart';
import 'package:nti_ecommerce_team4/core/theme/theme_extensions.dart';
import 'package:nti_ecommerce_team4/features/products/data/models/product_model.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_colors.dart';

class RelatedCard extends StatefulWidget {
  final ProductItem item;
  final void Function(String name) onQuickAdd;
  final VoidCallback onQuickRemove;

  const RelatedCard({
    super.key,
    required this.item,
    required this.onQuickAdd,
    required this.onQuickRemove,
  });

  @override
  State<RelatedCard> createState() => _RelatedCardState();
}

class _RelatedCardState extends State<RelatedCard> {
  bool added = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 155,
      decoration: BoxDecoration(
        border: Border.all(color: context.borderColor),
        borderRadius: BorderRadius.circular(16),
        color: context.cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.productDetails,
            arguments: widget.item.id,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 125,
                  width: double.infinity,
                  child: Image.network(
                    widget.item.coverPictureUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Center(child: Icon(Icons.broken_image, size: 30)),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      setState(() => added = !added);
                      if (added) {
                        widget.onQuickAdd(widget.item.name);
                      } else {
                        widget.onQuickRemove();
                      }
                    },
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: added
                            ? context.success
                            : Colors.white.withValues(alpha: 0.9),
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(color: Color(0x26000000), blurRadius: 4),
                        ],
                      ),
                      child: Icon(
                        added ? Icons.check_rounded : Icons.add_rounded,
                        size: 15,
                        color: added ? Colors.white : AppColors.lightTextPrimary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: context.textPrimary,
                          ),
                    ),
                    Text(
                      'SAR ${widget.item.price.toStringAsFixed(0)}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: context.goldDeep,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
