import 'package:flutter/material.dart';
import 'package:regapp/ui/components/IrrigationCard.dart';

class IrrigationList extends StatelessWidget {
  IrrigationList({super.key});

  final List<Map<String, String>> irrigationData = [
    {'title': 'Samambaia', 'timeLeft': '15 min', 'location': 'Interna'},
    {'title': 'Orquídea', 'timeLeft': '25 min', 'location': 'Interna'},
    {'title': 'Bromélia', 'timeLeft': '35 min', 'location': 'Interna'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: _buildPlantCards(),
    );
  }

  List<Widget> _buildPlantCards() {
    List<Widget> irrigationCards = [];

    for (var plant in irrigationData) {
      irrigationCards.add(
        IrrigationCard(
          title: plant['title']!,
          timeLeft: plant['timeLeft']!,
          location: plant['location']!,
        ),
      );
      irrigationCards.add(const SizedBox(height: 8));
    }

    return irrigationCards;
  }
}
