import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/home_view_model.dart';
import '../models/models.dart';
import '../providers/restaurant_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/order_card.dart';
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
        padding: const EdgeInsets.all(AppTheme.padding),
        itemCount: state.data!.orders.length,
        itemBuilder: (context, index) {
          final order = state.data!.orders[index];
          return OrderCard(
            order: order,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TableDetailPage(order: order),
                ),
              );
            },
          );
        },
      );
    }

    // Fallback in case none of the conditions match
    return const Center(child: Text('Unexpected state'));
  }


}