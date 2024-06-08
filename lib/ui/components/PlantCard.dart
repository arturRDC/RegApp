import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PlantCard extends StatelessWidget {
  final String title;
  final String timeLeft;
  final String location;
  final String waterNeeds;
  const PlantCard({
    required this.title,
    required this.timeLeft,
    required this.location,
    required this.waterNeeds,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              'assets/icons/edit_square.svg',
              colorFilter:
                  const ColorFilter.mode(Color(0xFF1C1B1F), BlendMode.srcIn),
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/waterDropletsIcon.svg',
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                              Color(0xFF737373), BlendMode.srcIn),
                        ),
                        Text(
                          '$waterNeeds ml',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: const Color(0xFF737373)),
                        ),
                      ],
                    ),
                    Text(location,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/icons/pottedPlantIcon.png',
                    height: 69,
                    width: 59,
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
