import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/models/models.dart';

void main() {
  group('Till Model', () {
    final ordersJson = [
      {
        'object': 'order',
        'id': 217,
        'table': '4',
        'guests': 3,
        'date': '',
        'items': [
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
        ],
      },
      {
        'object': 'order',
        'id': 218,
        'table': '5',
        'guests': 1,
        'date': '',
        'items': [
          {
            'object': 'item',
            'id': 220,
            'name': 'Soupe',
            'price': 800,
            'currency': '€',
            'color': '#73C399',
          },
        ],
      },
    ];

    final items1 = [
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

    final items2 = [
      Item(
        object: 'item',
        id: 220,
        name: 'Soupe',
        price: 800,
        currency: '€',
        color: '#73C399',
      ),
    ];

    final orders = [
      Order(
        object: 'order',
        id: 217,
        table: '4',
        guests: 3,
        date: '',
        items: items1,
      ),
      Order(
        object: 'order',
        id: 218,
        table: '5',
        guests: 1,
        date: '',
        items: items2,
      ),
    ];

    test('fromJson creates Till with correct properties', () {
      final json = {
        'object': 'till',
        'orders': ordersJson,
      };

      final till = Till.fromJson(json);

      expect(till.object, 'till');
      expect(till.orders.length, 2);
      expect(till.orders[0].id, 217);
      expect(till.orders[0].table, '4');
      expect(till.orders[0].items.length, 2);
      expect(till.orders[1].id, 218);
      expect(till.orders[1].table, '5');
      expect(till.orders[1].items.length, 1);
    });

    test('toJson returns correct Map', () {
      final till = Till(
        object: 'till',
        orders: orders,
      );

      final json = till.toJson();

      expect(json['object'], 'till');
      expect(json['orders'].length, 2);
      expect(json['orders'][0]['id'], 217);
      expect(json['orders'][0]['table'], '4');
      expect(json['orders'][0]['items'].length, 2);
      expect(json['orders'][1]['id'], 218);
      expect(json['orders'][1]['table'], '5');
      expect(json['orders'][1]['items'].length, 1);
    });

    test('copyWith returns new instance with updated values', () {
      final till = Till(
        object: 'till',
        orders: orders,
      );

      // Create a new order to add
      final newOrder = Order(
        object: 'order',
        id: 219,
        table: '6',
        guests: 2,
        date: '',
        items: [
          Item(
            object: 'item',
            id: 221,
            name: 'Pizza',
            price: 1500,
            currency: '€',
            color: '#BD9B70',
          ),
        ],
      );

      final updatedTill = till.copyWith(
        orders: [...till.orders, newOrder],
      );

      // Original till should remain unchanged
      expect(till.orders.length, 2);

      // Updated till should have the new order
      expect(updatedTill.orders.length, 3);
      expect(updatedTill.orders[2].id, 219);
      expect(updatedTill.orders[2].table, '6');
    });
  });
}