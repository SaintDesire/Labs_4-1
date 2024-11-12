import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String role; // Роли: 'admin', 'manager', 'user'

  User({required this.name, required this.role});
}
