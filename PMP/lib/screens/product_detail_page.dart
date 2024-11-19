import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  // Конструктор для передачи данных о продукте
  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8FA),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8F8FA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Динамическое отображение названия продукта
            Text(
              product.name, // Используем имя из переданного объекта
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Изображение продукта (если есть URL)
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: product.imageUrl != null
                      ? Image.network(
                    product.imageUrl!, // Если у продукта есть изображение
                    height: 200,
                    width: 150,
                    fit: BoxFit.cover,
                  )
                      : Image.asset( // Если изображения нет, показываем изображение по умолчанию
                    'assets/images/default_image.png',
                    height: 200,
                    width: 150,
                    fit: BoxFit.fill,
                  ),
                ),
                Spacer(),
                // Описание продукта (если нужно)
              ],
            ),
            Spacer(),
            // Блок Directions с динамическими данными
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Directions',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  // Динамическое отображение шагов из списка directions
                  for (var step in product.directions)
                    _buildStep(step), // Отображаем каждый шаг приготовления
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Виджет для отображения шага приготовления
  Widget _buildStep(String step) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: Colors.green),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            step,
            style: TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class Product {
  final String id;
  final String name;
  final String description;
  final String? imageUrl; // URL изображения (опционально)
  final List<String> directions; // Шаги приготовления

  Product({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.directions,
  });
}
