import 'package:flutter/material.dart';
import 'package:regapp/ui/components/WeatherCard.dart';
import 'package:regapp/ui/components/WeatherList.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  int currentPageIndex = 0;
  final Map<String, String> weatherNow = {
    'title': 'Ensolarado',
    'location': 'Natal - RN',
    'weekDay': 'Segunda',
    'rainPct': '15'
  };
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Clima Agora',
                style: Theme.of(context).textTheme.headlineSmall),
            WeatherCard(
                title: weatherNow['title']!,
                rainPct: weatherNow['rainPct']!,
                location: weatherNow['location']!),
            Text('Esta semana',
                style: Theme.of(context).textTheme.headlineSmall),
            WeatherList(),
          ],
        ),
      ),
    );
  }
}
