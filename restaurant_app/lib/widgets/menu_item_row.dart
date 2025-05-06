import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

/// A reusable widget for displaying a menu item row in the table detail view
class MenuItemRow extends StatelessWidget {
  /// The menu item to display
  final Item item;

  /// The count of this item in the order
  final int count;

  /// Creates a menu item row widget
  const MenuItemRow({
    Key? key,
    required this.item,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Parse the hex color code
    Color itemColor;
    try {
      final hexColor = item.color.replaceFirst('#', '');
      itemColor = Color(int.parse('FF$hexColor', radix: 16));
    } catch (e) {
      // Fallback color if parsing fails
      itemColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.padding),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Item count
          Container(
            width: AppTheme.itemNumberSize,
            height: AppTheme.itemNumberSize,
            color: itemColor,
            child: Center(
              child: Text(
                '$count',
                style: AppTheme.tableNumberStyle,
              ),
            ),
          ),

          // Item name
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.padding),
              child: Text(
                item.name,
                style: TextStyle(
                  color: itemColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Item price
          Padding(
            padding: const EdgeInsets.only(right: AppTheme.padding),
            child: Text(
              item.formattedPrice,
              style: AppTheme.normalPriceStyle,
            ),
          ),
        ],
      ),
    );
  }
}