import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/home_page.dart';

void main() {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // Wrap the entire app with ProviderScope to enable Riverpod
    const ProviderScope(
      child: RestaurantApp(),
    ),
  );
}

/// Main application widget
class RestaurantApp extends StatelessWidget {
  /// Creates the main application widget
  const RestaurantApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}