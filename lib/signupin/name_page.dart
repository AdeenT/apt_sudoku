import 'package:apt_sudoku/main.dart';
import 'package:apt_sudoku/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Apt ',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
            Text(
              'Sudoku+',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 26,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: loginKey,
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      const Text(
                        'Enjoy Free Sudoku \n          Puzzles',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: _userController,
                        decoration: const InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 240, 246, 253),
                          border: OutlineInputBorder(),
                          labelText: 'Username',
                          hintText: 'eg : MasterBrain',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            if (loginKey.currentState!.validate()) {
                              buttonClicked();
                            }
                          },
                          style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.blue),
                          ),
                          child: const Text(
                            'Play Game',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> buttonClicked() async {
    final name = _userController.text.trim();
    if (name.isEmpty) {
      return;
    }
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   await sharedPreferences.setBool(userKey, true);
   await sharedPreferences.setString('name', name);
    Get.to(const  HomeScreen());
  }
}
