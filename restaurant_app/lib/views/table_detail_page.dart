import 'package:flutter/material.dart';
import '../models/models.dart';

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.grey),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'table ${order.table}',
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header with total products and price
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$totalItems produits',
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  order.formattedTotalPrice,
                  style: TextStyle(
                    color: Colors.blue.shade400,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // List of items
          Expanded(
            child: ListView.builder(
              itemCount: order.items.length,
              itemBuilder: (context, index) {
                final item = order.items[index];

                // Count occurrences of this item by name
                final itemCount = _countSimilarItems(order.items, item.name);

                // Skip if we've already displayed this item
                if (index > 0 && _hasDisplayedBefore(order.items, item.name, index)) {
                  return const SizedBox.shrink();
                }

                return _buildItemRow(item, itemCount);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a row for an item in the order
  Widget _buildItemRow(Item item, int count) {
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
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Item count
          Container(
            width: 64,
            height: 64,
            color: itemColor,
            child: Center(
              child: Text(
                '$count',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Item name
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              item.formattedPrice,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Counts how many items with the same name exist in the list
  int _countSimilarItems(List<Item> items, String name) {
    return items.where((item) => item.name == name).length;
  }

  /// Checks if an item with the same name has already been displayed
  bool _hasDisplayedBefore(List<Item> items, String name, int currentIndex) {
    for (int i = 0; i < currentIndex; i++) {
      if (items[i].name == name) {
        return true;
      }
    }
    return false;
  }
}