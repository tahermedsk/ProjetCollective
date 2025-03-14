
import 'package:flutter/material.dart';
import 'JeuQCMViewModel.dart';

class JeuQCMView extends StatefulWidget {
  final int idQCM;
  const JeuQCMView({super.key, required this.idQCM});

  @override
  _JeuQCMViewState createState() => _JeuQCMViewState();
}

class _JeuQCMViewState extends State<JeuQCMView> {
  int? _selectedAnswer;
  bool _validated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jeu QCM")),
      body: FutureBuilder<Map<String, dynamic>>(
        future: JeuQCMViewModel().recupererQCM(widget.idQCM),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text("Erreur lors du chargement"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("Aucune donnée disponible"));
          }

          var data = snapshot.data as Map<String, dynamic>;
          print(data);
          String question = data["question"];
          List<dynamic> options = data["options"];
          int correctAnswer = data["correctAnswer"];

          return Column(
            children: [
              _buildQuestionWidget(question),
              ...List.generate(4, (index) => _buildAnswerWidget(options[index], index + 1, correctAnswer)),
              ElevatedButton(
                onPressed: _selectedAnswer == null
                    ? null
                    : () {
                        setState(() {
                          _validated = true;
                        });
                      },
                child: const Text("Valider"),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQuestionWidget(dynamic question) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: question is String
          ? Text(question, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
          : Image.network(question), // Remplace par Image.asset si fichiers locaux
    );
  }

  Widget _buildAnswerWidget(dynamic answer, int index, int correctAnswer) {
    Color? color;
    if (_validated) {
      if (index == correctAnswer) {
        color = Colors.green;
      } else if (index == _selectedAnswer) {
        color = Colors.red;
      }
    }

    return ListTile(
      title: answer is String ? Text(answer) : Image.network(answer),
      leading: Radio<int>(
        value: index,
        groupValue: _selectedAnswer,
        onChanged: _validated
            ? null
            : (int? value) {
                setState(() {
                  _selectedAnswer = value;
                });
              },
      ),
      tileColor: color,
    );
  }
}
