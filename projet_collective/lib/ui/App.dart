import 'package:flutter/material.dart';
import 'package:seriouse_game/models/mediaCours.dart';
import 'package:seriouse_game/ui/Contenu/WidgetContenu/ContenuVideoWidget.dart';
import 'Contenu/ContenuCoursViewModel.dart';

class App extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<App> {
  int _selectedIndex = 0;


  final List<Widget> _pages = [
    Center(child: Text('Page Home')),
    Center(child: Text('Page Modules')),
    Center(child: Text('Page Certification')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    //TestVideo

    ContenuVideoWidget video = ContenuVideoWidget();

    video.fileLoader = ContenuCoursViewModel();

    video.data = MediaCours(id : 1, idPage: 1, ordre: 1, url: 'lib/data/AppData/test.mp4', type: 'video',);


    //

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/data/AppData/facto-logo.png',
                height: 40, // Ajuste la hauteur
                fit: BoxFit.contain, // Garde les proportions
              ),
              const SizedBox(width: 10), // Espace entre l'image et le texte
              const Text('Factoscope'),
            ],
          ),
          centerTitle: true,
        ),
        body: Center(
          child: video,
          ),
        //_pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Modules',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.verified),
              label: 'Certification',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color.fromRGBO(252, 179, 48, 1),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
