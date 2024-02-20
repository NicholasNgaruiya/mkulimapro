import 'package:flutter/material.dart';

// Define custom data models for the homepage content
class FarmingSolution {
  final String title;
  final String description;
  final IconData iconData;

  FarmingSolution({required this.title, required this.description, required this.iconData});
}

// Dummy data for farming solutions
List<FarmingSolution> farmingSolutions = [
  FarmingSolution(
    title: "Crop Management",
    description: "Track your crops' growth and manage their health effectively.",
    iconData: Icons.agriculture,
  ),
  FarmingSolution(
    title: "Weather Forecast",
    description: "Stay informed about weather conditions to plan your farming activities.",
    iconData: Icons.wb_sunny,
  ),
  FarmingSolution(
    title: "Market Insights",
    description: "Access market trends and make informed decisions about selling your produce.",
    iconData: Icons.trending_up,
  ),
  FarmingSolution(
    title: "Disease Detection",
    description: "Detect diseases in plants early and take appropriate actions.",
    iconData: Icons.warning,
  ),
];

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farming Solutions"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Explore Farming Solutions",
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1.0,
                ),
                itemCount: farmingSolutions.length,
                itemBuilder: (context, index) {
                  return _buildFarmingSolutionCard(context, farmingSolutions[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFarmingSolutionCard(BuildContext context, FarmingSolution solution) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          // Implement navigation to detailed solution page
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(solution.iconData, size: 50, color: Theme.of(context).primaryColor),
            SizedBox(height: 10),
            Text(
              solution.title,
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                solution.description,
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}