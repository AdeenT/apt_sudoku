import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apt_sudoku/controllers/game_controller.dart';
import 'package:apt_sudoku/model/box_chart.dart';

class GamePage extends StatefulWidget {
  final int difficult;
  const GamePage({
    Key? key,
    required this.difficult,
  }) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final controller = Get.put(GameController());

  @override
  void initState() {
    if (widget.difficult == 5) {
      controller.fetchContinueGameData();
    } else {
      controller.restart(widget.difficult);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return showExitPopup(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            title: const Text(
              'Sudoku+',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
          ),
          backgroundColor: Colors.white,
          body: Obx(() {
            if (controller.sudoku.isEmpty) return Container();
            return Column(
              children: [
                Expanded(flex: 1, child: _buildHeader()),
                Expanded(
                  flex: 6,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _buildSudokuGrid(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      _buildOptions(),
                       SizedBox(
                        height:  MediaQuery.of(context).size.width * 0.07,
                      ),
                      _buildNumberButtons(),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.heart_broken,
              size: 30,
              color: Colors.red.shade400,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(controller.mistakes.toString()),
          ],
        ),
         SizedBox(
          width:  MediaQuery.of(context).size.width * 0.5,
        ),
        InkWell(
          onTap: () => controller.showRestartDialogue('Difficulty Level'),
          child: const Icon(
            Icons.restart_alt_rounded,
            size: 30,
          ),
        ),
      ],
    );
  }

  Widget _buildSudokuGrid() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        9,
        (row) => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            9,
            (col) => InkWell(
              onTap: () {
                controller.selectedSudoku = controller.sudoku[row][col];
                setState(() {});
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.width * 0.1,
                margin: EdgeInsets.only(
                  bottom: row % 3 == 2 ? 2 : 0,
                  right: col % 3 == 2 ? 2 : 0,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: row % 3 == 2 ? 2 : 0),
                    right: BorderSide(width: col % 3 == 2 ? 2 : 0),
                    top: BorderSide(width: row % 3 == 0 ? 2 : 0),
                    left: BorderSide(width: col % 3 == 0 ? 2 : 0),
                  ),
                  color: _selectCellColor(row, col),
                ),
                alignment: Alignment.center,
                child: controller.sudoku[row][col].text == 0
                    ? _buildNotes(row, col)
                    : _buildCellValue(row, col),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InkWell(
          onTap: controller.onErase,
          child: Icon(
            Icons.delete_sweep_outlined,
            size: 25,
            color: Colors.grey.shade700,
          ),
        ),
        InkWell(
          onTap: controller.onNoteFill,
          onLongPress: () {
            for (var i = 0; i < 9; i++) {
              for (var j = 0; j < 9; j++) {
                if (!controller.sudoku[i][j].isDefault) {
                  controller.selectedSudoku = controller.sudoku[i][j];
                  controller.onNoteFill();
                }
              }
            }
            controller.selectedSudoku = SudokuCell(
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
          },
          child: const Icon(
            Icons.grid_on_rounded,
            size: 25,
          ),
        ),
        InkWell(
          onTap: () {
            controller.isNote.value = !controller.isNote.value;
          },
          child: Icon(
            Icons.draw_rounded,
            color: !controller.isNote.value ? Colors.black : Colors.blue,
            size: 25,
          ),
        ),
        InkWell(
          onTap: controller.onHint,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                Icons.lightbulb_outline_rounded,
                size: 25,
              ),
              Text(
                '${controller.hints}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNumberButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        9,
        (index) => InkWell(
          onTap: () async {
            controller.onNumberclick(index);
            setState(() {});
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.1,
            height:  MediaQuery.of(context).size.width * 0.13,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: controller.isNote.value &&
                      controller.selectedSudoku.row != 100 &&
                      controller
                          .sudoku[controller.selectedSudoku.row]
                              [controller.selectedSudoku.col]
                          .note
                          .contains(index + 1)
                  ? Colors.grey[400]
                  : Colors.white,
              border: Border.all(
                  color: controller.isNote.value ? Colors.black : Colors.blue),
            ),
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotes(int row, int col) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: GridView.builder(
        itemCount: 9,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, noteIndex) {
          return Container(
            alignment: Alignment.center,
            child: !controller.sudoku[row][col].note.contains(noteIndex + 1)
                ? const Offstage()
                : Text(
                    (noteIndex + 1).toString(),
                    style: TextStyle(
                      fontSize: 10,
                      color: controller.selectedSudoku.row != 100 &&
                              controller.selectedSudoku.text == (noteIndex + 1)
                          ? Colors.blue
                          : Colors.black,
                      fontWeight: controller.selectedSudoku.row != 100 &&
                              controller.selectedSudoku.text == (noteIndex + 1)
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
          );
        },
      ),
    );
  }

  Widget _buildCellValue(int row, int col) {
    return Text(
      controller.sudoku[row][col].text.toString(),
      style: TextStyle(
        fontSize: 22,
        color: controller.sudoku[row][col].isDefault
            ? Colors.black
            : controller.sudoku[row][col].isCorrect
                ? Colors.blue
                : Colors.red,
      ),
    );
  }

  Color? _selectCellColor(int row, int col) {
    if (col == controller.selectedSudoku.col &&
        row == controller.selectedSudoku.row) {
      return Colors.grey[400];
    } else if (controller.isSafe(row, col)) {
      return Colors.grey[300];
    } else {
      return Colors.white;
    }
  }

  Future<bool> showExitPopup(BuildContext context) async {
    bool value = false;
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Game'),
        content: const Text('Save game and exit?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              value = true;
              Get.back();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return value;
  }
}
