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
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late User? currentUser = null;
  late Box<Product> productBox;
  late Box<Favourite> favoriteBox;

  @override
  void initState() {
    super.initState();
    productBox = Hive.box<Product>('productBox');
    favoriteBox = Hive.box<Favourite>('favouriteBox');
    currentUser = Hive.box('currentUserBox').get('currentUser');
    updateCurrentUser();
  }

  void updateCurrentUser() {
    setState(() {
      currentUser = Hive.box('currentUserBox').get('currentUser');
    });
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
                  Flexible(
                    child: Text(
                      'Role: ${currentUser?.role ?? 'No role'}',
                      style: TextStyle(fontSize: 18),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.menu), // Используйте подходящую иконку
                        color: Colors.grey,
                        onPressed: () {
                          if (currentUser != null && (currentUser!.role == 'admin' || currentUser!.role == 'manager')) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ManageProductsScreen(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Access denied: You do not have permission to manage products.'),
                              ),
                            );
                          }
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.login),
                        color: Colors.grey,
                        onPressed: () {
                          // Переход на экран логина
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      ),
                      Icon(Icons.search, size: 28, color: Colors.black54),
                      SizedBox(width: 16),

                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              // Список продуктов
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
                              builder: (context) => ProductDetailPage(),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              // Кнопки над нижним меню
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(Icons.tune, 'Beer', false),
                  _buildButton(Icons.fastfood, 'Foods', true),
                  _buildButton(Icons.wine_bar, 'Wine', false),
                ],
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

  Widget _buildButton(IconData icon, String label, bool isSelected) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFFE67E22) : Color(0xFFE8E8E8),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
