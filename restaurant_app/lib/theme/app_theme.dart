import 'package:flutter/material.dart';

/// Application theme constants and styles
class AppTheme {
  /// Private constructor to prevent instantiation
  AppTheme._();

  // Colors
  /// Primary color for the application
  static const Color primaryColor = Color(0xFFE15B5B); // Red color for table numbers

  /// Secondary color for the application
  static const Color secondaryColor = Color(0xFF4D9BE6); // Blue color for prices

  /// Background color for the application
  static const Color backgroundColor = Colors.white;

  /// Color for text on primary color
  static const Color onPrimaryColor = Colors.white;

  /// Color for card borders
  static const Color borderColor = Color(0xFFEEEEEE);

  /// Primary text color
  static const Color textPrimaryColor = Color(0xFF424242);

  /// Secondary text color
  static const Color textSecondaryColor = Color(0xFF757575);

  /// Disabled text color
  static const Color textDisabledColor = Color(0xFFBDBDBD);

  // Text Styles
  /// Heading text style
  static const TextStyle headingStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: textPrimaryColor,
  );

  /// Title text style
  static const TextStyle titleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: textPrimaryColor,
  );

  /// Body text style
  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: textPrimaryColor,
  );

  /// Subtitle text style
  static const TextStyle subtitleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: textSecondaryColor,
  );

  /// Price text style for larger displays
  static const TextStyle largePriceStyle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: secondaryColor,
  );

  /// Price text style for normal displays
  static const TextStyle normalPriceStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: textPrimaryColor,
  );

  /// Table number text style
  static const TextStyle tableNumberStyle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: onPrimaryColor,
  );

  /// Info text style for guest count and time
  static const TextStyle infoStyle = TextStyle(
    fontSize: 16,
    color: textSecondaryColor,
  );

  // Decorations
  /// Card decoration
  static BoxDecoration cardDecoration = BoxDecoration(
    color: backgroundColor,
    border: Border.all(color: borderColor),
    borderRadius: BorderRadius.circular(4),
  );

  /// Table number container decoration
  static const BoxDecoration tableNumberDecoration = BoxDecoration(
    color: primaryColor,
  );

  // Spacing
  /// Standard padding
  static const double padding = 16.0;

  /// Small padding
  static const double paddingSmall = 8.0;

  /// Large padding
  static const double paddingLarge = 24.0;

  /// Standard border radius
  static const double borderRadius = 4.0;

  /// Icon size for information icons
  static const double infoIconSize = 20.0;

  /// Table number container size
  static const double tableNumberSize = 80.0;

  /// Item number container size
  static const double itemNumberSize = 64.0;

  /// Get the material theme data for the application
  static ThemeData getTheme() {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        titleTextStyle: headingStyle,
        iconTheme: IconThemeData(
          color: textSecondaryColor,
        ),
      ),
      textTheme: const TextTheme(
        headlineMedium: headingStyle,
        titleMedium: titleStyle,
        bodyMedium: bodyStyle,
        bodySmall: subtitleStyle,
      ),
      cardTheme: CardTheme(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          side: BorderSide(color: borderColor),
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: secondaryColor,
        onPrimary: onPrimaryColor,
        background: backgroundColor,
        surface: backgroundColor,
      ),
    );
  }
}