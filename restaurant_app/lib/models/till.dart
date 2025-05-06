import 'order.dart';

/// Represents the main data structure containing all restaurant orders
class Till {
  /// Object type identifier
  final String object;

  /// List of all orders in the system
  final List<Order> orders;

  /// Creates an immutable Till instance
  const Till({
    required this.object,
    required this.orders,
  });

  /// Creates a Till instance from a JSON map
  factory Till.fromJson(Map<String, dynamic> json) {
    return Till(
      object: json['object'] as String,
      orders: (json['orders'] as List<dynamic>)
          .map((order) => Order.fromJson(order as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Converts the Till instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'object': object,
      'orders': orders.map((order) => order.toJson()).toList(),
    };
  }

  /// Creates a copy of this Till with the specified fields replaced with new values
  Till copyWith({
    String? object,
    List<Order>? orders,
  }) {
    return Till(
      object: object ?? this.object,
      orders: orders ?? this.orders,
    );
  }

  @override
  String toString() {
    return 'Till{object: $object, orders: $orders}';
  }
}