import 'dart:async';
import 'package:apt_sudoku/functions/game_page_data.dart';
import 'package:apt_sudoku/screens/game_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apt_sudoku/model/box_chart.dart';
import 'package:apt_sudoku/screens/home_screen.dart';
import 'package:sudokuer/sudokuer.dart' as s;
import '../functions/db.dart';

class GameController extends GetxController {
  final userModel = UserFunctions();
  // Timer? _timer;
  int remainingSeconds = 1;
  // final time = '00:00'.obs;
  RxList<List<SudokuCell>> sudoku = RxList<List<SudokuCell>>();
  RxInt mistakes = 3.obs;
  RxInt hints = 3.obs;
  SudokuCell selectedSudoku = SudokuCell(
      text: 0,
      correctText: 0,
      row: 100,
      col: 100,
      team: 100,
      isFocus: false,
      isCorrect: false,
      isDefault: false,
      isExist: false,
      note: []);
  RxBool isNote = false.obs;

  // @override
  // void onReady() {
  //   // _startTimer(900);
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   // if (_timer == null || stopTime == true) {
  //   //   _timer!.cancel();
  //   // }
  // }

  void restart(int difficultyLevel) {
    mistakes.value = 3;
    hints.value = 3;
    sudoku.clear();
    List<List<int>> boxValues = s.generator(difficultyLevel: difficultyLevel);
    List<List<int>> boxValueSolution = s.toSudokuList(boxValues);
    s.solver(boxValueSolution);
    for (var i = 0; i < 9; i++) {
      sudoku.add([]);
      for (var j = 0; j < 9; j++) {
        int team = 0;
        if (i < 3 && j < 3) {
          team = 1;
        } else if (i < 3 && j < 6) {
          team = 2;
        } else if (i < 3 && j < 9) {
          team = 3;
        } else if (i < 6 && j < 3) {
          team = 4;
        } else if (i < 6 && j < 6) {
          team = 5;
        } else if (i < 6 && j < 9) {
          team = 6;
        } else if (i < 9 && j < 3) {
          team = 7;
        } else if (i < 9 && j < 6) {
          team = 8;
        } else if (i < 9 && j < 9) {
          team = 9;
        }
        SudokuCell value = SudokuCell(
            text: boxValues[i][j],
            correctText: boxValueSolution[i][j],
            row: i,
            col: j,
            team: team,
            isFocus: false,
            isCorrect: boxValues[i][j] == boxValueSolution[i][j],
            isDefault: boxValues[i][j] != 0,
            isExist: false,
            note: []);
        sudoku[i].add(value);
      }
    }
  }

  void fetchContinueGameData() async {
    var data = await GamePageDb.getGameData();
    var hint = await GamePageDb.getHintData();
    var mistake = await GamePageDb.getMistakeData();
    var time = await GamePageDb.getTimeData();
    if (data != null) {
      sudoku.value = data;
      hints.value = hint ?? 3;
      mistakes.value = mistake ?? 3;
    } else {
      Get.back();
    }
  }

  isComplete() {
    bool isComplete = true;
    for (var i = 0; i < sudoku.length; i++) {
      for (var j = 0; j < sudoku.length; j++) {
        if (sudoku[i][j].text == 0) {
          isComplete = false;
        }
      }
    }
    if (isComplete) {
      GamePageDb.eraseGameData();
      levelCompleted();
    }
  }

  void onErase() {
    if (_unChangable()) return;
    sudoku[selectedSudoku.row][selectedSudoku.col].text = 0;
    sudoku[selectedSudoku.row][selectedSudoku.col].isCorrect = false;
    sudoku[selectedSudoku.row][selectedSudoku.col].note.clear();
    selectedSudoku.text = 0;
    selectedSudoku.isCorrect = false;
    selectedSudoku.note.clear();
    // update();
  }

  void onNoteFill() {
    if (_unChangable()) return;
    sudoku[selectedSudoku.row][selectedSudoku.col].note =
        List.generate(9, (index) => index + 1);
    fetchSafeValues();
    // update();
  }

  void onHint() {
    if (_unChangable()) return;
    if (hints == 0) return;
    sudoku[selectedSudoku.row][selectedSudoku.col].text =
        sudoku[selectedSudoku.row][selectedSudoku.col].correctText;
    sudoku[selectedSudoku.row][selectedSudoku.col].isCorrect = true;
    removeNoteValue(sudoku[selectedSudoku.row][selectedSudoku.col].correctText);
    isComplete();
    hints--;
  }

  Future<void> onNumberclick(int index) async {
    if (selectedSudoku.row == 100) return;
    if (isNote.value) {
      if (sudoku[selectedSudoku.row][selectedSudoku.col]
          .note
          .contains(index + 1)) {
        sudoku[selectedSudoku.row][selectedSudoku.col].note.remove((index + 1));
      } else {
        sudoku[selectedSudoku.row][selectedSudoku.col].note.add((index + 1));
      }
      fetchSafeValues();
    } else {
      if (selectedSudoku.isCorrect) return;
      selectedSudoku.text = index + 1;
      selectedSudoku.isCorrect =
          selectedSudoku.text == selectedSudoku.correctText;
      sudoku[selectedSudoku.row][selectedSudoku.col] = selectedSudoku;
      if (selectedSudoku.correctText != (index + 1)) {
        mistakes--;
        if (mistakes == 0.obs) {
          showRestartDialogue('Game Over!');
        }
      } else {
        removeNoteValue(index + 1);
      }
      await GamePageDb.saveGameData(sudoku);
      await GamePageDb.saveHintData(hints.value);
      await GamePageDb.saveMistakeData(mistakes.value);
      isComplete();
    }
    // update();
  }

  bool _unChangable() {
    if (selectedSudoku.row == 100) return true;
    if (selectedSudoku.isDefault) return true;
    return false;
  }

  void showRestartDialogue(String text) => Get.defaultDialog(
        backgroundColor: Colors.blue.shade50,
        barrierDismissible: false,
        buttonColor: Colors.greenAccent,
        title: text,
        content: SizedBox(
          height: 200,
          child: Column(
            children: [
              TextButton(
                  onPressed: () {
                    restart(1);
                    Get.back();
                  },
                  child: const Text('Beginner')),
              TextButton(
                  onPressed: () {
                    restart(2);
                    Get.back();
                  },
                  child: const Text('Easy')),
              TextButton(
                  onPressed: () {
                    restart(3);
                    Get.back();
                  },
                  child: const Text("Medium")),
              TextButton(
                  onPressed: () {
                    restart(4);
                    Get.back();
                  },
                  child: const Text('Hard')),
            ],
          ),
        ),
      );

  bool isSafe(int row, int col) {
    return selectedSudoku.col == sudoku[row][col].col ||
        selectedSudoku.row == sudoku[row][col].row ||
        selectedSudoku.team == sudoku[row][col].team;
  }

  void fetchSafeValues() {
    List<int> safeValues = [];
    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
        if (selectedSudoku.row == i) {
          safeValues.add(sudoku[i][j].text);
        } else if (selectedSudoku.col == j) {
          safeValues.add(sudoku[i][j].text);
        } else if (selectedSudoku.team == sudoku[i][j].team) {
          safeValues.add(sudoku[i][j].text);
        }
      }
    }
    safeValues.removeWhere((element) => element == 0);
    for (var value in safeValues) {
      sudoku[selectedSudoku.row][selectedSudoku.col].note.remove(value);
      selectedSudoku.note.remove(value);
    }
  }

  void removeNoteValue(int number) {
    for (var i = 0; i < 9; i++) {
      for (var j = 0; j < 9; j++) {
        if (isSafe(i, j)) {
          sudoku[i][j].note.remove(number);
        }
      }
    }
  }

  // _startTimer(int seconds) {
  //   const duration = Duration(seconds: 1);
  //   remainingSeconds = seconds;
  //   _timer = Timer.periodic(duration, (Timer timer) {
  //     if (remainingSeconds == 0 || isComplete() == true) {
  //       timer.cancel();
  //       return showGameOverDialog();
  //     } else {
  //       int minutes = remainingSeconds ~/ 60;
  //       int seconds = (remainingSeconds % 60);
  //       time.value =
  //           "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
  //       remainingSeconds--;
  //     }
  //   });
  // }

  void showGameOverDialog() => Get.defaultDialog(
      title: 'Game Over',
      content: SizedBox(
          height: 50,
          child: TextButton(
              onPressed: () => Get.back(),
              child: const Text('Start New Game!'))));

  void levelCompleted() => Get.defaultDialog(
        backgroundColor: Colors.blue.shade50,
        title: 'Level Completed',
        content: SizedBox(
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("Earned a star"),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue.shade400),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    onPressed: () {
                      Get.offAll(const HomeScreen());
                    },
                    child: const Text('Main Menu'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showRestartDialogue('Choose difficulty');
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue.shade400),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    child: const Text('Next Game'),
                  )
                ],
              ),
            ],
          ),
        ),
      );

  Widget button(String text, difficulty) {
    return TextButton(
      onPressed: () {
        showRestartDialogue('Choose difficulty');
        Get.back();
      },
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.blue.shade300),
      ),
    );
  }
}
