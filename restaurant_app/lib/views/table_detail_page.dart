import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';
import '../widgets/header_summary.dart';
import '../widgets/menu_item_row.dart';

/// Page that displays the details of a specific table's order
class TableDetailPage extends StatelessWidget {
  /// The order to display details for
  final Order order;

  /// Creates a table detail page
  const TableDetailPage({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Count total number of products
    final totalItems = order.items.length;

    // Group similar items and count them
    final groupedItems = <String, List<Item>>{};
    for (final item in order.items) {
      if (!groupedItems.containsKey(item.name)) {
        groupedItems[item.name] = [];
      }
      groupedItems[item.name]!.add(item);
    }

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.textSecondaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'table ${order.table}',
          style: const TextStyle(
            color: AppTheme.textSecondaryColor,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header with total products and price
          HeaderSummary(
            title: '$totalItems produits',
            value: order.formattedTotalPrice,
            isLargeValue: true,
          ),

          // List of items
          Expanded(
            child: ListView.builder(
              itemCount: groupedItems.length,
              itemBuilder: (context, index) {
                final itemName = groupedItems.keys.elementAt(index);
                final items = groupedItems[itemName]!;
                final item = items.first;
                final count = items.length;

                return MenuItemRow(
                  item: item,
                  count: count,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

}