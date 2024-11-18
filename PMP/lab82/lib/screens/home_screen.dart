import 'package:flutter/material.dart';

import '../food_category.dart';
import '../food_item.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Breakfast',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.grid_view, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Горизонтальный список категорий еды
          Container(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                FoodCategory(name: 'Bread', isSelected: true),
                FoodCategory(name: 'Noodles'),
                FoodCategory(name: 'Seafood'),
                // Другие категории можно добавить здесь
              ],
            ),
          ),
          // Секция для отображения блюд
          Expanded(
            child: ListView(
              children: [
                FoodItem(
                  title: 'Blue Salad',
                  description: 'A salad is a dish consisting of a mixture of small pieces of food, usually vegetables.',
                  imageUrl: 'assets/salad.jpg', // Замените на подходящее изображение
                ),
                // Дополнительные блюда
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Foods'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Wine'),
        ],
      ),
    );
  }
}
