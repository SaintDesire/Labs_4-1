import 'package:flutter/material.dart';
import '../models/car.dart';
import 'detail_screen.dart';
import '../services/file_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Car> cars = [];
  final FileService fileService = FileService();

  @override
  void initState() {
    super.initState();
    _loadCarsFromFile();
  }

  Future<void> _loadCarsFromFile() async {
    List<Car> loadedCars = await fileService.readCarsFromFile();
    setState(() {
      cars = loadedCars;
    });
  }

  void _addOrEditCar(Car? car) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen(car: car)),
    );

    if (result != null && result is Car) {
      setState(() {
        if (car != null) {
          int index = cars.indexWhere((element) => element.id == car.id);
          if (index != -1) {
            cars[index] = result;
          }
        } else {
          cars.add(result);
        }
      });

      await fileService.saveCarsToFile(cars);
    }
  }

  void _deleteCar(int index) async {
    setState(() {
      cars.removeAt(index);
    });

    await fileService.saveCarsToFile(cars);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Car deleted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cars List')),
      body: cars.isEmpty
          ? Center(child: Text('No cars available'))
          : ListView.builder(
        itemCount: cars.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              title: Text(cars[index].name),
              subtitle: Text('Brand: ${cars[index].brand}'),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Delete Car'),
                      content: Text('Are you sure you want to delete this car?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _deleteCar(index);
                          },
                          child: Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
              ),
              onTap: () => _addOrEditCar(cars[index]), // Открытие для редактирования
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditCar(null),
        child: Icon(Icons.add),
      ),
    );
  }
}
