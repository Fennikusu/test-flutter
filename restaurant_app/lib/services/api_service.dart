import 'package:dio/dio.dart';
import '../models/models.dart';

/// Exception thrown when API request fails
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => 'ApiException: $message${statusCode != null ? ' (Status code: $statusCode)' : ''}';
}

/// Service responsible for handling API requests
class ApiService {
  final Dio _dio;

  /// Base URL for the API
  static const String baseUrl = 'https://raw.githubusercontent.com/popina/test-flutter/main';

  /// Creates an ApiService with optional custom Dio instance
  ApiService({Dio? dio}) : _dio = dio ?? Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  /// Fetches restaurant data from the API
  ///
  /// Returns a [Till] object containing all orders
  /// Throws [ApiException] if the request fails
  Future<Till> fetchRestaurantData() async {
    try {
      final response = await _dio.get('/data.json');

      if (response.statusCode == 200) {
        return Till.fromJson(response.data);
      } else {
        throw ApiException(
          'Failed to load restaurant data',
          statusCode: response.statusCode,
        );
      }
    } on DioException catch (e) {
      throw ApiException(
        e.message ?? 'Unknown error occurred while fetching data',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      throw ApiException('Error parsing data: ${e.toString()}');
    }
  }
}