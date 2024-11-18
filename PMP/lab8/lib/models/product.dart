import 'package:hive/hive.dart';

part 'product.g.dart'; // Путь к файлу, который будет сгенерирован

@HiveType(typeId: 2) // Уникальный идентификатор типа данных в Hive
class Product {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final String? imageUrl;

  @HiveField(5)
  final List<String> directions; // Список шагов приготовления

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.imageUrl,
    required this.directions,
  });
}
