import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:apt_sudoku/controllers/game_controller.dart';

class HowToPlay extends StatefulWidget {
  const HowToPlay({super.key});

  @override
  State<HowToPlay> createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text(
          'How to Play',
          style: TextStyle(
              color: Colors.black87, fontSize: 26, fontWeight: FontWeight.w600),
        ),
      ),
      body: LiquidSwipe(
        pages: [
          Container(
            color: const Color.fromARGB(255, 219, 177, 251),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 25),
                  child: Image.asset(
                    'assets/images/sudokuGrid.jpg',
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.07,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text(
                    "A Sudoku puzzle begins with a grid in which some of the numbers are already in place. A puzzle is completed when each column, row, and any of the nine 3x3 groups of cells(block) contains one and only one of each digit 1-9.",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
          Container(
              color: const Color.fromARGB(255, 175, 222, 252),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0, right: 8.0, bottom: 25),
                    child: Image.asset(
                      'assets/images/sudokuGrid2.jpg',
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: SizedBox(
                        child: _buildNumbers(),
                      )),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Text(
                      "Now to complete the puzzle you need to click on an empty cell to select it and there will be a set of numbers in the screen now click on the numbers to enter it on the empty cell",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )),
        ],
        slideIconWidget: const Icon(Icons.arrow_back_ios_new),
        positionSlideIcon: 0.65,
        waveType: WaveType.liquidReveal,
        fullTransitionValue: 800,
        enableLoop: true,
      ),
    );
  }

  Widget _buildNumbers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        9,
        (index) => Container(
          width: MediaQuery.of(context).size.width * 0.1,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: Colors.white70,
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
    );
  }
}
