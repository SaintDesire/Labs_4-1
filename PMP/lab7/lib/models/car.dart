import 'transport.dart';
import 'package:uuid/uuid.dart';

class Car extends Transport {
  final String _id; // Приватное поле id
  String brand;
  static int totalCars = 0;
  static const String category = 'Vehicle'; // Static поле

  Car({required String id, required this.brand, required String name, required int year})
      : _id = id, // Инициализация приватного поля
        super(name, year) {
    totalCars++;
  }

  // Именованный конструктор
  Car.electric(String brand)
      : _id = Uuid().v4(), // Генерация уникального ID
        brand = brand,
        super('Electric Car', 2024) {
    totalCars++;
  }

  // Реализация геттера id
  String get id => _id;

  // Метод fromJson для создания объекта Car из JSON
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      brand: json['brand'],
      name: json['name'],
      year: json['year'],
    );
  }

  // Метод toJson для преобразования объекта Car в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'brand': brand,
      'name': name,
      'year': year,
    };
  }

  // Реализация геттера maxSpeed
  @override
  int get maxSpeed => 200;

  // Getter и Setter для свойства brand
  String get carBrand => brand;
  set carBrand(String newBrand) {
    brand = newBrand;
  }

  // Статическая функция
  static void showTotalCars() {
    print('Total cars created: $totalCars');
  }

  // Перегрузка метода
  @override
  void honk() {
    print('$name ($brand) is honking loudly!');
  }

  // Функция с именованным параметром и параметром по умолчанию
  void drive({int speed = 60}) {
    print('$name is driving at $speed km/h.');
  }

  // Функция с параметром типа функция
  void performMaintenance(Function action) {
    print('$name is undergoing maintenance.');
    action();
  }

  // Функция с необязательным параметром
  void park([String? location]) {
    print('$name is parked at ${location ?? 'the default location'}.');
  }

  @override
  void stop() {
    print('$name stopped.');
  }
}
