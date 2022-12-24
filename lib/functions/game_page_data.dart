import 'dart:convert';
import 'package:apt_sudoku/model/box_chart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamePageDb {
  // get defaultData => null;
  static late SharedPreferences prefs;

  static Future<void> initialize() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<void> saveGameData(List<List<SudokuCell>> sudokuGame) async {
    var saveData = jsonEncode(sudokuGame);
    await prefs.setString('gameData', saveData);
    debugPrint('gameData saved');
  }

  static Future<void> saveHintData(int hint) async {
    await prefs.setInt('hintData', hint);
    debugPrint('hintData saved');
  }

  static Future<void> saveMistakeData(int mistake) async {
    await prefs.setInt('mistakeData', mistake);
    debugPrint('mistakeData saved');
  }

  static Future<void> saveTimeData(int time) async {
    await prefs.setInt('timeData', time);
    debugPrint('timeData saved');
  }

  static Future<int?> getHintData() async {
    return prefs.getInt('hintData');
  }

  static Future<int?> getMistakeData() async {
    return prefs.getInt('mistakeData');
  }

  static Future<int?> getTimeData() async {
    return prefs.getInt('timeData');
  }

  static Future<bool> isSavedGameAvailable() async {
    String? temp = prefs.getString('gameData');
    return temp != null;
  }

  static Future<List<List<SudokuCell>>?> getGameData() async {
    String? temp = prefs.getString('gameData');
    if (temp != null) {
      List<List<SudokuCell>> sudoku = [];
      List<dynamic> savedData = jsonDecode(temp);
      for (int i = 0; i < savedData.length; i++) {
        sudoku.add([]);
        List<dynamic> firstData = savedData[i];
        for (int j = 0; j < firstData.length; j++) {
          Map<String, dynamic> data = jsonDecode(firstData[j]);
          sudoku[i].add(SudokuCell.fromMap(data));
        }
      }
      return sudoku;
    } else {
      return null;
    }
  }

  static Future<void> eraseGameData() async {
    await prefs.remove('gameData');
    await prefs.remove('hintData');
    await prefs.remove('mistakeData');
    await prefs.remove('timeData');
  }

  // Future <void> getJsonData()async{
  //   final prefs = await SharedPreferences.getInstance();
  //   var temp = prefs.getString('jsonData');
  //   print('Data saved: $temp');
  //   var data = SudokuCell.fromMap(jsonDecode(temp.toString()));
  // }

}
