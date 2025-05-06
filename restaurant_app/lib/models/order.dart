import 'item.dart';

/// Represents a customer order at a specific table
class Order {
  /// Object type identifier
  final String object;

  /// Unique identifier for the order
  final int id;

  /// Table number or identifier
  final String table;

  /// Number of guests at the table
  final int guests;

  /// Date of the order
  final String date;

  /// List of items in the order
  final List<Item> items;

  /// Creates an immutable Order instance
  const Order({
    required this.object,
    required this.id,
    required this.table,
    required this.guests,
    required this.date,
    required this.items,
  });

  /// Creates an Order instance from a JSON map
  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      object: json['object'] as String,
      id: json['id'] as int,
      table: json['table'] as String,
      guests: json['guests'] as int,
      date: json['date'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => Item.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Converts the Order instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'object': object,
      'id': id,
      'table': table,
      'guests': guests,
      'date': date,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }

  /// Calculates the total price of all items in the order in cents
  int get totalPriceInCents {
    return items.fold(0, (sum, item) => sum + item.price);
  }

  /// Returns a formatted total price with currency symbol
  /// Example: "48,00 €" for totalPriceInCents = 4800
  String get formattedTotalPrice {
    final euros = totalPriceInCents / 100;
    final currency = items.isNotEmpty ? items.first.currency : '€';
    return '${euros.toStringAsFixed(2).replaceAll('.', ',')} $currency';
  }

  /// Creates a copy of this Order with the specified fields replaced with new values
  Order copyWith({
    String? object,
    int? id,
    String? table,
    int? guests,
    String? date,
    List<Item>? items,
  }) {
    return Order(
      object: object ?? this.object,
      id: id ?? this.id,
      table: table ?? this.table,
      guests: guests ?? this.guests,
      date: date ?? this.date,
      items: items ?? this.items,
    );
  }

  @override
  String toString() {
    return 'Order{object: $object, id: $id, table: $table, guests: $guests, date: $date, items: $items}';
  }
}