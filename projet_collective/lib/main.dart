import 'package:flutter/material.dart';
import 'package:seriouse_game/DataBase/database_helper.dart';
import 'package:seriouse_game/models/cours.dart';
import 'package:seriouse_game/service_locator.dart';
import 'package:seriouse_game/services/asset_pack_menager.dart';
import 'package:seriouse_game/services/coursService.dart';
import 'data_initializer.dart';

import 'ui/App.dart';

void main() {
  setupLocator();
  //runApp(App());
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // Insérer des données d'exemple après le lancement de l'UI
    Future.delayed(Duration.zero, () async {
      await insertSampleData();
      AssetLoader assetLoader =  AssetLoader();
      assetLoader.loadAssetPack("example");
      // Test fetching an asset path
      String? assetPath = await assetLoader.getAssetPath("example", 1, "image_", ".png");
      print("Asset Path: $assetPath");

      // Test checking asset pack state
      await assetLoader.checkAssetPackState("example");

      // Test listening to asset pack status
      assetLoader.listenToAssetPackStatus((status) {
        print("Asset Pack Status Update: $status");
      });
      //await testRepositories();
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


