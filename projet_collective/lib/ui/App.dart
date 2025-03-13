import 'package:flutter/material.dart';
import 'package:seriouse_game/ui/ListCoursView.dart';
import 'package:seriouse_game/ui/ListModuleView.dart';
import 'package:seriouse_game/ui/Cours/CoursView.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => App(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const ListModulesView()),
        GoRoute(path: '/module', builder: (context, state) => ListCoursView()),
        GoRoute(path: '/cours', builder: (context, state) => CoursView()),
      ],
    ),
  ],
);

class App extends StatefulWidget {
  const App({super.key, this.child});

  final Widget? child;

  @override
  State<App> createState() =>
      _AppState();
}

class _AppState extends State<App> {
  int currentIndex = 0;

  void changeTab(int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/module');
        break;
      case 2:
        // La certification n'est pas implémentée
      default:
        context.go('/');
        break;
    }
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: changeTab,
        backgroundColor: const Color.fromRGBO(252, 179, 48, 1),
        currentIndex: currentIndex,
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
      ),
    );
  }
}

/*
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


*/