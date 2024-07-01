import 'package:flutter/material.dart';
import 'package:regapp/ui/components/WeatherCard.dart';

class WeatherList extends StatelessWidget {
  WeatherList({super.key});

  final List<Map<String, String>> weatherData = [
    {
      'title': 'Chuvoso',
      'location': 'Natal - RN',
      'weekDay': 'Segunda',
      'rainPct': '15'
    },
    {
      'title': 'Nublado',
      'location': 'Natal - RN',
      'weekDay': 'Terça',
      'rainPct': '35'
    },
    {
      'title': 'Ensolarado',
      'location': 'Natal - RN',
      'weekDay': 'Quarta',
      'rainPct': '25'
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
    List<Widget> weatherCards = [];

    for (var weather in weatherData) {
      weatherCards.add(
        WeatherCard(
          title: weather['title']!,
          rainPct: weather['rainPct']!,
          weekDay: weather['weekDay']!,
          location: weather['location']!,
        ),
      );
      weatherCards.add(const SizedBox(height: 8));
    }

    return weatherCards;
  }
}
