// import 'package:flutter/material.dart';
// import '../models/user.dart';
//
// class UserProvider with ChangeNotifier {
//   List<User> _users = [
//     User(id: '1', username: 'admin', role: 'Admin'),
//     User(id: '2', username: 'manager', role: 'Manager'),
//     User(id: '3', username: 'user', role: 'User'),
//   ];
//
//   List<User> get users => [..._users];
//
//   void addUser(User user) {
//     _users.add(user);
//     notifyListeners();
//   }
//
//   void removeUser(String id) {
//     _users.removeWhere((user) => user.id == id);
//     notifyListeners();
//   }
// }
