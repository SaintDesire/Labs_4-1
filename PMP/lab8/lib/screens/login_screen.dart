import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user.dart';
import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: FutureBuilder(
        future: Hive.openBox<User>('userBox'),
        builder: (context, AsyncSnapshot<Box<User>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users available. Please add users.'));
          }

          var userBox = snapshot.data!;

          return ListView.builder(
            itemCount: userBox.length,
            itemBuilder: (context, index) {
              final user = userBox.getAt(index);
              return ListTile(
                title: Text(user!.name),
                subtitle: Text('Role: ${user.role}'),
                onTap: () {
                  // Сохраняем выбранного пользователя в currentUserBox
                  Hive.box('currentUserBox').put('currentUser', user);
                  // Возвращаемся на HomeScreen с обновленным пользователем
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
