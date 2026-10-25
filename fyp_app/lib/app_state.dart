import 'package:flutter/material.dart';

/// ------------------------------------------------------------
/// APP STATE
/// ------------------------------------------------------------
///
/// This class stores information that needs to be shared
/// between MULTIPLE screens.
///
/// Example:
///
/// Guided PYP completes
///        ↓
/// q1Mastery changes
///        ↓
/// Progress screen automatically updates
///
/// We use ChangeNotifier because it can tell Flutter:
/// "My data changed — rebuild anything listening to me."
class AppState extends ChangeNotifier {
  // ------------------------------------------------------------
  // CURRENT USER PROGRESS
  // ------------------------------------------------------------

  double q1Mastery = 0.50;
  double q2Mastery = 0.25;
  double q3Mastery = 0.00;

  int xp = 120;
  int streak = 5;

  bool dailyGoalCompleted = false;

  // Prevents the same guided PYP from awarding XP repeatedly
  // during the same app session.
  bool guidedPypCompleted = false;

  // ------------------------------------------------------------
  // COMPLETE GUIDED PYP
  // ------------------------------------------------------------
  void completeGuidedPyp() {
    // If already completed, don't give rewards again.
    if (guidedPypCompleted) {
      return;
    }

    guidedPypCompleted = true;

    // Increase Q1 Mastery by 10%.
    //
    // clamp prevents mastery from going above 100%.
    q1Mastery = (q1Mastery + 0.10).clamp(0.0, 1.0).toDouble();

    // Reward XP.
    xp += 20;

    // Completing a meaningful learning activity
    // satisfies today's goal.
    dailyGoalCompleted = true;

    // Tell Flutter that the values changed.
    notifyListeners();
  }
}

/// ------------------------------------------------------------
/// GLOBAL APP STATE
/// ------------------------------------------------------------
///
/// We create ONE AppState object that the whole app can use.
///
/// This is okay for our MVP.
/// Later, we may replace this with a more scalable state
/// management solution and database persistence.
final appState = AppState();