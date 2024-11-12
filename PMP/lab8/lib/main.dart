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
  await Hive.openBox<Favourite>('favouriteBox');
  await Hive.openBox<Product>('productBox');
  await Hive.openBox('currentUserBox');

  if (userBox.isEmpty) {
    userBox.add(User(name: 'Admin User', role: 'admin'));
    userBox.add(User(name: 'Manager User', role: 'manager'));
    userBox.add(User(name: 'Regular User', role: 'user'));
    print('Users added manually.');
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
      home: HomeScreen(),
    );
  }
}
