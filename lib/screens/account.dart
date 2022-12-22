import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:apt_sudoku/controllers/howtoplay.dart';
import 'package:apt_sudoku/controllers/settings_controllers.dart';
import 'package:apt_sudoku/functions/db.dart';
import 'package:apt_sudoku/model/user_model.dart';
import 'package:apt_sudoku/signupin/name_page.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Account extends StatefulWidget {
  const Account({
    Key? key,
  }) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String? name;
  final controller = Get.put(SettingsController());
  final accountModel = UserModel();
  final userModel = UserFunctions();
  String image = 'assets/images/user.png';
  @override
  void initState() {
    nameSet();
     imageGet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    nameSet();
    imageGet();
    print(image);

    return  Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
          title: const Text(
            "Personal",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 26,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 275),
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SizedBox(
                              height: 270,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _avatarPics('assets/avatars/avatar0.png'),
                                      _avatarPics('assets/avatars/avatar1.png'),
                                      _avatarPics('assets/avatars/avatar2.png'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _avatarPics('assets/avatars/avatar3.png'),
                                      _avatarPics('assets/avatars/avatar4.png'),
                                      _avatarPics('assets/avatars/avatar5.png'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _avatarPics('assets/avatars/avatar6.png'),
                                      _avatarPics('assets/avatars/avatar7.png'),
                                      _avatarPics('assets/avatars/avatar8.png'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Text(
                      'Avatar >',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 45,
                  child: ClipRRect(
                    child: Image.asset(image),
                  ),
                ),
                Text(
                  name.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 1.2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        ListTile(
                          leading: const Icon(Icons.event_note_sharp),
                          title: const Text('How to Play'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          tileColor: const Color.fromARGB(255, 235, 249, 244),
                          iconColor: Colors.black,
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HowToPlay(),
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ListTile(
                          leading: const Icon(Icons.feedback_outlined),
                          title: const Text('Feedback'),
                          tileColor: const Color.fromARGB(255, 235, 249, 244),
                          iconColor: Colors.black,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => const FeedbackDialog());
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.info_outline),
                          title: const Text('About'),
                          tileColor: const Color.fromARGB(255, 235, 249, 244),
                          iconColor: Colors.black,
                          onTap: () => controller.aboutApp(context),
                        ),
                        ListTile(
                          leading: const Icon(Icons.help_outline_sharp),
                          title: const Text('Help'),
                          tileColor: const Color.fromARGB(255, 235, 249, 244),
                          iconColor: Colors.black,
                          onTap: () => controller.helpSection(context),
                        ),
                        ListTile(
                          leading: const Icon(Icons.door_front_door_outlined),
                          title: const Text('Exit'),
                          tileColor: const Color.fromARGB(255, 235, 249, 244),
                          iconColor: Colors.black,
                          onTap: () => controller.showExitPopup(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  Widget _avatarPics(String avatar) => InkWell(
        onTap: () {
          setState(() {
            image = avatar;
            imageSet(image);
            Navigator.pop(context);
          });
        },
        child: CircleAvatar(
          radius: 30,
          child: Image.asset(avatar),
        ),
      );

  signout(BuildContext ctx) {
    Navigator.of(ctx).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (ctx1) => const LoginScreen(),
        ),
        (Route<dynamic> route) => false);
  }

  void nameSet() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    setState(() {
      name = sharedPreferences.getString('name');
    });
  }

  void imageSet(String img) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setString('image', img);
  }

  void imageGet() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String theImage = image;
    setState(() {
      theImage = sharedPreferences.getString('image').toString();
    });
    theImage;
  }
}
