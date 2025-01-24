import 'package:seriouse_game/models/cours.dart';
import 'package:seriouse_game/models/lecon.dart';
import 'package:seriouse_game/models/mot.dart';
import 'package:seriouse_game/models/motsCroises.dart';
import 'package:seriouse_game/models/minijeu.dart';
import 'package:seriouse_game/models/mediaLecon.dart';

import 'package:seriouse_game/repositories/coursRepository.dart';
import 'package:seriouse_game/repositories/leconRepository.dart';
import 'package:seriouse_game/repositories/motRepository.dart';
import 'package:seriouse_game/repositories/motsCroisesRepository.dart';
import 'package:seriouse_game/repositories/minijeuRepository.dart';
import 'package:seriouse_game/repositories/mediaLeconRepository.dart';

Future<void> insertSampleData() async {
  final coursRepository = CoursRepository();
  final leconRepository = LeconRepository();
  final motRepository = MotRepository();
  final motsCroisesRepository = MotsCroisesRepository();
  final miniJeuRepository = MiniJeuRepository();
  final mediaLeconRepository = MediaLeconRepository();

  // Création d'un Cours
  final cours = Cours(titre: 'Cours de Journalisme', description: 'Introduction au journalisme');
  final coursId = await coursRepository.create(cours);

  // Création d'une Lecon
  final lecon = Lecon(idCours: coursId, titre: 'Introduction à la presse', contenu: 'Le journalisme moderne...');
  final leconId = await leconRepository.create(lecon);

  // Création de Mots (Mots pour le MotsCroises)
  final mot1 = Mot(idMotsCroises: 1, mot: 'journalisme', indice: 'Domaine d’étude', direction: 'horizontal', positionDepartX: 0, positionDepartY: 0);
  final mot2 = Mot(idMotsCroises: 1, mot: 'presse', indice: 'Média écrit', direction: 'vertical', positionDepartX: 1, positionDepartY: 1);
  await motRepository.create(mot1);
  await motRepository.create(mot2);

  // Création de MotsCroises
  final motsCroises = MotsCroises(idMiniJeu: 1, tailleGrille: '10x10');
  final motsCroisesId = await motsCroisesRepository.create(motsCroises);

  // Création d'un MiniJeu
  final miniJeu = MiniJeu(idLecon: leconId, nom: 'Jeu de mots croisés', description: 'Mini-jeu de mots croisés sur le journalisme', progression: 0);
  final miniJeuId = await miniJeuRepository.create(miniJeu);

  // Création d'un MediaLecon
  final mediaLecon = MediaLecon(idLecon: leconId, id: 1, url: 'https://media.example.com/video.mp4', type: 'video', caption: 'Vidéo explicative');
  await mediaLeconRepository.create(mediaLecon);

  print('Toutes les données d\'exemple ont été insérées avec succès.');
}


Future<void> testRepositories() async {
  final coursRepository = CoursRepository();
  final leconRepository = LeconRepository();
  final motRepository = MotRepository();
  final motsCroisesRepository = MotsCroisesRepository();
  final miniJeuRepository = MiniJeuRepository();
  final mediaLeconRepository = MediaLeconRepository();

  // --- Test Cours ---
  print('--- Test Cours ---');

  // Récupérer tous les cours
  final allCourses = await coursRepository.getAll();
  print('Cours disponibles : ${allCourses.map((e) => e.titre).toList()}');

  // Récupérer un cours par ID
  final cours = allCourses.first;
  final fetchedCours = await coursRepository.getById(cours.id!);
  print('Cours récupéré par ID : ${fetchedCours?.titre}');



  // Supprimer un cours
  await coursRepository.delete(cours.id!);
  print('Cours supprimé.');

  // --- Test Lecon ---
  print('--- Test Leçon ---');

  // Récupérer toutes les leçons
  final allLecons = await leconRepository.getAll();
  print('Leçons disponibles : ${allLecons.map((e) => e.titre).toList()}');

  // Récupérer une leçon par ID
  final lecon = allLecons.first;
  final fetchedLecon = await leconRepository.getById(lecon.id!);
  print('Leçon récupérée par ID : ${fetchedLecon?.titre}');

 

  // Supprimer une leçon
  await leconRepository.delete(lecon.id!);
  print('Leçon supprimée.');

  // --- Test Mot ---
  print('--- Test Mot ---');

  // Récupérer tous les mots
  final allMots = await motRepository.getAll();
  print('Mots disponibles : ${allMots.map((e) => e.mot).toList()}');

  // Récupérer un mot par ID
  final mot = allMots.first;
  final fetchedMot = await motRepository.getById(mot.id!);
  print('Mot récupéré par ID : ${fetchedMot?.mot}');


  // Supprimer un mot
  await motRepository.delete(mot.id!);
  print('Mot supprimé.');

  // --- Test MotsCroises ---
  print('--- Test MotsCroises ---');

  // Récupérer tous les mots croisés
  final allMotsCroises = await motsCroisesRepository.getAll();
  print('Mots croisés disponibles : ${allMotsCroises.map((e) => e.tailleGrille).toList()}');

  // Récupérer un mots croisés par ID
  final motsCroises = allMotsCroises.first;
  final fetchedMotsCroises = await motsCroisesRepository.getById(motsCroises.id!);
  print('Mots croisés récupérés par ID : ${fetchedMotsCroises?.tailleGrille}');


  // Supprimer un mots croisés
  await motsCroisesRepository.delete(motsCroises.id!);
  print('Mots croisés supprimé.');

  // --- Test MiniJeu ---
  print('--- Test MiniJeu ---');

  // Récupérer tous les mini-jeux
  final allMiniJeux = await miniJeuRepository.getAll();
  print('Mini-jeux disponibles : ${allMiniJeux.map((e) => e.nom).toList()}');

  // Récupérer un mini-jeu par ID
  final miniJeu = allMiniJeux.first;
  final fetchedMiniJeu = await miniJeuRepository.getById(miniJeu.id!);
  print('Mini-jeu récupéré par ID : ${fetchedMiniJeu?.nom}');


  // Supprimer un mini-jeu
  await miniJeuRepository.delete(miniJeu.id!);
  print('Mini-jeu supprimé.');

  // --- Test MediaLecon ---
  print('--- Test MediaLecon ---');

  // Récupérer tous les médias
  final allMedias = await mediaLeconRepository.getAll();
  print('Médias disponibles : ${allMedias.map((e) => e.url).toList()}');

  // Récupérer un média par ID
  final media = allMedias.first;
  final fetchedMedia = await mediaLeconRepository.getById(media.id);
  print('Média récupéré par ID : ${fetchedMedia?.url}');


  // Supprimer un média
  await mediaLeconRepository.delete(media.id);
  print('Média supprimé.');
}
