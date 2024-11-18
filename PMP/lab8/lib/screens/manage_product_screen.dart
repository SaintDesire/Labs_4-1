import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/product.dart'; // Импорт модели продукта

class ManageProductsScreen extends StatefulWidget {
  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  late Box<Product> productBox; // Бокс с продуктами

  // Контроллеры для добавления нового продукта
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _directionsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productBox = Hive.box<Product>('productBox'); // Открываем бокс с продуктами
  }

  // Метод для добавления нового продукта
  void _addProduct() {
    final name = _nameController.text;
    final description = _descriptionController.text;
    final price = double.tryParse(_priceController.text) ?? 0.0;
    final imageUrl = _imageUrlController.text;
    final directions = _directionsController.text.split('\n');

    if (name.isNotEmpty && description.isNotEmpty && price > 0) {
      final newProduct = Product(
        id: DateTime.now().toString(), // Генерируем уникальный ID для продукта
        name: name,
        description: description,
        price: price,
        imageUrl: imageUrl.isEmpty ? null : imageUrl,
        directions: directions,
      );

      // Добавляем новый продукт в бокс
      productBox.add(newProduct);

      // Очищаем текстовые поля
      _nameController.clear();
      _descriptionController.clear();
      _priceController.clear();
      _imageUrlController.clear();
      _directionsController.clear();

      // Обновляем экран
      setState(() {});

      // Возвращаемся на предыдущий экран и перезагружаем данные
      Navigator.pop(context, true);  // Указываем "true", чтобы сигнализировать о перезагрузке
    } else {
      // Выводим ошибку, если поля пустые или цена невалидная
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please fill all fields correctly!'),
      ));
    }
  }

  // Метод для удаления продукта
  void _deleteProduct(int index) {
    productBox.deleteAt(index);
    setState(() {}); // Обновляем экран после удаления
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Products'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true);  // Возвращаемся на предыдущую страницу с перезагрузкой
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Форма для добавления нового продукта
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Product Description'),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(labelText: 'Product Price'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL (optional)'),
            ),
            TextField(
              controller: _directionsController,
              decoration: InputDecoration(labelText: 'Directions (separate by new lines)'),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text('Add Product'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            ),
            SizedBox(height: 20),
            // Отображение списка продуктов
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: productBox.listenable(),
                builder: (context, Box<Product> box, _) {
                  if (box.values.isEmpty) {
                    return Center(child: Text('No products available.'));
                  }

                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final product = box.getAt(index) as Product;

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        elevation: 4,
                        child: ListTile(
                          title: Text(product.name),
                          subtitle: Text(product.description),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              _deleteProduct(index); // Удаляем продукт
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
