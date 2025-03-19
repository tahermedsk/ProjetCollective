import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seriouse_game/ui/LaunchScreen/LaunchScreenView.dart';
import 'package:seriouse_game/ui/ListCoursView.dart';
import 'package:seriouse_game/ui/ListModuleView.dart';
import 'package:seriouse_game/ui/Cours/CoursView.dart';

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
        GoRoute(path: '/module', builder: (context, state) => const ListCoursView()),
        GoRoute(path: '/cours', builder: (context, state) => CoursView()),
      ],
    ),
  ],
);

class App extends StatefulWidget {
  const App({super.key, this.child});

  final Widget? child;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int currentIndex = 0;
  bool showLaunchScreen = true;

  void changeTab(int index) {
    switch (index) {
      case 0:
        context.go('/cours');
        break;
      case 1:
        context.go('/module');
        break;
      case 2:
      default:
        context.go('/');
        break;
    }
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3700), () {
      setState(() {
        showLaunchScreen = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(252, 179, 48, 1),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/data/AppData/CharteFactoscope/logo-factoscope_seul.png',
                  height: 40,
                  width: 190,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 10),
              ],
            ),
            centerTitle: true,
          ),
          body: widget.child!,
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(41, 36, 96, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: BottomNavigationBar(
              onTap: changeTab,
              backgroundColor: Colors.transparent,
              currentIndex: currentIndex,
              unselectedItemColor: Colors.white,
              selectedItemColor: const Color.fromRGBO(252, 179, 48, 1),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Icon(Icons.home),
                  ),
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
          ),
        ),

        // Met le LaunchScreenView au-dessus de tout
        if (showLaunchScreen)
          Positioned.fill(
            child: LaunchScreenView(),
          ),
      ],
    );
  }
}