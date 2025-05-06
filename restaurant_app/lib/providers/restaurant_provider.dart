import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../services/api_service.dart';

/// Provider for the ApiService instance
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

/// States that the restaurant data can be in
enum RestaurantDataState {
  /// Initial state before data is loaded
  initial,

  /// Data is currently being loaded
  loading,

  /// Data was loaded successfully
  loaded,

  /// An error occurred while loading data
  error
}

/// Class to represent the state of restaurant data
class RestaurantState {
  /// Current state of the data loading process
  final RestaurantDataState state;

  /// The Till data when state is [RestaurantDataState.loaded]
  final Till? data;

  /// Error message when state is [RestaurantDataState.error]
  final String? errorMessage;

  /// Creates an immutable RestaurantState instance
  RestaurantState({
    required this.state,
    this.data,
    this.errorMessage,
  });

  /// Initial state with no data
  factory RestaurantState.initial() {
    return RestaurantState(state: RestaurantDataState.initial);
  }

  /// Loading state when data is being fetched
  factory RestaurantState.loading() {
    return RestaurantState(state: RestaurantDataState.loading);
  }

  /// Loaded state with the Till data
  factory RestaurantState.loaded(Till data) {
    return RestaurantState(
      state: RestaurantDataState.loaded,
      data: data,
    );
  }

  /// Error state with an error message
  factory RestaurantState.error(String message) {
    return RestaurantState(
      state: RestaurantDataState.error,
      errorMessage: message,
    );
  }

  /// Check if data is in loading state
  bool get isLoading => state == RestaurantDataState.loading;

  /// Check if data is in loaded state
  bool get isLoaded => state == RestaurantDataState.loaded;

  /// Check if data is in error state
  bool get isError => state == RestaurantDataState.error;
}

/// StateNotifier to manage restaurant data state
class RestaurantNotifier extends StateNotifier<RestaurantState> {
  /// ApiService instance to fetch data
  final ApiService _apiService;

  /// Creates a RestaurantNotifier with an ApiService
  RestaurantNotifier(this._apiService) : super(RestaurantState.initial());

  /// Fetches restaurant data from the API
  Future<void> fetchRestaurantData() async {
    // Set state to loading
    state = RestaurantState.loading();

    try {
      // Fetch data from the API
      final data = await _apiService.fetchRestaurantData();

      // Update state with the fetched data
      state = RestaurantState.loaded(data);
    } catch (e) {
      // Update state with the error message
      state = RestaurantState.error(e.toString());
    }
  }
}

/// Provider for restaurant data state
final restaurantProvider = StateNotifierProvider<RestaurantNotifier, RestaurantState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return RestaurantNotifier(apiService);
});