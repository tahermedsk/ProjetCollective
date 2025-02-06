import 'package:flutter/material.dart';
import 'package:seriouse_game/widgets/DescriptionView.dart';

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
        body: _pages[_selectedIndex],
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
