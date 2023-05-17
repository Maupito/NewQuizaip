import 'package:flutter/material.dart';
import 'package:newquizaip/quiztest.dart';

class WaitingRoom extends StatefulWidget {
  final bool host;
  final String code;
  final int numberOfParticipants;
  const WaitingRoom({Key? key, required this.host, required this.code, required this.numberOfParticipants}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _WaitingRoomState createState() => _WaitingRoomState();
}
/*
class _WaitingRoomState extends State<WaitingRoom> {
  SocketIO? socketIO;

  @override
  void initState() {
    super.initState();

    if (widget.host) {
      // Si le créateur de la partie est l'hôte
      startServer();
    } else {
      // Si le créateur de la partie n'est pas l'hôte
      connectToServer();
    }
  }

  void startServer() {
    // Créer un serveur socket.io
    socketIO = SocketIOManager().createServerSocket('http://localhost', 3000);
    socketIO?.init();

    // Écouter les événements
    socketIO?.subscribe('quiz', (data) {
      // Traiter les données du quiz
    });
  }

  void connectToServer() {
    // Se connecter au serveur socket.io
    socketIO = SocketIOManager().createSocketIO('http://localhost', 3000);
    socketIO?.init();

    // Écouter les événements
    socketIO?.subscribe('quiz', (data) {
      // Traiter les données du quiz
    });

    // Joindre la salle d'attente
    socketIO?.sendMessage('join_waiting_room', {
      'code': widget.code,
    });
  }

  @override
  void dispose() {
    super.dispose();

    // Fermer la connexion socket.io
    socketIO?.disconnect();
    SocketIOManager().destroySocket(socketIO!);
  }
*/
class _WaitingRoomState extends State<WaitingRoom> {
  String selectedOption2 = "Choisissez la majeure";
  String selectedOption3 = "Choisissez le niveau de difficulté";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Salle d\'attente'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.pink, width: 6.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    'Code de la salle : ${widget.code}',
                    style: const TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Nombre de participants : ${widget.numberOfParticipants}',
                    style: const TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                _showOptionsDialog(context, "Choisissez la majeure", [
                  "Cybersécurité",
                  "BigData",
                ]);
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.pink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                height: 80,
                width: double.infinity,
                child: Center(
                  child: Text(
                    selectedOption2,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _showOptionsDialog(context, "Choisissez le niveau de difficulté", [
                  "Débutant",
                  "Intermédiaire",
                  "Expérimenté",
                ]);
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.pink, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                height: 80,
                width: 360,
                child: Center(
                  child: Text(
                    selectedOption3,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                _navigateToQuizPage(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: FractionallySizedBox(
                widthFactor: 1.1, // Modifier la fraction selon vos besoins
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.pink, Colors.orange],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: const Center(
                    child: Text(
                      "Jouer !",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionsDialog(BuildContext context, String menu, List<String> options) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(menu),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < options.length; i++)
                ListTile(
                  title: Text(options[i]),
                  onTap: () {
                    setState(() {
                      if (menu == "Choisissez la majeure") {
                        selectedOption2 = options[i];
                      } else if (menu == "Choisissez le niveau de difficulté") {
                        selectedOption3 = options[i];
                      }
                    });
                    Navigator.of(context).pop();
                  },
                ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToQuizPage(BuildContext context) {
    if (selectedOption2 != "Choisissez la majeure" &&
        selectedOption3 != "Choisissez le niveau de difficulté") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizScreen(
            category: selectedOption2,
            difficulty: selectedOption3,
          ),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Options manquantes"),
            content: const Text(
                "Veuillez sélectionner toutes les options avant de lancer le quiz."),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
