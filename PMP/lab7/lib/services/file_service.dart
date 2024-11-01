import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/car.dart';
import 'dart:convert';

class FileService {
  final String fileName = 'cars_data.json';

  Future<void> saveCarsToFile(List<Car> cars) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');

      List<Map<String, dynamic>> jsonCars = cars.map((car) => car.toJson()).toList();
      await file.writeAsString(jsonEncode(jsonCars));
      print('\nCars saved successfully to ${file.path}\n');
    } catch (e) {
      if (Platform.isAndroid) {
        print('Error writing file on Android: $e');
      } else if (Platform.isIOS) {
        print('Error writing file on iOS: $e');
      } else {
        print('Error writing file on unknown platform: $e');
      }
    }
  }

  Future<List<Car>> readCarsFromFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');

      if (await file.exists()) {
        final content = await file.readAsString();
        List<dynamic> jsonList = jsonDecode(content);
        return jsonList.map((json) => Car.fromJson(json)).toList();
      } else {
        print('File not found');
        return [];
      }
    } catch (e) {
      if (Platform.isAndroid) {
        print('Error reading file on Android: $e');
      } else if (Platform.isIOS) {
        print('Error reading file on iOS: $e');
      } else {
        print('Error reading file on unknown platform: $e');
      }
      return [];
    }
  }
}
