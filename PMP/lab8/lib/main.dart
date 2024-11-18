import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:lab8/screens/home_screen.dart';

import 'models/favourite.dart';
import 'models/product.dart';
import 'models/user.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(FavouriteAdapter());
  Hive.registerAdapter(ProductAdapter());

  var userBox = await Hive.openBox<User>('userBox');
  var productBox = await Hive.openBox<Product>('productBox');
  await Hive.openBox<Favourite>('favouriteBox');

  if (userBox.isEmpty) {
    userBox.add(User(name: 'Admin User', role: 'admin'));
    userBox.add(User(name: 'Manager User', role: 'manager'));
    userBox.add(User(name: 'Regular User', role: 'user'));
    print('Users added manually.');
  }
  if (productBox.isEmpty) {
    productBox.add(Product(
      id: '1',
      name: 'Salad',
      description: 'Green salad',
      price: 7.15,
      imageUrl: 'https://hellolittlehome.com/wp-content/uploads/2022/08/garden-salad-22.jpg',
      directions: [
        'Step 1: Wash the vegetables',
        'Step 2: Toss with dressing',
      ],
    ));

    print('Products added manually.');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      home: HomeScreen(userRole: 'user',),
    );
  }
}
