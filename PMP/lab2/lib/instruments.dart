// Класс Guitar
import 'package:lab2/playable.dart';

import 'musicInsrument.dart';

class Guitar extends MusicInstrument implements Playable {
  String type;

  // Конструктор
  Guitar(String name, this.type) : super(name);

  // Именованный конструктор
  Guitar.electric() : this("Electric Guitar", "Electric");

  @override
  void tune() {
    print("$name is tuned.");
  }

  @override
  void play() {
    print("Playing the $name.");
  }

  // Перегрузка метода info
  @override
  void info() {
    print("$name is a $type guitar.");
  }
}

// Класс Piano
class Piano extends MusicInstrument implements Playable {
  Piano(String name) : super(name);

  @override
  void tune() {
    print("$name is tuned.");
  }

  @override
  void play() {
    print("Playing the $name.");
  }
}
