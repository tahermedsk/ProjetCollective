import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page Content'),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}

class BottomNavigationBarScaffold extends StatefulWidget {
  const BottomNavigationBarScaffold({super.key, this.child});

  final Widget? child;

  @override
  State<BottomNavigationBarScaffold> createState() => _BottomNavigationBarScaffoldState();
}

class _BottomNavigationBarScaffoldState extends State<BottomNavigationBarScaffold> {
  int currentIndex = 0;

  void changeTab(int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/modules');
        break;
      case 2:
        context.go('/cours');
        break;
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
        title: const Text('Header App'),
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        onTap: changeTab,
        backgroundColor: const Color(0xffe0b9f6),
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.folder), label: 'Modules'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Cours'),
        ],
      ),
    );
  }
}

class CoursView extends StatelessWidget {
  const CoursView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cours')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go('/cours/description'),
              child: const Text('Aller à la Description'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/cours/contenu'),
              child: const Text('Aller au Contenu'),
            ),
          ],
        ),
      ),
    );
  }
}

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Description')),
      body: const Center(child: Text('Page de Description')),
    );
  }
}

class Contenu extends StatelessWidget {
  const Contenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contenu')),
      body: const Center(child: Text('Page de Contenu')),
    );
  }
}

class ModulesView extends StatelessWidget {
  const ModulesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Modules')),
      body: const Center(child: Text('Page des Modules')),
    );
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => BottomNavigationBarScaffold(child: child),
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(path: '/modules', builder: (context, state) => const ModulesView()),
        GoRoute(path: '/cours', builder: (context, state) => const CoursView()),
        GoRoute(path: '/cours/description', builder: (context, state) => const Description()),
        GoRoute(path: '/cours/contenu', builder: (context, state) => const Contenu()),
      ],
    ),
  ],
);
