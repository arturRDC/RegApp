import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlantCard extends StatelessWidget {
  final String title;
  const PlantCard({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/water_droplet.svg',
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF649BDB), BlendMode.srcIn),
                  height: 24,
                  width: 24,
                ),
                const Text('15 min')
              ],
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
