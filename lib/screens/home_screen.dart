import 'package:apt_sudoku/controllers/settings_controllers.dart';
import 'package:apt_sudoku/functions/game_page_data.dart';
import 'package:apt_sudoku/model/box_chart.dart';
import 'package:apt_sudoku/screens/account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'game_page.dart';

String? img;
String countKey = 'countKey';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Get.put(
        SettingsController().showExitPopup(context),
      ),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: const Text(
            'Sudoku+',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_box_rounded),
              onPressed: () => Get.to(() => const Account()),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.7,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(right: 150),
                    child: Text(
                      'Apt',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 32,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const Text(
                  'Sudoku+',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 32,
                      fontWeight: FontWeight.w600),
                ),
                 SizedBox(
                  height: MediaQuery.of(context).size.width * 0.6,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor: Colors.blue.shade50,
                          title: const Center(
                            child: Text('Choose Difficulty'),
                          ),
                          content: SizedBox(
                            height: MediaQuery.of(context).size.width * 0.7,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _difficultyButton('Beginner', 1),
                                _difficultyButton('Easy', 2),
                                _difficultyButton('Medium', 3),
                                _difficultyButton('Hard', 4),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  child: const Text(
                    'New Game',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _difficultyButton(String text, int difficult) => ListTile(
        title: Text(
          text,
        ),
        tileColor: Colors.blue.shade100,
        onTap: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => GamePage(difficult: difficult),
              ));
        },
      );

  // continueButton() {
  //   if (rawData.isNotEmpty) {
  //     return ElevatedButton(
  //       onPressed: () {
  //         getData();
  //       },
  //       style: ButtonStyle(
  //         backgroundColor: MaterialStateProperty.all(Colors.blue),
  //       ),
  //       child: const Text('  Continue  '),
  //     );
  //   }
  //}

  void getData() async {
    SudokuCell savedGame = await GamePageData().getJsonData();
  }
}
