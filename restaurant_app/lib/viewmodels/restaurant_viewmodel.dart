import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/restaurant_provider.dart';
import '../viewmodels/home_view_model.dart';

/// Home page of the application that displays raw restaurant data
class HomePage extends ConsumerStatefulWidget {
  /// Creates the home page widget
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeViewModelProvider).fetchRestaurantData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Watch for changes in the restaurant state through the view model
    final restaurantState = ref.watch(restaurantProvider);
    final viewModel = ref.watch(homeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant App'),
        centerTitle: true,
        actions: [
          // Refresh button
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(homeViewModelProvider).fetchRestaurantData();
            },
          ),
        ],
      ),
      body: _buildBody(restaurantState),
    );
  }

  /// Builds the body of the page based on the current state
  Widget _buildBody(RestaurantState state) {
    // Show different widgets based on the state
    switch (state.state) {
      case RestaurantDataState.initial:
        return const Center(
          child: Text('Press refresh to load data'),
        );

      case RestaurantDataState.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );

      case RestaurantDataState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                'Error: ${state.errorMessage}',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref.read(homeViewModelProvider).fetchRestaurantData();
                },
                child: const Text('Try Again'),
              ),
            ],
          ),
        );

      case RestaurantDataState.loaded:
      // When data is loaded, display raw JSON
        return state.data == null
            ? const Center(child: Text('No data available'))
            : SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Raw Restaurant Data:',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Till Object:',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              Text('Object type: ${state.data!.object}'),
              const SizedBox(height: 16),
              const Text(
                'Orders:',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 8),
              ...state.data!.orders.map((order) => _buildOrderCard(order)).toList(),
            ],
          ),
        );
    }
  }

  /// Builds a card for displaying order information
  Widget _buildOrderCard(order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order ID: ${order.id}'),
            Text('Table: ${order.table}'),
            Text('Guests: ${order.guests}'),
            Text('Total: ${order.formattedTotalPrice}'),
            const SizedBox(height: 8),
            const Text(
              'Items:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            ...order.items.map((item) => Padding(
              padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
              child: Text('${item.name}: ${item.formattedPrice}'),
            )).toList(),
          ],
        ),
      ),
    );
  }
}