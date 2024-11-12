import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/user.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
        future: Hive.openBox<User>('userBox'),
        builder: (context, AsyncSnapshot<Box<User>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found.'));
          }

          var userBox = snapshot.data!;

          return ListView.builder(
            itemCount: userBox.length,
            itemBuilder: (context, index) {
              final user = userBox.getAt(index);
              return ListTile(
                title: Text(user!.name),
                subtitle: Text('Role: ${user.role}'),
              );
            },
          );
        },
      ),
    );
  }
}
