import 'package:flutter/material.dart';

class cours extends StatelessWidget {
  const cours({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 2,
          title: HeaderWidget(),
          centerTitle: false,
        ),
        body: const Center(
          child: Text("Contenu de la page"),
        ),
        bottomNavigationBar: FooterWidget(
          courseTitle: "Cours 1",
          pageNumber: 1,
        ), 
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Bouton Lecture
        IconButton(
          icon: Icon(Icons.play_arrow, color: Colors.black),
          onPressed: () {
            // Action pour le bouton lecture
          },
        ),
        const SizedBox(width: 8),
        // Titre
        Text(
          'Cours 1',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(), // Espace flexible pour pousser la barre à droite
        // Barre de progression
        Expanded(
          flex: 2,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 0.5, // Progression à 50%
              minHeight: 6,
              color: Colors.teal,
              backgroundColor: Colors.teal.withOpacity(0.2),
            ),
          ),
        ),
      ],
    );
  }
}

class FooterWidget extends StatelessWidget {
  final String courseTitle;
  final int pageNumber;

  const FooterWidget({
    Key? key,
    required this.courseTitle,
    required this.pageNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Bouton flèche gauche
          IconButton(
            icon: const Icon(Icons.arrow_left, size: 28),
            onPressed: () {
              // Action pour aller à la page précédente
            },
          ),
          // Texte de pagination
          Text(
            '$courseTitle : Page $pageNumber',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          // Bouton flèche droite
          IconButton(
            icon: const Icon(Icons.arrow_right, size: 28),
            onPressed: () {
              // Action pour aller à la page suivante
            },
          ),
        ],
      ),
    );
  }
}