import 'package:flutter/material.dart';

class PlanSchedulePage extends StatelessWidget {
  const PlanSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Schedule')),
      body: const Center(child: Text('Plan Schedule')),
    );
  }
}
