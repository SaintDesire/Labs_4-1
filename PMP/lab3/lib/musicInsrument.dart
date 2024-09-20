abstract class MusicInstrument {
  String name;

  MusicInstrument(this.name);

  void play();  // Абстрактный метод

  void info() {
    print("Instrument: $name");
  }
}
