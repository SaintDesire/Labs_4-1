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
    int result = name.compareTo(other.name);

    if (result == 0) {
      print("$name is the same as ${other.name}");
    } else {
      print("$name is not the same as ${other.name}");
    }

    return result;
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


// Реализация Iterator для перебора музыкальных инструментов
class InstrumentIterator implements Iterator<MusicInstrument> {
  final List<MusicInstrument> _instruments;
  int _currentIndex = -1;

  InstrumentIterator(this._instruments);

  @override
  bool moveNext() {
    _currentIndex++;
    return _currentIndex < _instruments.length;
  }

  @override
  MusicInstrument get current => _instruments[_currentIndex];
}

// Класс InstrumentCollection, реализующий Iterable
class InstrumentCollection extends Iterable<MusicInstrument> {
  final List<MusicInstrument> _instruments;

  InstrumentCollection(this._instruments);

  @override
  Iterator<MusicInstrument> get iterator => InstrumentIterator(_instruments);
}

// Пример использования
void main() {
  var guitar = Guitar("Acoustic Guitar", "Acoustic");
  var piano = Piano("Grand Piano");

  // Создаём коллекцию музыкальных инструментов
  var instrumentCollection = InstrumentCollection([guitar, piano]);

  // Перебор инструментов с использованием Iterable и Iterator
  for (var instrument in instrumentCollection) {
    instrument.play();
  }
}
