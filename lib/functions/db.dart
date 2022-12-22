import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:apt_sudoku/model/user_model.dart';

class UserFunctions {
  ValueNotifier<bool> isLogged = ValueNotifier(false);
  Future<void> addLogin(UserModel login) async {
    final userDB = await Hive.openBox<UserModel>('user_model');
    await userDB.add(login);
  }

  Future<List<UserModel>> getUserData() async {
    var userDB = await Hive.openBox<UserModel>('user_model');
    return userDB.values.toList();
  }

  Future<void> keepUser(username) async {
    final userDB = await getUserData();
    await Future.forEach(userDB, (UserModel element) {
    });
  }
}
