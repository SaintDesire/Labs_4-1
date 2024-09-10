import 'package:flutter/material.dart';

import 'musicStudio.dart';
import 'instruments.dart';

void main() {
  print("\n===== Music Instrument Tuning and Playing =====");

  // Создание объектов
  var guitar = Guitar("Acoustic Guitar", "Acoustic");
  var piano = Piano("Grand Piano");

  // Использование методов
  print("\n-- Tuning and Playing Instruments --");
  guitar.tune();
  guitar.play();
  guitar.info();

  piano.tune();
  piano.play();

  print("\n===== Studio Instrument Count =====");

  // Использование статических функций
  MusicStudio.addInstrument();
  print("Total instruments in the studio: ${MusicStudio.instrumentCount}");

  print("\n===== Performing with Instruments =====");

  // Работа с функциями
  perform(instrument: "Guitar");
  record("Piano", 10);
  practice("Drum", () => print("  > Practice completed successfully."));

  print("\n===== Working with Collections =====");
  // Работа с коллекциями
  collectionsDemo();

  print("\n===== Looping Demo =====");
  // Работа с continue и break
  loopDemo();

  print("\n===== Exception Handling Demo =====");
  // Обработка исключений
  exceptionHandlingDemo();
}

// Функция с именованным параметром
void perform({required String instrument}) {
  print("  > Performing with $instrument.");
}

// Функция с параметром по умолчанию
void record(String instrument, [int duration = 5]) {
  print("  > Recording $instrument for $duration minutes.");
}

// Функция с параметром типа функция
void practice(String instrument, Function onComplete) {
  print("  > Practicing on $instrument...");
  onComplete();
}

void collectionsDemo() {
  // Массив
  List<String> instruments = ["Guitar", "Piano", "Drum"];

  // Коллекция
  Set<String> uniqueInstruments = {"Guitar", "Piano", "Drum"};

  // Добавление элементов в коллекцию
  uniqueInstruments.add("Violin");

  print("\n-- Array of Instruments --");
  // Перебор массива
  for (var instrument in instruments) {
    print("  - $instrument");
  }

  print("\n-- Set of Unique Instruments --");
  // Перебор множества
  uniqueInstruments.forEach((instrument) {
    print("  - $instrument");
  });
}

void loopDemo() {
  print("\n-- Loop Output --");
  for (int i = 0; i < 5; i++) {
    if (i == 2) {
      print("  - Skipping number 2");
      continue; // Пропускаем 2
    }
    if (i == 4) {
      print("  - Breaking at number 4");
      break; // Прерываем на 4
    }
    print("  - Number $i");
  }
}

void exceptionHandlingDemo() {
  try {
    int divisor = 0;
    if (divisor == 0) {
      throw Exception("Cannot divide by zero!");
    }
    int result = 10 ~/ divisor;
    print("Result: $result");
  } catch (e) {
    print("  > Error occurred: $e");
  } finally {
    print("  > Cleaning up resources.");
  }
}
