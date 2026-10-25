import 'package:flutter/material.dart';

// Import the four MAIN screens used by the bottom navigation.
import 'package:fyp_app/screens/home_screen.dart';
import 'package:fyp_app/screens/lab_screen.dart';
import 'package:fyp_app/screens/pyp_drill_screen.dart';
import 'package:fyp_app/screens/progress_screen.dart';

void main() {
  // runApp() tells Flutter which widget starts the entire application.
  runApp(const CircuitMateApp());
}


/// ------------------------------------------------------------
/// MAIN APPLICATION
/// ------------------------------------------------------------
/// MaterialApp contains app-wide settings such as:
/// - app name
/// - colour theme
/// - starting screen
///
/// Think of this as the "wrapper" around your whole application.
class CircuitMateApp extends StatelessWidget {
  const CircuitMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CircuitMate',

      // Removes the red DEBUG banner when running the app.
      debugShowCheckedModeBanner: false,

      // App-wide theme.
      // We can replace these colours with your CircuitMate palette later.
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),

        scaffoldBackgroundColor: const Color(0xFFF8FAFF),
      ),

      // This is the first screen Flutter loads.
      home: const MainNavigationScreen(),
    );
  }
}


/// ------------------------------------------------------------
/// MAIN NAVIGATION SCREEN
/// ------------------------------------------------------------
/// We use StatefulWidget here because the selected bottom
/// navigation item CHANGES when the user taps another tab.
///
/// Example:
///
/// Home = index 0
/// Learn = index 1
/// Practice = index 2
/// Progress = index 3
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() =>
      _MainNavigationScreenState();
}


class _MainNavigationScreenState extends State<MainNavigationScreen> {

  // Stores which tab is currently selected.
  //
  // 0 means Home is selected when the app first opens.
  int _currentIndex = 0;


  // These screens correspond directly to the navigation buttons below.
  //
  // IMPORTANT:
  // CircuitLabScreen is temporarily being used as our Learn screen.
  // PypDrillScreen is temporarily being used as our Practice screen.
  //
  // We will rename/rebuild them later.
  final List<Widget> _screens = const [
    HomeScreen(),       // index 0
    CircuitLabScreen(), // index 1 - Learn
    PypDrillScreen(),   // index 2 - Practice
    ProgressScreen(),   // index 3
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      /// IndexedStack shows ONE child at a time based on _currentIndex.
      ///
      /// Why use IndexedStack instead of simply replacing screens?
      ///
      /// Because IndexedStack keeps the other screens alive.
      /// So if a user switches:
      ///
      /// Learn → Home → Learn
      ///
      /// the Learn screen can retain its existing state.
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),


      /// The bottom navigation bar.
      bottomNavigationBar: NavigationBar(

        // Tells Flutter which tab should appear selected.
        selectedIndex: _currentIndex,


        // Runs whenever the user taps a navigation item.
        onDestinationSelected: (int index) {

          // setState() tells Flutter:
          // "Something changed. Rebuild this widget."
          setState(() {
            _currentIndex = index;
          });
        },


        // These are the four buttons visible at the bottom.
        destinations: const [

          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),

          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book),
            label: 'Learn',
          ),

          NavigationDestination(
            icon: Icon(Icons.description_outlined),
            selectedIcon: Icon(Icons.description),
            label: 'Practice',
          ),

          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),

        ],
      ),
    );
  }
}