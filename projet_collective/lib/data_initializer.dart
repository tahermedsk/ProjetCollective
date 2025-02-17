import 'package:seriouse_game/models/module.dart';
import 'package:seriouse_game/models/mot.dart';
import 'package:seriouse_game/models/motsCroises.dart';
import 'package:seriouse_game/models/minijeu.dart';
import 'package:seriouse_game/repositories/coursRepository.dart';

import 'package:seriouse_game/repositories/moduleRepository.dart';
import 'package:seriouse_game/repositories/motRepository.dart';
import 'package:seriouse_game/repositories/motsCroisesRepository.dart';
import 'package:seriouse_game/repositories/minijeuRepository.dart';
import 'package:seriouse_game/repositories/mediaCoursRepository.dart';
import 'package:seriouse_game/repositories/objectifCoursRepository.dart';
import 'package:seriouse_game/repositories/pageRepository.dart';

import 'DataBase/database_helper.dart';
import 'models/cours.dart';
import 'models/mediaCours.dart';
import 'models/objectifCours.dart';
import 'models/page.dart';

Future<void> insertSampleData() async {
  await DatabaseHelper.instance.resetDatabase();

  final moduleRepository = ModuleRepository();
  final coursRepository = CoursRepository();
  final motRepository = MotRepository();
  final motsCroisesRepository = MotsCroisesRepository();
  final miniJeuRepository = MiniJeuRepository();
  final mediaCoursRepository = MediaCoursRepository();
  final pageRepository = PageRepository();
  final objectifCoursRepository = ObjectifCoursRepository();

  // Création d'un Module
  final module = Module(
      titre: 'Module de Journalisme',
      description: 'Introduction au journalisme');
  final moduleId = await moduleRepository.create(module);

  // Création d'une Cours
  final cours = Cours(
      idModule: moduleId,
      titre: 'Introduction à la presse',
      contenu: 'Le journalisme moderne...');
  final coursId = await coursRepository.create(cours);


  // Création des objectifs du cours
  final objectif1 = ObjectifCours(
    idCours: coursId,
    description: 'Comprendre les bases du journalisme',
  );
  final objectif2 = ObjectifCours(
    idCours: coursId,
    description: 'Apprendre les techniques d’interview',
  );
  await objectifCoursRepository.create(objectif1);
  await objectifCoursRepository.create(objectif2);
  print('Objectifs du cours ajoutés.');



  // Création d'une Page liée au cours
  final page = Page(idCours: coursId, ordre: 1,description: "page 1");
  final pageId = await pageRepository.create(page);

// Insertion de MediaCours lié à cette page
  final mediaCours = MediaCours(
      idPage: pageId,
      ordre: 1,
      url: 'https://media.example.com/video.mp4',
      type: 'video',
      caption: 'Vidéo explicative');
  await mediaCoursRepository.create(mediaCours);

  // Création de Mots (Mots pour le MotsCroises)
  final mot1 = Mot(
      idMotsCroises: 1,
      mot: 'journalisme',
      indice: 'Domaine d’étude',
      direction: 'horizontal',
      positionDepartX: 0,
      positionDepartY: 0);
  final mot2 = Mot(
      idMotsCroises: 1,
      mot: 'presse',
      indice: 'Média écrit',
      direction: 'vertical',
      positionDepartX: 1,
      positionDepartY: 1);
  await motRepository.create(mot1);
  await motRepository.create(mot2);

  // Création de MotsCroises
  final motsCroises = MotsCroises(idMiniJeu: 1, tailleGrille: '10x10');
  final motsCroisesId = await motsCroisesRepository.create(motsCroises);

  // Création d'un MiniJeu
  final miniJeu = MiniJeu(
      idCours: coursId,
      nom: 'Jeu de mots croisés',
      description: 'Mini-jeu de mots croisés sur le journalisme',
      progression: 0);
  final miniJeuId = await miniJeuRepository.create(miniJeu);

  print('Toutes les données d\'exemple ont été insérées avec succès.');
  testRepositories();
}

Future<void> testRepositories() async {
  final moduleRepository = ModuleRepository();
  final coursRepository = CoursRepository();
  final motRepository = MotRepository();
  final motsCroisesRepository = MotsCroisesRepository();
  final miniJeuRepository = MiniJeuRepository();
  final mediaCoursRepository = MediaCoursRepository();
  final pageRepository = PageRepository();
  final objectifCoursRepository = ObjectifCoursRepository();

  // --- Test Objectif ---
  print('--- Test Objectif ---');

// Récupérer tous les objectifs
  final allObjectifs = await objectifCoursRepository.getAll();
  print('Objectifs disponibles : ${allObjectifs.map((e) => e.description).toList()}');

// Récupérer un objectif par ID
  final objectif = allObjectifs.first;
  final fetchedObjectif = await objectifCoursRepository.getById(objectif.id!);
  print('Objectif récupéré par ID : ${fetchedObjectif?.description}');

// Supprimer un objectif
  await objectifCoursRepository.delete(objectif.id!);
  print('Objectif supprimé.');
  

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
  print(
      'Mots croisés disponibles : ${allMotsCroises.map((e) => e.tailleGrille).toList()}');

  // Récupérer un mots croisés par ID
  final motsCroises = allMotsCroises.first;
  final fetchedMotsCroises =
      await motsCroisesRepository.getById(motsCroises.id!);
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

  // --- Test MediaCours ---
  print('--- Test MediaCours ---');

  // Récupérer tous les médias
  final allMedias = await mediaCoursRepository.getAll();
  print('Médias disponibles : ${allMedias.map((e) => e.url).toList()}');

  // Récupérer un média par ID
  final media = allMedias.first;
  final fetchedMedia = await mediaCoursRepository.getById(media.id!);
  print('Média récupéré par ID : ${fetchedMedia?.url}');

  // Supprimer un média
  //await mediaCoursRepository.delete(media.id!);
  //print('Média supprimé.');

  // --- Test Page ---
  print('--- Test Page ---');

// Récupérer toutes les pages
  final allPages = await pageRepository.getAll();
  print('Pages disponibles : ${allPages.map((e) => e.id).toList()}');

// Récupérer une page par ID
  if (allPages.isNotEmpty) {
    final page = allPages.first;
    final fetchedPage = await pageRepository.getById(page.id!);
    print('Page récupérée par ID : ${fetchedPage?.id} liée au cours : ${fetchedPage?.idCours}');

    // Supprimer une page
    //await pageRepository.delete(page.id!);
    //print('Page supprimée.');
  } else {
    print('Aucune page disponible pour le test.');
  }

  // --- Test Cours ---
  print('--- Test Cours ---');

  // Récupérer toutes les courss
  final allCours = await coursRepository.getAll();
  print('Cours disponibles : ${allCours.map((e) => e.titre).toList()}');

  // Récupérer une cours par ID
  final cours = allCours.first;
  final fetchedCours = await coursRepository.getById(cours.id!);
  print('Cours récupérée par ID : ${fetchedCours?.titre}');

  // méthode loadContenu(Cours cours)
  cours.pages = await pageRepository.getPagesByCourseId(cours.id!);
  print("Nombre de page récupéré : ${cours.pages?.length}");

  for (int i=0; i<cours!.pages!.length; i++) {
      cours.pages![i].medias = await mediaCoursRepository.getByPageId(cours.pages![i].id!);
      print(cours.pages![i].medias?.length);
    }
  
  


  // Supprimer une cours
  await coursRepository.delete(cours.id!);
  print('Cours supprimée.');
  // --- Test Module ---
  print('--- Test Module ---');

  // Récupérer tous les module
  final allModulees = await moduleRepository.getAll();
  print('Module disponibles : ${allModulees.map((e) => e.titre).toList()}');

  // Récupérer un module par ID
  final module = allModulees.first;
  final fetchedModule = await moduleRepository.getById(module.id!);
  print('Module récupéré par ID : ${fetchedModule?.titre}');

  // Supprimer un module
  await moduleRepository.delete(module.id!);
  print('Module supprimé.');
}
