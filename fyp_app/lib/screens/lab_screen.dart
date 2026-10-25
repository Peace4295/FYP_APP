import 'package:flutter/material.dart';
import 'package:fyp_app/screens/q1_journey_screen.dart';
import 'package:fyp_app/app_state.dart';

class CircuitLabScreen extends StatefulWidget {
  const CircuitLabScreen({super.key});

  @override
  State<CircuitLabScreen> createState() => _CircuitLabScreenState();
}

class _CircuitLabScreenState extends State<CircuitLabScreen> {
  // This variable remembers which tab the user selected.
  //
  // 0 = Journey
  // 1 = Simulator
  int _selectedMode = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // --------------------------------------------------
            // PAGE TITLE
            // --------------------------------------------------
            const Text(
              'Choose a learning journey',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Learn step-by-step or explore circuits interactively.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 20),

            // --------------------------------------------------
            // JOURNEY / SIMULATOR SWITCH
            // --------------------------------------------------
            Row(
              children: [
                Expanded(
                  child: _buildModeButton(
                    title: 'Journey',
                    icon: Icons.menu_book_outlined,
                    index: 0,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: _buildModeButton(
                    title: 'Simulator',
                    icon: Icons.science_outlined,
                    index: 1,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // --------------------------------------------------
            // CONDITIONAL CONTENT
            // --------------------------------------------------
            //
            // If selectedMode is 0, show learning journeys.
            //
            // Otherwise, show simulator options.
            if (_selectedMode == 0)
              _buildJourneySection()
            else
              _buildSimulatorSection(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // MODE BUTTON
  // ============================================================
  //
  // This creates the Journey / Simulator buttons.
  Widget _buildModeButton({
    required String title,
    required IconData icon,
    required int index,
  }) {
    // Check whether THIS button is currently selected.
    final bool isSelected = _selectedMode == index;

    return FilledButton.tonal(
      onPressed: () {
        // setState tells Flutter:
        // "Something changed. Please redraw this screen."
        setState(() {
          _selectedMode = index;
        });
      },

      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),

        // Change the appearance depending on selection.
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primaryContainer
            : Colors.grey.shade200,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // JOURNEY MODE
  // ============================================================
  Widget _buildJourneySection() {
    return Column(
      children: [
        _buildJourneyCard(
          title: 'Q1 Mastery',
          subtitle: 'Circuit Fundamentals & Amplifiers',
          progress: 0.50,
        ),

        const SizedBox(height: 14),

        _buildJourneyCard(
          title: 'Q2 Mastery',
          subtitle: 'Transient & Switching Analysis',
          progress: 0.25,
        ),

        const SizedBox(height: 14),

        _buildJourneyCard(
          title: 'Q3 Mastery',
          subtitle: 'AC & Network Analysis',
          progress: 0.00,
        ),
      ],
    );
  }

  // ============================================================
  // ONE JOURNEY CARD
  // ============================================================
  Widget _buildJourneyCard({
    required String title,
    required String subtitle,
    required double progress,

    // VoidCallback means:
    // "a function that runs when something is tapped."
    VoidCallback? onTap,
  }) {
    final int percentage = (progress * 100).round();

    return Card(
      child: InkWell(
        // Later, tapping Q1 will open the Q1 Journey screen.
        onTap: () {
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Q1JourneyScreen(),
          ),
        );
        },

        borderRadius: BorderRadius.circular(12),

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    child: Icon(Icons.show_chart),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          subtitle,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
              ),

              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: Text('$percentage%'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SIMULATOR MODE
  // ============================================================
  Widget _buildSimulatorSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Select circuit type',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        _buildSimulatorCard(
          title: 'Op-Amp Simulator',
          subtitle: 'Explore inverting and non-inverting amplifiers',
          icon: Icons.change_history,
          available: true,
        ),

        const SizedBox(height: 12),

        _buildSimulatorCard(
          title: 'Thévenin / Norton',
          subtitle: 'Visualise equivalent circuits',
          icon: Icons.electrical_services,
          available: false,
        ),

        const SizedBox(height: 12),

        _buildSimulatorCard(
          title: 'RC Transient',
          subtitle: 'Explore capacitor charging and discharging',
          icon: Icons.timeline,
          available: false,
        ),
      ],
    );
  }

  // ============================================================
  // ONE SIMULATOR CARD
  // ============================================================
  Widget _buildSimulatorCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool available,
  }) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          available ? subtitle : '$subtitle\nComing soon',
        ),

        trailing: Icon(
          available
              ? Icons.arrow_forward_ios
              : Icons.lock_outline,
          size: 18,
        ),

        // Only allow tapping if the simulator is available.
        //
        // null means the ListTile is disabled.
        onTap: available
            ? () {
                // Later we will navigate to OpAmpSimulatorScreen.
              }
            : null,
      ),
    );
  }
}