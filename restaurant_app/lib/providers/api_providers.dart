import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/models.dart';
import '../services/api_service.dart';

/// Provider for the Dio instance used across the app
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: ApiService.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));
});

/// Provider for the ApiService
final apiServiceProvider = Provider<ApiService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApiService(dio: dio);
});

/// Enum representing the different states of data loading
enum DataState {
  /// Initial state, no data has been loaded yet
  initial,

  /// Data is currently being loaded
  loading,

  /// Data has been successfully loaded
  loaded,

  /// An error occurred while loading data
  error,
}

/// State class for restaurant data
class RestaurantState {
  final DataState state;
  final Till? data;
  final String? errorMessage;

  /// Creates an immutable RestaurantState instance
  const RestaurantState({
    required this.state,
    this.data,
    this.errorMessage,
  });

  /// Creates the initial state
  factory RestaurantState.initial() {
    return const RestaurantState(state: DataState.initial);
  }

  /// Creates a loading state
  factory RestaurantState.loading() {
    return const RestaurantState(state: DataState.loading);
  }

  /// Creates a loaded state with provided data
  factory RestaurantState.loaded(Till data) {
    return RestaurantState(state: DataState.loaded, data: data);
  }

  /// Creates an error state with error message
  factory RestaurantState.error(String message) {
    return RestaurantState(state: DataState.error, errorMessage: message);
  }

  /// Creates a copy of this state with the specified fields replaced with new values
  RestaurantState copyWith({
    DataState? state,
    Till? data,
    String? errorMessage,
  }) {
    return RestaurantState(
      state: state ?? this.state,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

/// Provider for the restaurant data state
final restaurantStateProvider = StateNotifierProvider<RestaurantStateNotifier, RestaurantState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return RestaurantStateNotifier(apiService);
});

/// Notifier for restaurant data state
class RestaurantStateNotifier extends StateNotifier<RestaurantState> {
  final ApiService _apiService;

  /// Creates a RestaurantStateNotifier with an ApiService
  RestaurantStateNotifier(this._apiService) : super(RestaurantState.initial());

  /// Fetches restaurant data from the API
  Future<void> fetchRestaurantData() async {
    try {
      state = RestaurantState.loading();

      // Adding a small delay to demonstrate loading state in the UI
      // This can be removed in production code
      await Future.delayed(const Duration(milliseconds: 800));

      final data = await _apiService.fetchRestaurantData();
      state = RestaurantState.loaded(data);
    } catch (e) {
      state = RestaurantState.error(e.toString());
    }
  }
}

/// Provider for a specific order by table number
final orderByTableProvider = Provider.family<Order?, String>((ref, tableNumber) {
  final restaurantState = ref.watch(restaurantStateProvider);

  if (restaurantState.state != DataState.loaded || restaurantState.data == null) {
    return null;
  }

  return restaurantState.data!.orders.firstWhere(
        (order) => order.table == tableNumber,
    orElse: () => throw Exception('Order not found for table $tableNumber'),
  );
});