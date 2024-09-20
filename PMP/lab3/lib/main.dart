import 'dart:async';
import 'instruments.dart';

void main() {
  var guitar = Guitar("Acoustic Guitar", "Acoustic");
  var piano = Piano("Grand Piano");

  guitar.tune();
  guitar.play();
  guitar.record();

  // Работа с Future
  performAsyncTask();

  // Работа с Stream
  singleSubscriptionStreamDemo();
  broadcastStreamDemo();
}

// Асинхронный метод
Future<void> performAsyncTask() async {
  print("Starting async task...");
  await Future.delayed(Duration(seconds: 2));
  print("Async task completed.");
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