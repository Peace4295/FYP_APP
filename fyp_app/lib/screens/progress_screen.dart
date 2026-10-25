import 'package:flutter/material.dart';
import 'package:fyp_app/app_state.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// AnimatedBuilder listens to appState.
    ///
    /// Whenever appState calls notifyListeners(),
    /// this builder runs again and the screen updates.
    return AnimatedBuilder(
      animation: appState,
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                // ------------------------------------------------
                // TITLE
                // ------------------------------------------------
                const Text(
                  'Your Progress',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 6),

                const Text(
                  'Keep track of your EE2101 revision.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(height: 24),

                // ------------------------------------------------
                // STREAK + XP
                // ------------------------------------------------
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.local_fire_department,
                        value: '${appState.streak} days',
                        label: 'Current streak',
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _buildStatCard(
                        icon: Icons.star_outline,
                        value: '${appState.xp} XP',
                        label: 'Total XP',
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),

                // ------------------------------------------------
                // QUESTION MASTERY
                // ------------------------------------------------
                const Text(
                  'Question Mastery',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 18),

                _buildMasterySection(
                  title: 'Q1 Mastery',
                  subtitle: 'Circuit Fundamentals & Amplifiers',
                  progress: appState.q1Mastery,
                ),

                const SizedBox(height: 22),

                _buildMasterySection(
                  title: 'Q2 Mastery',
                  subtitle: 'Transient & Switching Analysis',
                  progress: appState.q2Mastery,
                ),

                const SizedBox(height: 22),

                _buildMasterySection(
                  title: 'Q3 Mastery',
                  subtitle: 'AC & Network Analysis',
                  progress: appState.q3Mastery,
                ),

                const SizedBox(height: 28),

                // ------------------------------------------------
                // TODAY'S ACTIVITY
                // ------------------------------------------------
                const Text(
                  "Today's Activity",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Card(
                  child: ListTile(
                    leading: Icon(
                      appState.dailyGoalCompleted
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,

                      color: appState.dailyGoalCompleted
                          ? Colors.green
                          : Colors.grey,
                    ),

                    title: Text(
                      appState.dailyGoalCompleted
                          ? 'Daily goal completed!'
                          : 'Complete one learning activity',
                    ),

                    subtitle: Text(
                      appState.dailyGoalCompleted
                          ? 'Nice work — keep your streak going.'
                          : 'Complete a lesson, simulator activity or PYP.',
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ------------------------------------------------
                // RECENT ACTIVITY
                // ------------------------------------------------
                const Text(
                  'Recent Activity',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                if (appState.guidedPypCompleted)
                  const Card(
                    child: ListTile(
                      leading: Icon(
                        Icons.check_circle_outline,
                        color: Colors.green,
                      ),
                      title: Text(
                        '2025/26 Sem 2 · Q1(a)',
                      ),
                      subtitle: Text(
                        'Guided PYP completed · +20 XP',
                      ),
                    ),
                  )
                else
                  const Text(
                    'No activities completed yet.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // STAT CARD
  // ============================================================
  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30,
            ),

            const SizedBox(height: 8),

            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MASTERY SECTION
  // ============================================================
  Widget _buildMasterySection({
    required String title,
    required String subtitle,
    required double progress,
  }) {
    final percentage = (progress * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              '$percentage%',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 10),

        LinearProgressIndicator(
          value: progress,
          minHeight: 8,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}