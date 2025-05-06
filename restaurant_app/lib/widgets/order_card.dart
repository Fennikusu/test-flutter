import 'package:flutter/material.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

/// A reusable widget for displaying an order card in the list
class OrderCard extends StatelessWidget {
  /// The order to display
  final Order order;

  /// Callback function when the card is tapped
  final VoidCallback? onTap;

  /// Creates an order card widget
  const OrderCard({
    Key? key,
    required this.order,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.padding),
        decoration: AppTheme.cardDecoration,
        child: Row(
          children: [
            // Table number in red square
            Container(
              width: AppTheme.tableNumberSize,
              height: AppTheme.tableNumberSize,
              decoration: AppTheme.tableNumberDecoration,
              child: Center(
                child: Text(
                  order.table,
                  style: AppTheme.tableNumberStyle,
                ),
              ),
            ),

            // Guest count and time
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: AppTheme.infoIconSize,
                          color: AppTheme.textSecondaryColor,
                        ),
                        const SizedBox(width: AppTheme.paddingSmall / 2),
                        Text(
                          '${order.guests}',
                          style: AppTheme.infoStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.paddingSmall),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: AppTheme.infoIconSize,
                          color: AppTheme.textSecondaryColor,
                        ),
                        const SizedBox(width: AppTheme.paddingSmall / 2),
                        Text(
                          '18:20', // Using fixed time as shown in the screenshots
                          style: AppTheme.infoStyle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Total price
            Padding(
              padding: const EdgeInsets.only(right: AppTheme.padding),
              child: Text(
                order.formattedTotalPrice,
                style: AppTheme.normalPriceStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}