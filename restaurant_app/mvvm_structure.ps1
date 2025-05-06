# PowerShell script to create MVVM folder structure for Flutter app

# Create main directories
$directories = @(
    "lib/models",              # Data models
    "lib/views",               # UI components
    "lib/viewmodels",          # Business logic and state management
    "lib/services",            # API and other services
    "lib/utils",               # Utility functions and constants
    "lib/repositories",        # Data repositories
    "lib/providers",           # Riverpod providers
    "lib/widgets",             # Reusable UI widgets
    "lib/config",              # App configuration
    "test/models",             # Tests for models
    "test/viewmodels",         # Tests for viewmodels
    "test/services"            # Tests for services
)

foreach ($dir in $directories) {
    if (!(Test-Path -Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force
        Write-Host "Created directory: $dir"
    }
    else {
        Write-Host "Directory already exists: $dir"
    }
}

# Create initial files
$files = @{
    "lib/main.dart" = "import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:restaurant_app/views/home_view.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomeView(),
    );
  }
}";

    "lib/views/home_view.dart" = "import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Main screen of the application
class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
      ),
      body: const Center(
        child: Text('Restaurant App - Coming soon'),
      ),
    );
  }
}";

    "lib/services/api_service.dart" = "import 'package:dio/dio.dart';

/// Service to handle API requests
class ApiService {
  final Dio _dio = Dio();
  
  /// Base URL for API
  final String baseUrl = 'https://raw.githubusercontent.com/popina/test-flutter/main';

  /// Fetch data from the API
  Future<dynamic> fetchData() async {
    try {
      final response = await _dio.get('\$baseUrl/data.json');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch data: \$e');
    }
  }
}";

    "lib/config/app_config.dart" = "/// Application configuration constants
class AppConfig {
  /// API URL
  static const String apiUrl = 'https://raw.githubusercontent.com/popina/test-flutter/main/data.json';
  
  /// App name
  static const String appName = 'Restaurant App';
}";
}

foreach ($filePath in $files.Keys) {
    if (!(Test-Path -Path $filePath)) {
        $content = $files[$filePath]
        Set-Content -Path $filePath -Value $content
        Write-Host "Created file: $filePath"
    }
    else {
        Write-Host "File already exists: $filePath"
    }
}

Write-Host "MVVM folder structure created successfully!"