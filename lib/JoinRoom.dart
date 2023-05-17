// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:newquizaip/WaitingRoom.dart';

class JoinRoom extends StatefulWidget {
  const JoinRoom({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _JoinRoomState createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  final TextEditingController _roomCodeController = TextEditingController();

  get host => null;
/*
  void joinRoom() {
    String code = _roomCodeController.text;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WaitingRoom(code: code, host: host, numberOfParticipants: 0,)),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rejoindre une salle'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Entrez le code de la salle de quizz :',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _roomCodeController,
              decoration: const InputDecoration(
                hintText: 'Code de la salle',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const SizedBox(height: 20),
          /*ElevatedButton(
            onPressed: JoinRoom,
            child: const Text('Rejoindre la salle'),
          ),*/
        ],
      ),
    );
  }
}