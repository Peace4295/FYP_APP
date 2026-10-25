import 'package:flutter/material.dart';

// This screen will eventually show:
// - Q1 / Q2 / Q3 mastery
// - streak
// - XP
// - recent activity
//
// For now, we only need a placeholder so that our navigation works.
class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Progress Screen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}