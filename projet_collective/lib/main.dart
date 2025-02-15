import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seriouse_game/DataBase/database_helper.dart';
import 'package:seriouse_game/ui/Contenu/ContenuCoursView.dart';
import 'package:seriouse_game/ui/Home.dart';
import 'package:seriouse_game/ui/Module.dart';
import 'package:seriouse_game/ui/Cours.dart';
import 'package:seriouse_game/ui/Description/DescriptionCoursView.dart';

import 'data_initializer.dart';

import 'ui/App.dart';

void main() {
  runApp(App());
  //runApp(MyApp());
}

// Configuration des routes
final GoRouter appRouter = GoRouter(
  routes: <RouteBase>[
    //route vers Home avec un nom
    GoRoute(
      path: '/home/:nom',
      builder: (BuildContext context, GoRouterState state) {
        final String homeName = state.pathParameters['nom']!;
        return Home(nom: homeName);  //passage du nom à la page Home
      },
    ),
    //route vers un module avec un nom
    GoRoute(
      path: '/module/:nom',
      builder: (BuildContext context, GoRouterState state) {
        final String moduleName = state.pathParameters['nom']!;
        return Module(nom: moduleName);  //passage du nom à la page Module
      },
    ),
    GoRoute(
      path: '/cours/:id',
      builder: (BuildContext context, GoRouterState state) {
        final String coursId = state.pathParameters['id']!;
        return cours(CoursId: coursId);
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'contenu',
          builder: (BuildContext context, GoRouterState state) {
            final String coursId = state.pathParameters['id']!;
            return ContenuCoursView(CoursId: coursId);
          },
        ),
        GoRoute(
          path: 'description',
          builder: (BuildContext context, GoRouterState state) {
            final String coursId = state.pathParameters['id']!;
            return DescriptionCoursView(CoursId: coursId);
            },
          ),
          //GoRoute(
            //path: 'jeux',
            //builder: (BuildContext context, GoRouterState state) {
              //return ContenuCoursView();
            //},
          //),
        ],
      ),
  ],
);



class MyApp extends StatefulWidget {
  const MyApp({super.key});


  // Configuration des routes
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
    );
  }


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // Insérer des données d'exemple après le lancement de l'UI
    Future.delayed(Duration.zero, () async {
      await insertSampleData();  // Appel de la fonction qui insère les données via les repositories
      await testRepositories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(

          title: const Text("Courses List"),
        ),
        body: const Center(
          child: Text("Hello"),
        ),

      ),
    );
  }
}


