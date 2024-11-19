import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Пример данных товара
  final Product exampleProduct = Product(
    id: '1',
    name: 'Delicious Breakfast',
    description: 'A delicious and healthy breakfast option.',
  );

  bool isFavorite = false; // Статус "избранного" для примера

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Breakfast',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Отступ перед ролью
              Container(
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFE8EBF6),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.all(16),
                  title: Text(
                    exampleProduct.name,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    exampleProduct.description,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      setState(() {
                        isFavorite = !isFavorite; // Меняем статус "избранного"
                      });
                    },
                    child: Icon(
                      Icons.favorite,
                      color: isFavorite ? Colors.red : Colors.grey,
                      size: 32,
                    ),
                  ),
                  onTap: () {
                    // Действия при нажатии на товар (например, переход на страницу деталей товара)
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'Menu',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            // Переход на страницу профиля при выборе иконки профиля
            // Можно добавить логику перехода на экран профиля
          }
        },
      ),
    );
  }
}

class Product {
  final String id;
  final String name;
  final String description;

  Product({required this.id, required this.name, required this.description});
}
