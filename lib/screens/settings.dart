import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          'Settings',
          style: TextStyle(
              color: Colors.black87, fontSize: 26, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: const [
            SizedBox(
              height: 30,
            ),
            ListTile(
              leading: Icon(Icons.event_note_sharp),
              title: Text('How to Play'),
              trailing: Icon(Icons.arrow_forward_ios),
              tileColor: Color.fromARGB(255, 235, 249, 244),
              iconColor: Colors.black,
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Icon(Icons.feedback_outlined),
              title: Text('Feedback'),
              tileColor: Color.fromARGB(255, 235, 249, 244),
              iconColor: Colors.black,
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About'),
              tileColor: Color.fromARGB(255, 235, 249, 244),
              iconColor: Colors.black,
            ),
            ListTile(
              leading: Icon(Icons.help_outline_sharp),
              title: Text('Help'),
              tileColor: Color.fromARGB(255, 235, 249, 244),
              iconColor: Colors.black,
            ),
            ListTile(
              leading: Icon(Icons.door_front_door_outlined),
              title: Text('Exit'),
              tileColor: Color.fromARGB(255, 235, 249, 244),
              iconColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
