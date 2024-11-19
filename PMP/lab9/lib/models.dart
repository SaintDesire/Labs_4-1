import 'package:flutter/foundation.dart';

class Product {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final List<String> directions;

  Product({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.directions,
  });
}

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];

  ProductProvider() {
    // Инициализация продуктов при запуске
    _loadInitialProducts();
  }

  List<Product> get products => _products;

  void _loadInitialProducts() {
    if (_products.isEmpty) {
      _products.add(Product(
        id: '1',
        name: 'Caesar Salad',
        description: 'A classic Caesar salad with crispy romaine lettuce, croutons, and creamy dressing.',
        directions: [
          '1. Wash the lettuce thoroughly.',
          '2. Tear the lettuce into bite-sized pieces.',
          '3. Toast the croutons.',
          '4. Mix the lettuce, croutons, and dressing together.',
          '5. Serve with grated parmesan on top.'
        ],
        imageUrl: 'https://natashaskitchen.com/wp-content/uploads/2019/01/Caesar-Salad-Recipe-3.jpg',
      ));

      _products.add(Product(
        id: '2',
        name: 'Greek Salad',
        description: 'A fresh Greek salad with tomatoes, cucumbers, feta cheese, and olives.',
        directions: [
          '1. Chop the tomatoes and cucumbers.',
          '2. Cut the feta cheese into cubes.',
          '3. Add olives and mix all ingredients.',
          '4. Drizzle with olive oil and sprinkle with oregano.'
        ],
        imageUrl: 'https://i2.wp.com/www.downshiftology.com/wp-content/uploads/2018/08/Greek-Salad-6-1.jpg',
      ));
    }
  }

  bool isFavorite(String productId) {
    return false;
  }

  void toggleFavorite(String productId) {
    notifyListeners(); // Обновляем состояние
  }
}
