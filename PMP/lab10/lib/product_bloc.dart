import 'dart:async';
import 'product_model.dart';

// Класс BLoC для управления состоянием и событиями
class ProductBloc {
  // Определение StreamControllers для управления данными продуктов и статусом избранного
  final _productController = StreamController<List<Product>>.broadcast();
  final _favoriteController = StreamController<List<Product>>.broadcast();

  // Данные для BLoC
  List<Product> _products = [
    Product(name: "Grilled cheese", isFavorite: false),
    Product(name: "Caesar salad", isFavorite: false),
    Product(name: "Greek salad", isFavorite: false),
  ];
  List<Product> _favoriteProducts = [];

  // Sinks
  Sink<List<Product>> get productSink => _productController.sink;
  Sink<List<Product>> get favoriteSink => _favoriteController.sink;

  // Streams
  Stream<List<Product>> get productsStream => _productController.stream;
  Stream<List<Product>> get favoriteStream => _favoriteController.stream;

  ProductBloc() {
    Future.delayed(Duration.zero, () {
      productSink.add(_products);
    });
  }


  // Добавление или удаление продуктов из избранного
  void toggleFavorite(Product product) {
    if (_favoriteProducts.contains(product)) {
      _favoriteProducts.remove(product);
    } else {
      _favoriteProducts.add(product);
    }
    favoriteSink.add(_favoriteProducts);
  }

  void dispose() {
    _productController.close();
    _favoriteController.close();
  }
}