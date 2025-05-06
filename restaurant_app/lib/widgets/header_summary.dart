import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A reusable widget for displaying a header summary with title and value
class HeaderSummary extends StatelessWidget {
  /// The title text to display
  final String title;

  /// The value text to display
  final String value;

  /// Whether to use a large style for the value
  final bool isLargeValue;

  /// Creates a header summary widget
  const HeaderSummary({
    Key? key,
    required this.title,
    required this.value,
    this.isLargeValue = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.paddingLarge,
          vertical: AppTheme.padding
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppTheme.borderColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppTheme.textDisabledColor,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: isLargeValue
                ? AppTheme.largePriceStyle
                : AppTheme.normalPriceStyle,
          ),
        ],
      ),
    );
  }
}