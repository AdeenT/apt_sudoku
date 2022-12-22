import 'dart:async';
import 'package:apt_sudoku/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'game_controller.dart';

class TimerController extends GetxController {
  final controller = Get.put(GameController());

  Timer? _timer;
  int remainingSeconds = 1;
  final time = '00:00'.obs;

  @override
  void onReady() {
    _startTimer(900);
    super.onReady();
  }

  @override
  void onClose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.onClose();
  }

  _startTimer(int seconds) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0 || controller.isComplete()) {
        timer.cancel();
        return showGameOverDialog();
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = (remainingSeconds % 60);
        time.value =
            "${minutes.toString().padLeft(2, "0")}:${seconds.toString().padLeft(2, "0")}";
        remainingSeconds--;
      }
    });
  }

  void showGameOverDialog() => Get.defaultDialog(
      title: 'Game Over',
      content: SizedBox(
        height: 50,
        child: TextButton(
            onPressed: () => Get.off(const HomeScreen()), child: const Text('Start New Game!')),
      ));
}
