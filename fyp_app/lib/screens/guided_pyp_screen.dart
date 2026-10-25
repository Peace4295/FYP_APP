import 'package:flutter/material.dart';
import 'package:fyp_app/app_state.dart';

class GuidedPypScreen extends StatefulWidget {
  const GuidedPypScreen({super.key});

  @override
  State<GuidedPypScreen> createState() => _GuidedPypScreenState();
}

class _GuidedPypScreenState extends State<GuidedPypScreen> {
  // ------------------------------------------------------------
  // STATE VARIABLES
  // ------------------------------------------------------------

  // Which step of the guided question the student is currently on.
  //
  // 0 = identify op-amp configuration
  // 1 = choose gain formula
  // 2 = determine input resistance
  int currentStep = 0;

  // Stores which answer the student selected.
  //
  // null means no answer has been selected yet.
  int? selectedOption;

  // Keeps track of whether the student has checked their answer.
  bool answerChecked = false;

  // Whether the current answer is correct.
  bool isCorrect = false;

  // ------------------------------------------------------------
  // CHECK ANSWER
  // ------------------------------------------------------------

  void checkAnswer(int correctOption) {
    // Prevent checking if nothing has been selected.
    if (selectedOption == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an answer first.'),
        ),
      );

      return;
    }

    setState(() {
      answerChecked = true;

      // Example:
      //
      // selectedOption = 1
      // correctOption = 1
      //
      // therefore:
      // isCorrect = true
      isCorrect = selectedOption == correctOption;
    });
  }

  // ------------------------------------------------------------
  // MOVE TO NEXT STEP
  // ------------------------------------------------------------

  void goToNextStep() {
    if (currentStep < 2) {
      setState(() {
        currentStep++;

        // Reset the answer state for the next question.
        selectedOption = null;
        answerChecked = false;
        isCorrect = false;
      });
    } else {
      // We have completed all 3 guided steps.
      _showCompletionDialog();
    }
  }

  // ------------------------------------------------------------
  // COMPLETION POPUP
  // ------------------------------------------------------------

  void _showCompletionDialog() {
    // Update the shared progress data.
    appState.completeGuidedPyp();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Guided PYP Complete! 🎉'),
          content: const Text(
            'You completed 2025/26 Semester 2 Q1(a).\n\n'
            'Later, this will update your Q1 Mastery and XP.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Close the popup.
                Navigator.pop(context);

                // Return to the Q1 Journey.
                Navigator.pop(context);
              },
              child: const Text('Back to Journey'),
            ),
          ],
        );
      },
    );
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
                    'Guided PYP',
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
              '2025/26 Semester 2 · Q1(a)',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            // --------------------------------------------------
            // STEP PROGRESS
            // --------------------------------------------------

            Text(
              'Step ${currentStep + 1} of 3',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            LinearProgressIndicator(
              // currentStep starts at 0.
              //
              // So:
              // Step 1 = 1/3
              // Step 2 = 2/3
              // Step 3 = 3/3
              value: (currentStep + 1) / 3,
              minHeight: 8,
            ),

            const SizedBox(height: 28),

            // --------------------------------------------------
            // QUESTION CONTENT
            // --------------------------------------------------

            // We show a different question depending
            // on the current step.
            if (currentStep == 0)
              _buildStepOne()
            else if (currentStep == 1)
              _buildStepTwo()
            else
              _buildStepThree(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // STEP 1
  // ============================================================

  Widget _buildStepOne() {
    return _buildQuestionCard(
      question:
          'Without doing any calculations, determine whether the circuit is inverting or non-inverting.',

      options: const [
        'Inverting',
        'Non-inverting',
        'Cannot be determined',
      ],

      // Option index 1 = "Non-inverting"
      correctOption: 1,

      explanation:
          'The input signal is connected to the non-inverting (+) terminal. '
          'The output is fed back to the inverting (-) terminal, creating negative feedback.',
    );
  }

  // ============================================================
  // STEP 2
  // ============================================================

  Widget _buildStepTwo() {
    return _buildQuestionCard(
      question:
          'Which voltage gain expression applies to this ideal non-inverting amplifier?',

      options: const [
        'Av = -R₂ / R₁',
        'Av = 1 + R₂ / R₁',
        'Av = R₁ / R₂',
      ],

      // Option index 1 is correct again.
      correctOption: 1,

      explanation:
          'For an ideal non-inverting amplifier, the closed-loop voltage gain is:\n\n'
          'Av = 1 + R₂ / R₁',
    );
  }

  // ============================================================
  // STEP 3
  // ============================================================

  Widget _buildStepThree() {
    return _buildQuestionCard(
      question:
          'For an ideal op-amp, what is the equivalent input resistance Rin?',

      options: const [
        'Rin = R₁',
        'Rin = R₁ + R₂',
        'Rin → ∞',
      ],

      // Option index 2 = infinite input resistance.
      correctOption: 2,

      explanation:
          'An ideal op-amp draws zero current at its input.\n\n'
          'Since Rin = Vin / Iin and Iin = 0, the equivalent input resistance approaches infinity.',
    );
  }

  // ============================================================
  // REUSABLE QUESTION CARD
  // ============================================================

  Widget _buildQuestionCard({
    required String question,
    required List<String> options,
    required int correctOption,
    required String explanation,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ------------------------------------------------------
        // QUESTION
        // ------------------------------------------------------

        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Text(
              question,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        const SizedBox(height: 18),

        // ------------------------------------------------------
        // ANSWER OPTIONS
        // ------------------------------------------------------

        // List.generate lets us create one widget
        // for every answer inside the options list.
        ...List.generate(
          options.length,
          (index) {
            final bool isSelected = selectedOption == index;

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                onTap: () {
                  // Once the student has checked the answer,
                  // don't let them change it anymore.
                  if (!answerChecked) {
                    setState(() {
                      selectedOption = index;
                    });
                  }
                },

                borderRadius: BorderRadius.circular(12),

                child: Container(
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),

                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.grey.shade300,

                      width: isSelected ? 2 : 1,
                    ),
                  ),

                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          options[index],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),

        const SizedBox(height: 12),

        // ------------------------------------------------------
        // CHECK ANSWER BUTTON
        // ------------------------------------------------------

        if (!answerChecked)
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                checkAnswer(correctOption);
              },

              child: const Text('Check Answer'),
            ),
          ),

        // ------------------------------------------------------
        // FEEDBACK
        // ------------------------------------------------------

        if (answerChecked) ...[
          const SizedBox(height: 14),

          Container(
            width: double.infinity,

            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),

              color: isCorrect
                  ? Colors.green.shade50
                  : Colors.red.shade50,
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      isCorrect
                          ? Icons.check_circle
                          : Icons.cancel,

                      color: isCorrect
                          ? Colors.green
                          : Colors.red,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      isCorrect
                          ? 'Correct!'
                          : 'Not quite.',

                      style: TextStyle(
                        fontWeight: FontWeight.bold,

                        color: isCorrect
                            ? Colors.green.shade800
                            : Colors.red.shade800,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Text(explanation),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Only allow students to continue
          // once they have chosen the correct answer.
          if (isCorrect)
            SizedBox(
              width: double.infinity,

              child: FilledButton.icon(
                onPressed: goToNextStep,

                icon: Icon(
                  currentStep == 2
                      ? Icons.check
                      : Icons.arrow_forward,
                ),

                label: Text(
                  currentStep == 2
                      ? 'Complete Guided PYP'
                      : 'Next Step',
                ),
              ),
            ),

          // If wrong, let them try again.
          if (!isCorrect)
            SizedBox(
              width: double.infinity,

              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    selectedOption = null;
                    answerChecked = false;
                    isCorrect = false;
                  });
                },

                child: const Text('Try Again'),
              ),
            ),
        ],
      ],
    );
  }
}