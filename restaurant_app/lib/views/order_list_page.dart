import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/home_view_model.dart';
import '../models/models.dart';
import '../providers/restaurant_provider.dart';
import 'table_detail_page.dart';

/// Page that displays the list of all orders
class OrderListPage extends ConsumerStatefulWidget {
  /// Creates the order list page
  const OrderListPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends ConsumerState<OrderListPage> {
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
    final viewModel = ref.watch(homeViewModelProvider);
    final restaurantState = ref.watch(restaurantProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '${viewModel.orders.length} commandes',
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: _buildBody(restaurantState),
    );
  }

  /// Builds the body of the page based on the current state
  Widget _buildBody(RestaurantState state) {
    // Show different widgets based on the state
    if (state.isLoading || state.state == RestaurantDataState.initial) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.redAccent,
        ),
      );
    } else if (state.isError) {
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
    } else if (state.isLoaded) {
      return state.data == null
          ? const Center(child: Text('No orders available'))
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: state.data!.orders.length,
        itemBuilder: (context, index) {
          final order = state.data!.orders[index];
          return _buildOrderCard(context, order);
        },
      );
    }

    // Fallback in case none of the conditions match
    return const Center(child: Text('Unexpected state'));
  }

  /// Builds a card for displaying order information
  Widget _buildOrderCard(BuildContext context, Order order) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TableDetailPage(order: order),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade200),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  // Table number in red square
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.redAccent,
                    child: Center(
                      child: Text(
                        order.table,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Guest count and time
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.people,
                                size: 20,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${order.guests}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                size: 20,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '18:20', // Using fixed time as shown in the screenshots
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Total price
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      order.formattedTotalPrice,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}