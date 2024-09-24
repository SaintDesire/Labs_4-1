import 'dart:async';
import 'instruments.dart';

var guitar = Guitar("Acoustic Guitar", "Acoustic");
var guitar2 = Guitar("Bass Guitar", "Bass");
var piano = Piano("Grand Piano");

void main() {
  guitar.compareTo(guitar2);
  guitar.tune();
  guitar.play();
  guitar.record();

  // Пример работы с интерфейсами Iterator и Iterable
  iteratorAndIterableDemo();

  // Работа с Future
  performAsyncTask();

  // Работа с Stream
  singleSubscriptionStreamDemo();
  broadcastStreamDemo();
}

// Асинхронный метод
Future<void> performAsyncTask() async {
  print("\nStarting async task...\n");
  await Future.delayed(Duration(seconds: 2));
  print("\nAsync task completed.\n");
}

// Пример работы с Single Subscription Stream
void singleSubscriptionStreamDemo() {
  Stream<int> singleStream = Stream<int>.periodic(
    Duration(seconds: 1),
        (computationCount) => computationCount,
  ).take(5);  // 5 событий

  singleStream.listen((event) {
    print("Single subscription stream event: $event");
  });
}

// Пример работы с Broadcast Stream
void broadcastStreamDemo() {
  StreamController<int> controller = StreamController<int>.broadcast();
  Stream<int> broadcastStream = controller.stream;

  broadcastStream.listen((event) {
    print("Broadcast stream listener 1: $event");
  });

  broadcastStream.listen((event) {
    print("Broadcast stream listener 2: $event");
  });

  for (int i = 0; i < 5; i++) {
    controller.add(i);
  }
}


// Пример работы с интерфейсами Iterator и Iterable
void iteratorAndIterableDemo() {
  print("\n-- Iterator and Iterable Demo --");

  // Создание коллекции музыкальных инструментов
  var instrumentCollection = InstrumentCollection([guitar, piano]);

  // Перебор инструментов с использованием Iterable и Iterator
  for (var instrument in instrumentCollection) {
    instrument.play();  // Вызов метода play для каждого инструмента
  }

  // Пример использования итератора напрямую
  var iterator = instrumentCollection.iterator;
  while (iterator.moveNext()) {
    var currentInstrument = iterator.current;
    print("Iterator playing: ${currentInstrument.name}");
  }
}