import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:restaurant_app/services/api_service.dart';
import 'package:restaurant_app/models/models.dart';

void main() {
  group('ApiService', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late ApiService apiService;
    final baseUrl = 'https://raw.githubusercontent.com/popina/test-flutter/main';

    setUp(() {
      dio = Dio(BaseOptions(
        contentType: 'application/json',
        responseType: ResponseType.json,
      ));
      dioAdapter = DioAdapter(dio: dio);
      apiService = ApiService(dio: dio, baseUrl: baseUrl);
    });

    test('fetchRestaurantData returns Till on successful response', () async {
      // Sample data to return from mock API
      final jsonData = {
        'object': 'till',
        'orders': [
          {
            'object': 'order',
            'id': 217,
            'table': '4',
            'guests': 3,
            'date': '',
            'items': [
              {
                'object': 'item',
                'id': 217,
                'name': 'Salade',
                'price': 900,
                'currency': '€',
                'color': '#73C399',
              },
              {
                'object': 'item',
                'id': 218,
                'name': 'Burger',
                'price': 1800,
                'currency': '€',
                'color': '#BD9B70',
              },
            ],
          }
        ],
      };

      // Setup mock response
      dioAdapter.onGet(
        '$baseUrl/data.json',
            (request) => request.reply(200, jsonData),
      );

      // Execute the method
      final result = await apiService.fetchRestaurantData();

      // Assertions
      expect(result, isA<Till>());
      expect(result.object, 'till');
      expect(result.orders.length, 1);
      expect(result.orders[0].table, '4');
      expect(result.orders[0].items.length, 2);
    });

    test('fetchRestaurantData handles string response', () async {
      // Sample data as a JSON string
      final jsonString = jsonEncode({
        'object': 'till',
        'orders': [
          {
            'object': 'order',
            'id': 217,
            'table': '4',
            'guests': 3,
            'date': '',
            'items': [
              {
                'object': 'item',
                'id': 217,
                'name': 'Salade',
                'price': 900,
                'currency': '€',
                'color': '#73C399',
              }
            ],
          }
        ],
      });

      // Setup mock response with a string
      dioAdapter.onGet(
        '$baseUrl/data.json',
            (request) => request.reply(200, jsonString),
      );

      // Execute the method
      final result = await apiService.fetchRestaurantData();

      // Assertions
      expect(result, isA<Till>());
      expect(result.orders.length, 1);
      expect(result.orders[0].items.length, 1);
      expect(result.orders[0].items[0].name, 'Salade');
    });

    test('fetchRestaurantData throws DioException on non-200 response', () async {
      // Setup mock error response
      dioAdapter.onGet(
        '$baseUrl/data.json',
            (request) => request.reply(404, {'error': 'Not found'}),
      );

      // Execute and expect exception
      expect(
            () => apiService.fetchRestaurantData(),
        throwsA(isA<DioException>()),
      );
    });

    test('fetchRestaurantData throws exception on unexpected format', () async {
      // Setup mock response with unexpected format
      dioAdapter.onGet(
        '$baseUrl/data.json',
            (request) => request.reply(200, [1, 2, 3]), // Array instead of object
      );

      // Execute and expect exception
      expect(
            () => apiService.fetchRestaurantData(),
        throwsA(isA<Exception>()),
      );
    });
  });
}