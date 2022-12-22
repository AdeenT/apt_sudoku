import 'package:hive_flutter/hive_flutter.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  int? star;

  @HiveField(2)
  String? saveGame;

  UserModel({
    this.id,
    this.star,
    this.saveGame,
  });
}
