import 'package:hive/hive.dart';

part 'favourite.g.dart';

@HiveType(typeId: 1)
class Favourite extends HiveObject {
  @HiveField(0)
  String itemName;

  @HiveField(1)
  String details;

  Favourite({required this.itemName, required this.details});
}
