import 'package:flutter/material.dart';

class DiseaseDetailsWidget extends StatelessWidget {
  final String diseaseName;
  final String signsAndSymptoms;
  final String preventiveMeasures;

  const DiseaseDetailsWidget({
    Key? key,
    required this.diseaseName,
    required this.signsAndSymptoms,
    required this.preventiveMeasures,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disease Details: $diseaseName'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Signs and Symptoms:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              signsAndSymptoms,
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Preventive Measures:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              preventiveMeasures,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
