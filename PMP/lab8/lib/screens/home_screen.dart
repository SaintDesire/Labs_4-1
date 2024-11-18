import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/favourite.dart';
import '../models/product.dart';
import '../models/user.dart';
import 'manage_product_screen.dart';
import 'product_detail_page.dart'; // Импорт страницы с деталями продукта
import 'user_list_screen.dart'; // Импорт экрана списка пользователей
import 'login_screen.dart'; // Импорт экрана логина

class HomeScreen extends StatefulWidget {
  final String userRole; // Роль пользователя, переданная в конструктор

  // Конструктор для приема роли пользователя
  HomeScreen({required this.userRole});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Product> productBox;
  late Box<Favourite> favoriteBox;

  @override
  void initState() {
    super.initState();
    productBox = Hive.box<Product>('productBox');
    favoriteBox = Hive.box<Favourite>('favouriteBox');
  }

  bool isFavorite(String productId) {
    return favoriteBox.values.any((favorite) => favorite.itemName == productId);
  }

  void toggleFavorite(Product product) {
    setState(() {
      if (isFavorite(product.id)) {
        final favorite = favoriteBox.values.firstWhere((fav) => fav.itemName == product.id);
        favoriteBox.delete(favorite.key);
      } else {
        favoriteBox.add(Favourite(itemName: product.id, details: product.name));
      }
    });
  }

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
              SizedBox(height: 20), // Добавляем отступ перед ролью
              Text(
                'Role: ${widget.userRole}', // Отображение роли пользователя
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20), // Отступ между ролью и кнопками
              // Первая кнопка - Переход на страницу авторизации
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()), // Экран авторизации
                  );
                },
                child: Text('Go to Login'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0), backgroundColor: Colors.green,
                  textStyle: TextStyle(fontSize: 18), // Цвет кнопки
                ),
              ),
              SizedBox(height: 10), // Отступ между кнопками
              // Вторая кнопка - Переход на страницу управления продуктами
              ElevatedButton(
                onPressed: () {
                  if (widget.userRole == 'manager' || widget.userRole == 'admin') {
                    // Если роль manager или admin, переходим на экран управления продуктами
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageProductsScreen(),
                      ),
                    ).then((shouldUpdate) {
                      // Если возвращаемся и signal - true, обновляем данные
                      if (shouldUpdate == true) {
                        setState(() {});
                      }
                    });
                  } else {
                    // Если роль user, выводим ошибку
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Error'),
                          content: Text('You do not have permission to manage products.'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Закрыть диалог
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Manage Products'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  backgroundColor: Colors.yellow,
                  textStyle: TextStyle(fontSize: 18), // Цвет кнопки
                ),
              ),
              SizedBox(height: 20), // Отступ между кнопками и списком продуктов
              Expanded(
                child: ListView.builder(
                  itemCount: productBox.length,
                  itemBuilder: (context, index) {
                    final product = productBox.getAt(index);
                    return Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8EBF6),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(
                          product!.name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          product.description,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        trailing: GestureDetector(
                          onTap: () => toggleFavorite(product),
                          child: Icon(
                            Icons.favorite,
                            color: isFavorite(product.id) ? Colors.red : Colors.grey,
                            size: 32,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(product: product),
                            ),
                          );
                        },
                      ),
                    );
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
            // Переход на страницу списка пользователей при выборе иконки профиля
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserListScreen(),
              ),
            );
          }
        },
      ),
    );
  }
}