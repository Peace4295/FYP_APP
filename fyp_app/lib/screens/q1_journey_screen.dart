import 'package:flutter/material.dart';
import 'package:fyp_app/screens/op_amp_simulator_screen.dart';
import 'package:fyp_app/screens/guided_pyp_screen.dart';
import 'package:fyp_app/app_state.dart';

class Q1JourneyScreen extends StatelessWidget {
  const Q1JourneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
    animation: appState,
    builder: (context, child) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [

            // --------------------------------------------------
            // TOP BAR
            // --------------------------------------------------
            Row(
              children: [
                // Back button.
                IconButton(
                  onPressed: () {
                    // Navigator.pop means:
                    // go back to the previous screen.
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),

                const SizedBox(width: 4),

                const Expanded(
                  child: Text(
                    'Q1 Mastery',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            const Text(
              'Circuit Fundamentals & Amplifiers',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 16),

            // --------------------------------------------------
            // OVERALL Q1 PROGRESS
            // --------------------------------------------------
            const Text(
              'Your progress',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 8),

            LinearProgressIndicator(
              value: appState.q1Mastery,
              minHeight: 8,
            ),

            const SizedBox(height: 6),

            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${(appState.q1Mastery * 100).round()}%',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 28),

            // --------------------------------------------------
            // LEARNING JOURNEY
            // --------------------------------------------------
            const Text(
              'Learning Journey',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 22),

            // Lesson 1
            _buildJourneyNode(
              context: context,
              title: 'Op-Amp Basics',
              subtitle: 'Introduction to ideal op-amp behaviour',
              icon: Icons.check,
              completed: true,
            ),

            _buildConnector(),

            // Lesson 2
            _buildJourneyNode(
              context: context,
              title: 'Inverting vs Non-Inverting',
              subtitle: 'Learn how to identify each configuration',
              icon: Icons.school_outlined,
              completed: false,
            ),

            _buildConnector(),

            // Simulator
            _buildJourneyNode(
              context: context,
              title: 'Op-Amp Simulator',
              subtitle: 'Explore how R₁ and R₂ affect voltage gain',
              icon: Icons.science_outlined,
              completed: false,

              // We will connect this to the simulator later.
              onTap: () {
                Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OpAmpSimulatorScreen(),
                ),
              );
              },
            ),

            _buildConnector(),

            // Guided Past Year Paper
            _buildJourneyNode(
              context: context,
              title: 'Guided PYP',
              subtitle: '2025/26 Semester 2 - Q1(a)',
              icon: Icons.description_outlined,
              completed: false,

              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const GuidedPypScreen(),
                  ),
                );
              },
            ),

            _buildConnector(),

            // Final checkpoint
            _buildJourneyNode(
              context: context,
              title: 'Q1 Checkpoint',
              subtitle: 'Complete the Q1 mastery challenge',
              icon: Icons.emoji_events_outlined,
              completed: false,
              locked: true,
            ),
          ],
        ),
      ),
    );
  }
  );
    }
}

  // ============================================================
  // JOURNEY NODE
  // ============================================================
  //
  // This helper creates ONE lesson/node in the learning path.
  Widget _buildJourneyNode({
    required BuildContext context, 
    required String title,
    required String subtitle,
    required IconData icon,
    required bool completed,

    bool locked = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      // If the lesson is locked, disable tapping.
      onTap: locked ? null : onTap,

      borderRadius: BorderRadius.circular(16),

      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
        ),

        child: Row(
          children: [

            // --------------------------------------------------
            // CIRCLE ICON
            // --------------------------------------------------
            Container(
              width: 58,
              height: 58,

              decoration: BoxDecoration(
                shape: BoxShape.circle,

                // Completed lessons use the main theme colour.
                // Locked lessons are grey.
                color: completed
                    ? Colors.green.shade100
                    : locked
                        ? Colors.grey.shade200
                        : Theme.of(context)
                            .colorScheme
                            .primaryContainer,
              ),

              child: Icon(
                locked
                    ? Icons.lock_outline
                    : icon,

                size: 28,

                color: completed
                    ? Colors.green.shade700
                    : locked
                        ? Colors.grey
                        : Theme.of(context)
                            .colorScheme
                            .primary,
              ),
            ),

            const SizedBox(width: 16),

            // --------------------------------------------------
            // LESSON INFORMATION
            // --------------------------------------------------
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,

                      // Grey out locked lessons.
                      color: locked
                          ? Colors.grey
                          : null,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    locked
                        ? 'Locked'
                        : subtitle,

                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // Show an arrow only if the node is accessible.
            if (!locked)
              const Icon(
                Icons.chevron_right,
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // CONNECTOR LINE
  // ============================================================
  //
  // This creates the vertical line between journey nodes.
  Widget _buildConnector() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 28,
      ),

      child: Container(
        width: 2,
        height: 28,
        color: Colors.grey.shade300,
      ),
    );
  }
