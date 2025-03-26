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

import 'package:seriouse_game/repositories/QCM/QCMRepository.dart';
import 'package:seriouse_game/repositories/QCM/QuestionRepository.dart';
import 'package:seriouse_game/repositories/QCM/ReponseRepository.dart';

import 'DataBase/database_helper.dart';
import 'models/cours.dart';
import 'models/mediaCours.dart';
import 'models/objectifCours.dart';
import 'models/page.dart';

import 'models/QCM/qcm.dart';
import 'models/QCM/question.dart';
import 'models/QCM/reponse.dart';

import 'package:seriouse_game/ui/CoursSelectionne.dart';

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

  final questionRepo = QuestionRepository();
  final reponseRepo = ReponseRepository();
  final qcmRepo = QCMRepository();

  // Création du Module
  final module = Module(
      titre: 'Module de Journalisme',
      urlImg: 'lib/data/AppData/journalisme.png',
      description: 'Introduction au journalisme');
  final moduleId = await moduleRepository.create(module);

  // Création du Cours
  final cours = Cours(
      idModule: moduleId,
      titre: 'Les sources d’informations',
      contenu: 'Comprendre et évaluer les sources d’information.');
  final coursId = await coursRepository.create(cours);

  // Ajout des Objectifs du Cours
  final objectif1 = ObjectifCours(
    idCours: coursId,
    description: 'Comprendre les différents types de sources d’information',
  );
  final objectif2 = ObjectifCours(
    idCours: coursId,
    description: 'Savoir évaluer la crédibilité d’une source',
  );
  final objectif3 = ObjectifCours(
    idCours: coursId,
    description: 'Identifier les signes de désinformation',
  );
  
  await objectifCoursRepository.create(objectif1);
  await objectifCoursRepository.create(objectif2);
  await objectifCoursRepository.create(objectif3);

  // Page 1 : Introduction aux sources d'information
  Page page1 = Page(idCours: coursId, ordre: 1, description: "Qu'est-ce qu'une source d'information ?");
  int pageId1 = await pageRepository.create(page1);
  
  await mediaCoursRepository.create(MediaCours(
      idPage: pageId1,
      ordre: 1,
      url: 'lib/data/AppData/Module1/Cours1/source_information_definition.txt',
      type: 'text'));

  await mediaCoursRepository.create(MediaCours(
      idPage: pageId1,
      ordre: 2,
      url: 'lib/data/AppData/Module1/Cours1/journaliste_interview.jpg',
      type: 'image',
      caption: 'Journaliste réalisant une interview'));

  // Page 2 : Les différentes sources
  Page page2 = Page(idCours: coursId, ordre: 2, description: "Types de sources d'information");
  int pageId2 = await pageRepository.create(page2);
  
  await mediaCoursRepository.create(MediaCours(
      idPage: pageId2,
      ordre: 1,
      url: 'lib/data/AppData/Module1/Cours1/types_sources.txt',
      type: 'text'));

  await mediaCoursRepository.create(MediaCours(
      idPage: pageId2,
      ordre: 2,
      url: 'lib/data/AppData/Module1/Cours1/source_primaire_secondaire.jpg',
      type: 'image',
      caption: 'Illustration des sources primaires et secondaires'));

  // Page 3 : Évaluer la crédibilité d'une source
  Page page3 = Page(idCours: coursId, ordre: 3, description: "Comment vérifier la fiabilité d'une source ?");
  int pageId3 = await pageRepository.create(page3);
  
  await mediaCoursRepository.create(MediaCours(
      idPage: pageId3,
      ordre: 1,
      url: 'lib/data/AppData/Module1/Cours1/evaluer_sources.txt',
      type: 'text'));

  await mediaCoursRepository.create(MediaCours(
      idPage: pageId3,
      ordre: 2,
      url: 'lib/data/AppData/Module1/Cours1/fake_news_verification.jpg',
      type: 'image',
      caption: 'Techniques de vérification des fake news'));

  /*
  // Création d'une Page liée au cours
  Page page = Page(idCours: coursId, urlAudio: "lib/data/AppData/music.mp3", ordre: 1,description: "page 1");
  int pageId = await pageRepository.create(page);

  MediaCours mediaCours = MediaCours(
      idPage: pageId,
      ordre: 1,
      url: 'lib/data/AppData/goals.png',
      type: 'image',
      caption: 'logo flutter');
  await mediaCoursRepository.create(mediaCours);


  // Création d'une Page liée au cours
  page = Page(idCours: coursId, ordre: 2,description: "page 2");
  pageId = await pageRepository.create(page);

// Insertion de MediaCours lié à cette page
  mediaCours = MediaCours(
      idPage: pageId,
      ordre: 1,
      url: 'lib/data/AppData/explication.txt',
      type: 'text');
  await mediaCoursRepository.create(mediaCours);
  */
  // Init du singleton CoursSelectionne
  CoursSelectionne coursSelectionne = CoursSelectionne.instance;
  List<Cours> lstCours = await coursRepository.getAll();
  coursSelectionne.setCours(lstCours[0]);

  /// Données de test pour les QCM
List<QCM> testQCMs = [
  QCM(
    id: 1,
    numSolution: 2,
    idCours: 1,
    idQuestion: 1,
    question: 
      Question(
        id: 1,
        text: "Quel est le principal indicateur de la fiabilité d’une source d’information ?",
        type: "text",
      ),
    
    reponses: [
      Reponse(id: 1, idQCM: 1, text: "Sa popularité sur les réseaux sociaux", type: "text"),
      Reponse(id: 2, idQCM: 1, text: "La vérifiabilité des informations par d’autres sources fiables", type: "text"),
      Reponse(id: 3, idQCM: 1, text: "Le nombre de commentaires sous l’article", type: "text"),
      Reponse(id: 4, idQCM: 1, text: "Le design du site web", type: "text"),
    ],
  ),
  QCM(
    id: 2,
    numSolution: 2,
    idCours: 1,
    idQuestion: 2,
    question: 
      Question(
        id: 2,
        text: "Quelle est la meilleure manière de vérifier une information trouvée en ligne ?",
        type: "text",
      ),
    
    reponses: [
      Reponse(id: 5, idQCM: 2, text: "La partager immédiatement avec ses amis", type: "text"),
      Reponse(id: 6, idQCM: 2, text: "Consulter plusieurs sources fiables et vérifier la cohérence de l’information", type: "text"),
      Reponse(id: 7, idQCM: 2, text: "Faire confiance à la première source trouvée", type: "text"),
      Reponse(id: 8, idQCM: 2, text: "Vérifier si l’information est amusante avant de la croire", type: "text"),
    ],
  ),
  QCM(
    id: 3,
    numSolution: 2,
    idCours: 1,
    idQuestion: 3,
    question: 
      Question(
        id: 3,
        text: "Quel est un signe révélateur d’une fausse information ?",
        type: "text",
      ),
    
    reponses: [
      Reponse(id: 9, idQCM: 3, text: "Elle provient d’un média reconnu et sérieux", type: "text"),
      Reponse(id: 10, idQCM: 3, text: "Elle utilise un ton sensationnaliste et manque de sources vérifiables", type: "text"),
      Reponse(id: 11, idQCM: 3, text: "Elle cite plusieurs experts et références", type: "text"),
      Reponse(id: 12, idQCM: 3, text: "Elle est reprise par plusieurs médias de confiance", type: "text"),
    ],
  ),
];

  // Insertion des qcm dans la bdd
  for (var qcm in testQCMs) {
    await qcmRepo.insert(qcm);
    await questionRepo.insert(qcm.question!);
    
    for (var reponse in qcm.reponses!) {
      await reponseRepo.insert(reponse);
    }
  }
  
  // Test des repo de qcm
  List<int> allidQCMs = await qcmRepo.getAllIdByCoursId(1);
  print("Test des repo de qcm");
  for (var idQCM in allidQCMs) {
    QCM? qcm = await qcmRepo.getById(idQCM);
    print("QCM récupéré: ${qcm!.id}, Cours: ${qcm!.idCours}");
    
    print("Vérification de la question associée...");
    print("Question: ${qcm!.question!.text}, Type: ${qcm!.question!.type}");
    
    print("Vérification des réponses associées...");
    for (var reponse in qcm!.reponses!) {
      print("Réponse: ${reponse.text}, Type: ${reponse.type}");
    }
  }

  /*
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
  */

  print('Toutes les données d\'exemple ont été insérées avec succès.');
  //testRepositories();
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
