// Абстрактный класс MusicInstrument
abstract class MusicInstrument {
  String name;

  MusicInstrument(this.name);

  void tune(); // Абстрактный метод для настройки инструмента

  // Метод, который может быть перегружен в подклассах
  void info() {
    print("This is a musical instrument.");
  }
}
