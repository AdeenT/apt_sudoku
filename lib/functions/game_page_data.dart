import 'dart:convert';
import 'package:apt_sudoku/model/box_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamePageData{
  get defaultData => null;

  Future saveJsonData(jsonData) async{
    final prefs = await SharedPreferences.getInstance();
    var saveData = jsonEncode(jsonData);
    await prefs.setString('jsonData', saveData);
  }

  // Future <void> getJsonData()async{
  //   final prefs = await SharedPreferences.getInstance();
  //   var temp = prefs.getString('jsonData');
  //   print('Data saved: $temp');
  //   var data = SudokuCell.fromMap(jsonDecode(temp.toString()));
  // }
    Future <SudokuCell> getJsonData()async{
    final prefs = await SharedPreferences.getInstance();
    var temp = prefs.getString('jsonData');
    var data = SudokuCell.fromMap(jsonDecode(temp.toString()));
    return data;
  }
}