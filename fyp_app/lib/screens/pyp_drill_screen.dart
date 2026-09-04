import 'package:flutter/material.dart';

class PypDrillScreen extends StatelessWidget {
  const PypDrillScreen({super.key});

  final List<String> _papers = const [
    'AY2023 - 2024 Semester 1',
    'AY2022 - 2023 Semester 1',
    'AY2021 - 2022 Semester 1',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PYP Exam Drill')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _papers.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(_papers[index], style: const TextStyle(fontWeight: FontWeight.bold)),
            leading: const Icon(Icons.description),
            children: List.generate(4, (qIndex) {
              return ListTile(
                title: Text('Question ${qIndex + 1}'),
                subtitle: Text('Topic: ${qIndex == 0 ? "DC Theorems" : qIndex == 1 ? "Transients" : "AC Analysis"}'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              );
            }),
          );
        },
      ),
    );
  }
}