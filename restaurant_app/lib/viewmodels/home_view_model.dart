import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import '../providers/restaurant_provider.dart';

/// ViewModel for the Home Page following MVVM pattern
class HomeViewModel {
  /// Reference to the Riverpod reader for accessing providers
  final Ref _ref;

  /// Creates a HomeViewModel with a Riverpod reader
  HomeViewModel(this._ref);

  /// Gets the current restaurant state
  RestaurantState get restaurantState =>
      _ref.read(restaurantProvider);

  /// Fetches restaurant data from the API
  Future<void> fetchRestaurantData() async {
    await _ref.read(restaurantProvider.notifier).fetchRestaurantData();
  }

  /// Gets all orders from the restaurant data
  List<Order> get orders =>
      restaurantState.data?.orders ?? [];

  /// Checks if data is currently loading
  bool get isLoading =>
      restaurantState.isLoading;

  /// Checks if data has been loaded
  bool get isLoaded =>
      restaurantState.isLoaded;

  /// Checks if there was an error loading data
  bool get isError =>
      restaurantState.isError;

  /// Gets the error message if there was an error
  String? get errorMessage =>
      restaurantState.errorMessage;
}

/// Provider for the HomeViewModel
final homeViewModelProvider = Provider((ref) {
  return HomeViewModel(ref);
});