import 'package:flutter/material.dart';
import '../models/product.dart'; // Подключаем модель продукта

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
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.grid_view, color: Colors.black54),
            onPressed: () {},
          ),
        ],
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
                // Информация вертикально слева
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoIcon(Icons.timer, '32 MINS'), // Текст можно заменить на динамический, если нужно
                      SizedBox(height: 20),
                      _buildInfoIcon(Icons.people, '2 PEOPLE'),
                      SizedBox(height: 20),
                      _buildInfoIcon(Icons.local_fire_department, '23 CALORIES'),
                    ],
                  ),
                ),
                Spacer(),
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

  // Виджет для отображения информации (время, количество людей, калории и т.д.)
  Widget _buildInfoIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.black54),
        SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
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
