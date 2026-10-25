import 'package:flutter/material.dart';
import 'package:fyp_app/app_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea prevents content from going underneath
      // the phone notch / status bar.
      body: SafeArea(
        child: ListView(
          // Gives the whole page spacing from the screen edges.
          padding: const EdgeInsets.all(20),
          children: [

            // --------------------------------------------------
            // 1. GREETING + PROFILE ICON
            // --------------------------------------------------
            Row(
              // Pushes the greeting to the left
              // and profile icon to the right.
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  // Align text to the left.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Afternoon,',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Pris!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                // For now this is just an icon.
                // Later we can make this open ProfileScreen.
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.account_circle_outlined,
                    size: 36,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // --------------------------------------------------
            // 2. STREAK + XP
            // --------------------------------------------------
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.local_fire_department,
                            size: 30,
                          ),
                          const SizedBox(width: 10),

                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '5 day streak',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Keep it going!',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star,
                            size: 30,
                          ),
                          const SizedBox(width: 10),

                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '120 XP',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Great progress!',
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // --------------------------------------------------
            // 3. CONTINUE WHERE YOU LEFT OFF
            // --------------------------------------------------
            const Text(
              'Continue where you left off',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Card(
              child: ListTile(
                leading: const Icon(
                  Icons.description_outlined,
                  size: 32,
                ),

                title: const Text(
                  '2025/26 Sem 2 - Q1(a)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                subtitle: const Text(
                  'Step 2 of 3\nGuided PYP · Op-Amp',
                ),

                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                ),

                // Later this will navigate back into the question.
                onTap: () {},
              ),
            ),

            const SizedBox(height: 24),

            // --------------------------------------------------
            // 4. TODAY'S GOAL
            // --------------------------------------------------
            const Text(
              "Today's goal",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.track_changes),
                        SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            'Complete 1 lesson or practice question today!',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // 0.0 means 0%.
                    const LinearProgressIndicator(
                      value: 0.0,
                    ),

                    const SizedBox(height: 8),

                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '0 / 1',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --------------------------------------------------
            // 5. QUESTION MASTERY
            // --------------------------------------------------
            const Text(
              'Question Mastery',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            // Instead of repeating the same code three times,
            // we use a helper function below.
            _buildMasteryRow(
              title: 'Q1 Mastery',
              progress: 0.50,
            ),

            const SizedBox(height: 16),

            _buildMasteryRow(
              title: 'Q2 Mastery',
              progress: 0.25,
            ),

            const SizedBox(height: 16),

            _buildMasteryRow(
              title: 'Q3 Mastery',
              progress: 0.00,
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // HELPER WIDGET
  // ----------------------------------------------------------
  // This function creates one mastery progress row.
  //
  // We reuse it for Q1, Q2 and Q3 instead of writing
  // the same layout three separate times.
  Widget _buildMasteryRow({
    required String title,
    required double progress,
  }) {
    // Convert 0.50 into 50, 0.25 into 25, etc.
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
                fontWeight: FontWeight.w600,
              ),
            ),
            Text('$percentage%'),
          ],
        ),

        const SizedBox(height: 8),

        LinearProgressIndicator(
          value: progress,
          minHeight: 8,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}