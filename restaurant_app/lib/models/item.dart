/// Represents a food or beverage item in an order
class Item {
  /// Object type identifier
  final String object;

  /// Unique identifier for the item
  final int id;

  /// Name of the item
  final String name;

  /// Price in cents
  final int price;

  /// Currency symbol
  final String currency;

  /// Color code in HEX format for UI display
  final String color;

  /// Creates an immutable Item instance
  const Item({
    required this.object,
    required this.id,
    required this.name,
    required this.price,
    required this.currency,
    required this.color,
  });

  /// Creates an Item instance from a JSON map
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      object: json['object'] as String,
      id: json['id'] as int,
      name: json['name'] as String,
      price: json['price'] as int,
      currency: json['currency'] as String,
      color: json['color'] as String,
    );
  }

  /// Converts the Item instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'object': object,
      'id': id,
      'name': name,
      'price': price,
      'currency': currency,
      'color': color,
    };
  }

  /// Returns a formatted price with currency symbol
  /// Example: "9,00 €" for price = 900
  String get formattedPrice {
    // Convert cents to euros with comma as decimal separator
    final euros = price / 100;
    return '${euros.toStringAsFixed(2).replaceAll('.', ',')} $currency';
  }

  /// Creates a copy of this Item with the specified fields replaced with new values
  Item copyWith({
    String? object,
    int? id,
    String? name,
    int? price,
    String? currency,
    String? color,
  }) {
    return Item(
      object: object ?? this.object,
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      color: color ?? this.color,
    );
  }

  @override
  String toString() {
    return 'Item{object: $object, id: $id, name: $name, price: $price, currency: $currency, color: $color}';
  }
}