import 'package:flutter/material.dart';
import 'package:newquizaip/quiztest.dart';

class MenuPrincipal extends StatefulWidget {
  const MenuPrincipal({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MenuPrincipalState createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal>
    with SingleTickerProviderStateMixin {
  String selectedOption1 = "Choisissez la spécialité";
  String selectedOption2 = "Choisissez la majeure";
  String selectedOption3 = "Choisissez le niveau de difficulté";

  @override
  Widget build(BuildContext context) {
    const buttonHeight = 100.0;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Menu Solo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: InkWell(
              onTap: () {
                _showOptionsDialog(
                    context,
                    "Choisissez la majeure",
                    [
                      "Cybersécurité",
                      "BigData",
                    ]
                );
              },
              splashColor: Colors.pink.withOpacity(1),
              highlightColor: Colors.pink[900],
              borderRadius: BorderRadius.circular(30.0),
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashFactory: InkRipple.splashFactory,
              child: Ink(
                height: buttonHeight,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.pink],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
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
          ),
          const SizedBox(height: 20),

          Expanded(
            child: InkWell(
              onTap: () {
                _showOptionsDialog(
                    context,
                    "Choisissez le niveau de difficulté",
                    [
                      "Débutant",
                      "Intermédiaire",
                      "Expert",
                    ]
                );
              },
              splashColor: Colors.blue.withOpacity(1),
              highlightColor: Colors.blue[900],
              borderRadius: BorderRadius.circular(30.0),
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashFactory: InkRipple.splashFactory,
              child: Ink(
                height: buttonHeight,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.pink, Colors.blue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30.0),
                ),
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
          ),
          const SizedBox(height: 20),
          // Ajout du bouton "Jouer !"
          Expanded(
            child: InkWell(
              onTap: () {
                _navigateToQuizPage(context);
              },
              splashColor: Colors.red.withOpacity(1),
              highlightColor: Colors.red[900],
              borderRadius: BorderRadius.circular(30.0),
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
              splashFactory: InkRipple.splashFactory,
              child: Ink(
                height: buttonHeight,
                //width: buttonWidth,
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
    );
  }

  void _showOptionsDialog(BuildContext context, String menu, List<String> options) {
    Future.delayed(const Duration(milliseconds: 250), () {
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
                        if (menu == "Choisissez la spécialité") {
                          selectedOption1 = options[i];
                        } else if (menu == "Choisissez la majeure") {
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
    });
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