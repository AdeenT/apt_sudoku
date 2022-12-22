import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../signupin/name_page.dart';

class SettingsController extends GetxController {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  void howToPlay() {}

  void helpSection(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _controller,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Enter your questions here',
                    filled: true,
                  ),
                  maxLines: 5,
                  maxLength: 4096,
                  textInputAction: TextInputAction.done,
                  validator: (String? text) {
                    if (text == null || text.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: const Text('Send'),
                  onPressed: () async {
                    /**
             * Here we will add the necessary code to 
             * send the entered data to the Firebase Cloud Firestore.
             */
                  },
                )
              ],
            ));
  }

  Future<bool> logoutApp(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('Do you want to log out from this account?'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (ctx1) => const LoginScreen(),
                ),
                (route) => false),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  Future aboutApp(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blue.shade50,
        title: const Center(
          child: Text('About us'),
        ),
        content: SizedBox(
          height: MediaQuery.of(context).size.width * 0.7,
          child: const Text(
            'Apt sudoku is a logic-based number puzzle game and the goal is to place 1 to 9 digit numbers into each grid cell so that each row, each column, and each mini-grid. With our Sudoku puzzle app, you can not only enjoy sudoku games anytime anywhere, but also learn Sudoku techniques from it. \n \nDeveloped by ~\n Mohammed Adeen',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Future<bool> showExitPopup(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to exit the App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

}

class FeedbackDialog extends StatefulWidget {
  const FeedbackDialog({Key? key}) : super(key: key);

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  final TextEditingController _controller = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _controller,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: 'Enter your feedback here',
            filled: true,
          ),
          maxLines: 5,
          maxLength: 4096,
          textInputAction: TextInputAction.done,
          validator: (String? text) {
            if (text == null || text.isEmpty) {
              return 'Please enter a value';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context),
        ),
        TextButton(
          child: const Text('Send'),
          onPressed: () async {
            /**
             * Here we will add the necessary code to 
             * send the entered data to the Firebase Cloud Firestore.
             */
          },
        )
      ],
    );
  }
}
