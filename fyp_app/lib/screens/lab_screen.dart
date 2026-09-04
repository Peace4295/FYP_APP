import 'package:flutter/material.dart';

class CircuitLabScreen extends StatelessWidget {
  const CircuitLabScreen({super.key});

  final List<String> _archetypes = const [
    'Two-Mesh Circuit with Dependent Source',
    'Thévenin & Norton Linear Circuit',
    'Switched First-Order Dynamic Circuit (RC/RL)',
    'Second-Order RLC Damping Circuit',
    'AC Power & Power Factor Correction Branch',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Circuit Lab')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: _archetypes.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return Card(
            elevation: 1,
            child: ListTile(
              leading: CircleAvatar(child: Text('${index + 1}')),
              title: Text(_archetypes[index], style: const TextStyle(fontWeight: FontWeight.w600)),
              trailing: const Icon(Icons.play_circle_fill, color: Colors.blue),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}