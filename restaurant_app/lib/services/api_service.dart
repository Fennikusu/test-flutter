import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/models.dart';

/// Service responsible for handling API requests
class ApiService {
  /// The Dio HTTP client instance
  final Dio _dio;

  /// Base URL for API requests
  final String _baseUrl;

  /// Creates an ApiService with the given Dio instance and base URL
  ApiService({Dio? dio, String? baseUrl})
      : _dio = dio ?? Dio(BaseOptions(
    contentType: 'application/json',
    responseType: ResponseType.json,
  )),
        _baseUrl = baseUrl ?? 'https://raw.githubusercontent.com/popina/test-flutter/main';

  /// Fetches restaurant data from the API
  ///
  /// Returns a [Till] object containing all orders and items
  /// Throws a [DioException] if the request fails
  Future<Till> fetchRestaurantData() async {
    try {
      // Add a delay to simulate network latency for testing loading states
      // await Future.delayed(const Duration(seconds: 2));

      final response = await _dio.get('$_baseUrl/data.json');

      if (response.statusCode == 200) {
        // Debug information
        print('Response type: ${response.data.runtimeType}');

        // Handle different response types
        Map<String, dynamic> jsonData;

        if (response.data is String) {
          // If the response is a String, parse it as JSON
          jsonData = jsonDecode(response.data);
        } else if (response.data is Map<String, dynamic>) {
          // If the response is already a Map<String, dynamic>, use it directly
          jsonData = response.data;
        } else {
          throw Exception('Unexpected response format: ${response.data.runtimeType}');
        }

        // Create Till object from the parsed data
        return Till.fromJson(jsonData);
      } else {
        throw DioException(
          requestOptions: RequestOptions(path: '$_baseUrl/data.json'),
          response: response,
          error: 'Failed to load data: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Rethrow the exception to be handled by the caller
      rethrow;
    }
  }
}