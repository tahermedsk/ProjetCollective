import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:seriouse_game/services/coursService.dart';
import 'package:seriouse_game/models/cours.dart';

class DescriptionView extends StatefulWidget {
  const DescriptionView({Key? key}) : super(key: key);

  @override
  State<DescriptionView> createState() => _DescriptionViewState();
}

class _DescriptionViewState extends State<DescriptionView> {
  final CoursService coursService = GetIt.I<CoursService>();
  Cours? cours;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCours();
  }

  Future<void> fetchCours() async {
    final fetchedCours = await coursService.getCoursWithObjectifs(1);
    setState(() {
      cours = fetchedCours;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Description du Cours")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cours == null
          ? const Center(child: Text("Aucun cours trouvé."))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cours!.titre,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              cours!.contenu,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),
            Text(
              "Objectifs : ${cours!.objectifs?.length ?? 0}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            // ... ajoutez ici l'affichage détaillé des objectifs si besoin
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Action pour démarrer le cours
                print("Commencer le cours");
              },
              child: const Text("Commencer le cours"),
            ),
          ],
        ),
      ),
    );
  }
}
