import 'package:flutter/material.dart';

class OpAmpSimulatorScreen extends StatefulWidget {
  const OpAmpSimulatorScreen({super.key});

  @override
  State<OpAmpSimulatorScreen> createState() =>
      _OpAmpSimulatorScreenState();
}

class _OpAmpSimulatorScreenState extends State<OpAmpSimulatorScreen> {
  // ------------------------------------------------------------
  // STATE VARIABLES
  // ------------------------------------------------------------
  // These values can change while the app is running.
  //
  // We start with simple default values:
  // R1 = 1 kΩ
  // R2 = 5 kΩ
  // Vin = 1 V
  double r1 = 1.0;
  double r2 = 5.0;
  double vin = 1.0;

  // false = non-inverting
  // true = inverting
  bool isInverting = false;

  // ------------------------------------------------------------
  // CALCULATIONS
  // ------------------------------------------------------------

  double get gain {
    if (isInverting) {
      // Inverting op-amp:
      // Av = -R2 / R1
      return -r2 / r1;
    } else {
      // Non-inverting op-amp:
      // Av = 1 + R2 / R1
      return 1 + (r2 / r1);
    }
  }

  double get vout {
    // Vout = Av × Vin
    return gain * vin;
  }

  @override
  Widget build(BuildContext context) {
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
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),

                const SizedBox(width: 4),

                const Expanded(
                  child: Text(
                    'Op-Amp Simulator',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            const Text(
              'Adjust the circuit values and observe how the output changes.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 24),

            // --------------------------------------------------
            // OP-AMP TYPE SELECTOR
            // --------------------------------------------------
            Row(
              children: [
                Expanded(
                  child: ChoiceChip(
                    label: const Text('Non-Inverting'),

                    selected: !isInverting,

                    onSelected: (_) {
                      setState(() {
                        isInverting = false;
                      });
                    },
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ChoiceChip(
                    label: const Text('Inverting'),

                    selected: isInverting,

                    onSelected: (_) {
                      setState(() {
                        isInverting = true;
                      });
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // --------------------------------------------------
            // PLACEHOLDER CIRCUIT DIAGRAM
            // --------------------------------------------------
            //
            // For now, we use a simple visual placeholder.
            // Later we can replace this with a proper circuit diagram.
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Icon(
                      Icons.change_history,
                      size: 80,
                    ),

                    const SizedBox(height: 10),

                    Text(
                      isInverting
                          ? 'Inverting Op-Amp'
                          : 'Non-Inverting Op-Amp',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      isInverting
                          ? 'Av = -R₂ / R₁'
                          : 'Av = 1 + R₂ / R₁',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 28),

            // --------------------------------------------------
            // R1 CONTROL
            // --------------------------------------------------
            _buildSliderControl(
              label: 'R₁',
              value: r1,
              min: 1,
              max: 10,
              unit: 'kΩ',

              onChanged: (newValue) {
                setState(() {
                  r1 = newValue;
                });
              },
            ),

            const SizedBox(height: 22),

            // --------------------------------------------------
            // R2 CONTROL
            // --------------------------------------------------
            _buildSliderControl(
              label: 'R₂',
              value: r2,
              min: 1,
              max: 20,
              unit: 'kΩ',

              onChanged: (newValue) {
                setState(() {
                  r2 = newValue;
                });
              },
            ),

            const SizedBox(height: 22),

            // --------------------------------------------------
            // VIN CONTROL
            // --------------------------------------------------
            _buildSliderControl(
              label: 'Vin',
              value: vin,
              min: 0.5,
              max: 5.0,
              unit: 'V',

              onChanged: (newValue) {
                setState(() {
                  vin = newValue;
                });
              },
            ),

            const SizedBox(height: 28),

            // --------------------------------------------------
            // RESULTS
            // --------------------------------------------------
            const Text(
              'Results',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: _buildResultCard(
                    title: 'Gain, Av',
                    value: gain.toStringAsFixed(2),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: _buildResultCard(
                    title: 'Vout',
                    value: '${vout.toStringAsFixed(2)} V',
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // --------------------------------------------------
            // EXPLANATION
            // --------------------------------------------------
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.lightbulb_outline),
                        SizedBox(width: 8),

                        Text(
                          'Why did this happen?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Text(
                      isInverting
                          ? 'For an inverting amplifier, the gain is Av = -R₂/R₁. Increasing R₂ increases the magnitude of the gain, while the negative sign indicates that the output is inverted.'
                          : 'For a non-inverting amplifier, the gain is Av = 1 + R₂/R₁. Increasing R₂ increases the gain, so Vout becomes larger for the same Vin.',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --------------------------------------------------
            // RESET BUTTON
            // --------------------------------------------------
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  // Restore our starting values.
                  r1 = 1.0;
                  r2 = 5.0;
                  vin = 1.0;
                  isInverting = false;
                });
              },

              icon: const Icon(Icons.refresh),

              label: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // REUSABLE SLIDER CONTROL
  // ============================================================
  Widget _buildSliderControl({
    required String label,
    required double value,
    required double min,
    required double max,
    required String unit,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            Text(
              '${value.toStringAsFixed(1)} $unit',
            ),
          ],
        ),

        Slider(
          value: value,
          min: min,
          max: max,

          // Gives the slider visible steps.
          divisions: 18,

          label: value.toStringAsFixed(1),

          onChanged: onChanged,
        ),
      ],
    );
  }

  // ============================================================
  // REUSABLE RESULT CARD
  // ============================================================
  Widget _buildResultCard({
    required String title,
    required String value,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}