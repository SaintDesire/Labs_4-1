import 'package:hive/hive.dart';

part 'product.g.dart'; // Директива для генерации файла адаптера

@HiveType(typeId: 2) // Уникальный идентификатор типа
class Product extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String description;

  @HiveField(3)
  double price;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
  });
}
