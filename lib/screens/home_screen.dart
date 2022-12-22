import 'package:apt_sudoku/controllers/settings_controllers.dart';
import 'package:apt_sudoku/screens/account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'game_page.dart';

var starsCollected = 0;
String? img;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    setState(() {
      starsCollected.toString();
    });
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
              onPressed: () => Get.to(const Account()),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                  child: ListTile(
                    leading: const Icon(
                      Icons.star_rate_rounded,
                      color: Colors.amber,
                      size: 40,
                    ),
                    title: Text(
                      starsCollected.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 220,
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
                const SizedBox(
                  height: 200,
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
                            height: 230,
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
      
}
