import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/models/item.dart';

void main() {
  group('Item Model', () {
    test('fromJson creates Item with correct properties', () {
      final json = {
        'object': 'item',
        'id': 217,
        'name': 'Salade',
        'price': 900,
        'currency': '€',
        'color': '#73C399',
      };

      final item = Item.fromJson(json);

      expect(item.object, 'item');
      expect(item.id, 217);
      expect(item.name, 'Salade');
      expect(item.price, 900);
      expect(item.currency, '€');
      expect(item.color, '#73C399');
    });

    test('toJson returns correct Map', () {
      final item = Item(
        object: 'item',
        id: 217,
        name: 'Salade',
        price: 900,
        currency: '€',
        color: '#73C399',
      );

      final json = item.toJson();

      expect(json['object'], 'item');
      expect(json['id'], 217);
      expect(json['name'], 'Salade');
      expect(json['price'], 900);
      expect(json['currency'], '€');
      expect(json['color'], '#73C399');
    });

    test('formattedPrice returns correct format', () {
      final item = Item(
        object: 'item',
        id: 217,
        name: 'Salade',
        price: 900,
        currency: '€',
        color: '#73C399',
      );

      expect(item.formattedPrice, '9,00 €');

      final itemWithDifferentPrice = Item(
        object: 'item',
        id: 218,
        name: 'Burger',
        price: 1850,
        currency: '€',
        color: '#BD9B70',
      );

      expect(itemWithDifferentPrice.formattedPrice, '18,50 €');
    });

    test('copyWith returns new instance with updated values', () {
      final item = Item(
        object: 'item',
        id: 217,
        name: 'Salade',
        price: 900,
        currency: '€',
        color: '#73C399',
      );

      final updatedItem = item.copyWith(
        name: 'Salade Verte',
        price: 950,
      );

      // Original item should remain unchanged
      expect(item.name, 'Salade');
      expect(item.price, 900);

      // Updated item should have new values
      expect(updatedItem.name, 'Salade Verte');
      expect(updatedItem.price, 950);

      // Other properties should be kept
      expect(updatedItem.id, 217);
      expect(updatedItem.color, '#73C399');
    });
  });
}