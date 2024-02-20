import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:tunda/screens/disease_detection/presentation/fungicides/models/fungicide.dart';

class FungicideRepository {
  late final Map<String, List<Fungicide>> _fungicidesMap = {};
  late Map<String, Map<String, String>> _diseaseInfoMap = {};

  Future<void> loadFungicidesFromJson() async {
    try {
      final jsonString = await rootBundle.loadString('assets/fungicides.json');
      final Map<String, dynamic> data = json.decode(jsonString);
      data.forEach((disease, fungicideList) {
        final List<Fungicide> fungicides = (fungicideList as List)
            .map((item) => Fungicide.fromJson(item, disease))
            .toList();
        _fungicidesMap[disease] = fungicides;
      });
      // Print the loaded fungicides map
      print('Fungicides loaded successfully:');
      _fungicidesMap.forEach((disease, fungicides) {
        print('Disease: $disease');
        for (var fungicide in fungicides) {
          print(
              'Fungicide: ${fungicide.name}, Price: ${fungicide.price}, Image: ${fungicide.image}');
        }
      });
    } catch (e) {
      print('Error loading fungicides: $e');
    }
  }

  Future<List<Fungicide>> getFungicidesForDisease(String disease) async {
    try {
      //check if _fungicidesMap is null or empty
      if (_fungicidesMap.isEmpty) {
        // Perform data loading or re-loading if necessary
        await loadFungicidesFromJson();
      }
      if (_fungicidesMap.containsKey(disease)) {
        return _fungicidesMap[disease]!;
      } else {
        print('Fungicides not found for disease: $disease');
        return [];
      }
    } catch (e) {
      print('Error retrieving fungicides for disease: $disease, Error: $e');
      return [];
    }
  }

  Future<void> loadDiseaseInfoFromJson() async {
    try {
      final jsonString =
          await rootBundle.loadString('assets/signs_and_symptoms.json');
      final Map<String, dynamic> data = json.decode(jsonString);
      _diseaseInfoMap = data.map((key, value) => MapEntry(
            key,
            Map<String, String>.from(value),
          ));
      print('Disease info loaded successfully:');
      _diseaseInfoMap.forEach((disease, info) {
        print('Disease: $disease');
        print('Signs and Symptoms: ${info["signs_and_symptoms"]}');
        print('Measures: ${info["measures"]}');
      });
    } catch (e) {
      print('Error loading disease info: $e');
    }
  }

  Future<Map<String, String>> getDiseaseInfo(String disease) async {
    try {
      if (_diseaseInfoMap.isEmpty) {
        await loadDiseaseInfoFromJson();
      }
      if (_diseaseInfoMap.containsKey(disease)) {
        return _diseaseInfoMap[disease]!;
      } else {
        print('Disease info not found for disease: $disease');
        return {};
      }
    } catch (e) {
      print('Error retrieving disease info for disease: $disease, Error: $e');
      return {};
    }
  }
}
