import 'dart:convert';
import 'musicInsrument.dart';

// Mixin для настройки инструмента
mixin Tunable {
  void tune() {
    print("Tuning the instrument...");
  }
}

// Mixin для записи звука
mixin Recordable {
  void record() {
    print("Recording sound...");
  }
}

// Класс Guitar с Comparable и миксинами
class Guitar extends MusicInstrument with Tunable, Recordable implements Comparable<Guitar> {
  String type;

  // Конструктор
  Guitar(String name, this.type) : super(name);

  // Именованный конструктор
  Guitar.electric() : this("Electric Guitar", "Electric");

  @override
  void play() {
    print("Playing the $name.");
  }

  @override
  void info() {
    print("$name is a $type guitar.");
  }

  // Реализация интерфейса Comparable
  @override
  int compareTo(Guitar other) {
    return name.compareTo(other.name);  // Сравниваем по имени
  }

  // Сериализация в JSON
  String toJson() {
    return jsonEncode({
      'name': name,
      'type': type,
    });
  }
}

// Класс Piano
class Piano extends MusicInstrument with Tunable, Recordable {
  Piano(String name) : super(name);

  @override
  void play() {
    print("Playing the $name.");
  }
}
