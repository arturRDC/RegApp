import 'package:flutter/material.dart';
import 'package:regapp/ui/components/PlantCard.dart';

class PlantList extends StatelessWidget {
  PlantList({super.key});

  final List<Map<String, String>> irrigationData = [
    {
      'title': 'Samambaia',
      'timeLeft': '15 min',
      'location': 'Interna',
      'waterNeeds': '150'
    },
    {
      'title': 'Orquídea',
      'timeLeft': '25 min',
      'location': 'Interna',
      'waterNeeds': '200'
    },
    {
      'title': 'Bromélia',
      'timeLeft': '35 min',
      'location': 'Interna',
      'waterNeeds': '300'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: _buildPlantCards(),
    );
  }

  List<Widget> _buildPlantCards() {
    List<Widget> plantCards = [];

    for (var plant in irrigationData) {
      plantCards.add(
        PlantCard(
          title: plant['title']!,
          timeLeft: plant['timeLeft']!,
          waterNeeds: plant['waterNeeds']!,
          location: plant['location']!,
        ),
      );
      plantCards.add(const SizedBox(height: 8));
    }

    return plantCards;
  }
}
