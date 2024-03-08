import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunda/screens/disease_detection/cart/bloc/cart_bloc.dart';
import 'package:tunda/screens/disease_detection/cart/cart_item.dart';
// import 'package:tunda/presentation/fungicides/bloc/recommended_fungicides_bloc.dart';
// import 'package:tunda/presentation/fungicides/models/fungicide.dart';
// import 'package:tunda/presentation/fungicides/widgets/recommended_fungicide_card.dart';
import 'package:tunda/screens/disease_detection/presentation/fungicides/bloc/recommended_fungicides_bloc.dart';
import 'package:tunda/screens/disease_detection/presentation/fungicides/models/fungicide.dart';
import 'package:tunda/screens/disease_detection/presentation/fungicides/widgets/recommended_fungicide_card.dart';

class FungicideRecommendationWidget extends StatefulWidget {
  const FungicideRecommendationWidget({Key? key}) : super(key: key);

  @override
  _FungicideRecommendationWidgetState createState() =>
      _FungicideRecommendationWidgetState();
}

class _FungicideRecommendationWidgetState
    extends State<FungicideRecommendationWidget> {
  bool showSymptoms = true;
  List<CartItem> cartItems = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedFungicidesBloc, RecommendedFungicidesState>(
      builder: (context, state) {
        if (state is RecommendedFungicidesLoaded) {
          final List<Fungicide> fungicides = state.fungicides;
          final Map<String, String> diseaseInfo = state.diseaseInfo;
          print('UI fungicides are :$fungicides');
          // No need to filter fungicides based on the disease label
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showSymptoms = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: showSymptoms ? Colors.teal : Colors.green[50],
                        // borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Symptoms',
                        style: TextStyle(
                          color: showSymptoms ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showSymptoms = false;
                      });
                    },
                    child: Container(
                      color: !showSymptoms ? Colors.teal : Colors.green[50],
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Text(
                        'Measures',
                        style: TextStyle(
                          color: !showSymptoms ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              showSymptoms
                  ? Container(
                      color: Colors.green[50],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Signs and Symptoms ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(diseaseInfo['signs_and_symptoms'] ??
                              'No information available'),
                          // Text(
                          //   'Signs and symptoms of blight in maize serve as early indicators of infection, aiding in prompt intervention to mitigate its impact. Characteristic symptoms include lesions on leaves, which initially appear as small, water-soaked spots that later develop into larger, irregularly shaped lesions with necrotic centers. As the disease progresses, lesions may spread to leaf sheaths, stalks, and husks, leading to premature death of the plant. Additionally, infected plants may exhibit wilting and stunted growth, accompanied by reduced grain quality and yield. Regular scouting of fields and close monitoring of maize plants for these telltale signs are essential for early detection and management of blight disease, ultimately safeguarding maize production.',
                          // ),
                        ],
                      ),
                    )
                  : Container(
                      color: Colors.green[50],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Precautionary Measures',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(diseaseInfo['measures'] ??
                              'No information available'),
                          // Text(
                          //   'Blight in maize, caused by fungal pathogens such as Exserohilum turcicum, can devastate crops if not managed effectively. Precautionary measures against this disease involve a combination of cultural practices and chemical treatments. Farmers should opt for resistant maize varieties whenever possible and rotate crops to reduce pathogen buildup in the soil. Additionally, maintaining proper spacing between plants promotes airflow and reduces humidity, creating an unfavorable environment for fungal growth. Timely removal of infected plant debris and sanitation in the field are crucial to prevent the spread of spores. Implementing fungicide treatments, especially during periods of high disease pressure, can further protect maize crops from blight.',
                          // ),
                        ],
                      ),
                    ),
              const SizedBox(height: 20),
              const Text(
                'Recommended Fungicides ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.teal,
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 20.0,
                ),
                itemCount: fungicides.length,
                itemBuilder: (BuildContext context, int index) {
                  final fungicide = fungicides[index];
                  return RecomendPlantCard(
                    title: fungicide.name,
                    country: 'Kenya',
                    price: fungicide.price,
                    image: fungicide.image,
                    press: () {
                      BlocProvider.of<CartBloc>(context).add(AddToCartEvent(
                          CartItem(
                              name: fungicide.name,
                              price: fungicide.price,
                              image: fungicide.image)));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${fungicide.name} added to cart'),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          );
        } else if (state is RecommendedFungicidesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return const Center(
            child: Text('Recommended agrichemicals  to be displayed below:'),
          );
        }
      },
    );
  }
}
