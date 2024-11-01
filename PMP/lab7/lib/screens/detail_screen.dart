import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/car.dart';
import '../services/file_service.dart';

class DetailScreen extends StatefulWidget {
  final Car? car;

  DetailScreen({Key? key, this.car}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late TextEditingController _brandController;
  late TextEditingController _nameController;
  late TextEditingController _yearController;
  final Uuid uuid = Uuid(); // Генератор уникальных ID
  final FileService fileService = FileService(); // Экземпляр FileService
  final _formKey = GlobalKey<FormState>(); // Ключ для формы

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController(text: widget.car?.brand ?? '');
    _nameController = TextEditingController(text: widget.car?.name ?? '');
    _yearController = TextEditingController(text: widget.car?.year.toString() ?? '');
  }

  void _saveCar() async {
    if (_formKey.currentState!.validate()) {
      try {
        Car newCar = Car(
          id: widget.car?.id ?? uuid.v4(), // Создание нового ID, если добавляется новый автомобиль
          brand: _brandController.text,
          name: _nameController.text,
          year: int.parse(_yearController.text),
        );

        // Возврат нового или обновленного объекта на предыдущий экран
        Navigator.pop(context, newCar);
      } catch (e) {
        print('Error saving car: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred while saving the car')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please correct the errors in the form')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.car == null ? 'Add Car' : 'Edit Car')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _brandController,
                decoration: InputDecoration(labelText: 'Brand'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a brand';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _yearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Year'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a year';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Year must be a number';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _saveCar,
                child: Text(widget.car == null ? 'Add' : 'Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
