import 'vehicle.dart';

abstract class Transport implements Vehicle {
  String name;
  int year;

  Transport(this.name, this.year);

  void honk() {
    print('$name is honking!');
  }

  @override
  void start() {
    print('$name started.');
  }
}
