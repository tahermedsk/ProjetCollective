import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seriouse_game/DataBase/database_helper.dart';
import 'package:seriouse_game/ui/Contenu/ContenuCoursView.dart';
import 'package:seriouse_game/ui/Cours.dart';
import 'package:seriouse_game/ui/Description/DescriptionCoursView.dart';

import 'data_initializer.dart';

import 'ui/App.dart';

void main() {
  runApp(App());
  //runApp(MyApp());
}

// Configuration des routes
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/cours/:id',
      builder: (BuildContext context, GoRouterState state) {
        final String CoursId = state.pathParameters['id']!;  // Récupère l'ID  depuis l'URL
        return  cours(CoursId: CoursId);
      },
      routes: <RouteBase>[
        // Sous-pages pour le cours
        GoRoute(
          path: 'contenu',
          builder: (BuildContext context, GoRouterState state) {
            final String CoursId = state.pathParameters['id']!;  // Récupère l'ID de l'utilisateur depuis l'UR
            return  ContenuCoursView(CoursId: CoursId);

          },
        ),
        GoRoute(
          path: 'description',
          builder: (BuildContext context, GoRouterState state) {
            final String CoursId = state.pathParameters['id']!;  // Récupère l'ID
            return  DescriptionCoursView(CoursId: CoursId);

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
      routerConfig: _router,
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


