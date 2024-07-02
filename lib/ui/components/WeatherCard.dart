import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherCard extends StatelessWidget {
  final String title;
  final String rainPct;
  final String location;
  final String? weekDay;
  const WeatherCard({
    required this.title,
    required this.rainPct,
    required this.location,
    this.weekDay,
    super.key,
  });

  String getWeatherIconPath(String title) {
    switch (title) {
      case 'Ensolarado':
        return 'assets/icons/sunnyIcon.png';
      case 'Parcialmente Nublado':
        return 'assets/icons/partlyCloudyIcon.png';
      case 'Chuvoso':
        return 'assets/icons/rainyIcon.png';
      case 'Nublado':
        return 'assets/icons/cloudyIcon.png';
      default:
        return 'assets/icons/sunnyIcon.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(16),
              child: Image.asset(
                getWeatherIconPath(title),
                height: 55,
                width: 55,
              )),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Text(weekDay == null ? location : '$weekDay',
                        style: Theme.of(context).textTheme.bodyMedium),
                    if (weekDay != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                        child: Text(location,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/rainPctIcon.svg',
                        colorFilter: const ColorFilter.mode(
                            Color(0xFF649BDB), BlendMode.srcIn),
                        height: 24,
                        width: 24,
                      ),
                      Text(
                        '$rainPct%',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: const Color(0xFF737373)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
