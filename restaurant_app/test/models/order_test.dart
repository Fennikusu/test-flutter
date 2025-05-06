import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/models/models.dart';

void main() {
  group('Order Model', () {
    final itemsJson = [
      {
        'object': 'item',
        'id': 217,
        'name': 'Salade',
        'price': 900,
        'currency': '€',
        'color': '#73C399',
      },
      {
        'object': 'item',
        'id': 218,
        'name': 'Burger',
        'price': 1800,
        'currency': '€',
        'color': '#BD9B70',
      },
    ];

    final items = [
      Item(
        object: 'item',
        id: 217,
        name: 'Salade',
        price: 900,
        currency: '€',
        color: '#73C399',
      ),
      Item(
        object: 'item',
        id: 218,
        name: 'Burger',
        price: 1800,
        currency: '€',
        color: '#BD9B70',
      ),
    ];

    test('fromJson creates Order with correct properties', () {
      final json = {
        'object': 'order',
        'id': 217,
        'table': '4',
        'guests': 3,
        'date': '',
        'items': itemsJson,
      };

      final order = Order.fromJson(json);

      expect(order.object, 'order');
      expect(order.id, 217);
      expect(order.table, '4');
      expect(order.guests, 3);
      expect(order.date, '');
      expect(order.items.length, 2);
      expect(order.items[0].name, 'Salade');
      expect(order.items[1].name, 'Burger');
    });

    test('toJson returns correct Map', () {
      final order = Order(
        object: 'order',
        id: 217,
        table: '4',
        guests: 3,
        date: '',
        items: items,
      );

      final json = order.toJson();

      expect(json['object'], 'order');
      expect(json['id'], 217);
      expect(json['table'], '4');
      expect(json['guests'], 3);
      expect(json['date'], '');
      expect(json['items'].length, 2);
      expect(json['items'][0]['name'], 'Salade');
      expect(json['items'][1]['name'], 'Burger');
    });

    test('totalPriceInCents calculates correct total', () {
      final order = Order(
        object: 'order',
        id: 217,
        table: '4',
        guests: 3,
        date: '',
        items: items,
      );

      // 900 + 1800 = 2700
      expect(order.totalPriceInCents, 2700);

      // Add one more item
      final orderWithMoreItems = Order(
        object: 'order',
        id: 217,
        table: '4',
        guests: 3,
        date: '',
        items: [
          ...items,
          Item(
            object: 'item',
            id: 219,
            name: 'Dessert',
            price: 800,
            currency: '€',
            color: '#FFAC69',
          ),
        ],
      );

      // 900 + 1800 + 800 = 3500
      expect(orderWithMoreItems.totalPriceInCents, 3500);
    });

    test('formattedTotalPrice returns correctly formatted price', () {
      final order = Order(
        object: 'order',
        id: 217,
        table: '4',
        guests: 3,
        date: '',
        items: items,
      );

      // 2700 cents = 27,00 €
      expect(order.formattedTotalPrice, '27,00 €');
    });

    test('copyWith returns new instance with updated values', () {
      final order = Order(
        object: 'order',
        id: 217,
        table: '4',
        guests: 3,
        date: '',
        items: items,
      );

      final updatedOrder = order.copyWith(
        table: '5',
        guests: 4,
      );

      // Original order should remain unchanged
      expect(order.table, '4');
      expect(order.guests, 3);

      // Updated order should have new values
      expect(updatedOrder.table, '5');
      expect(updatedOrder.guests, 4);

      // Other properties should be kept
      expect(updatedOrder.id, 217);
      expect(updatedOrder.items.length, 2);
    });
  });
}