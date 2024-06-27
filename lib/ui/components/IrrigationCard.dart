import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IrrigationCard extends StatefulWidget {
  final String title;
  final DateTime nextIrrigation;
  final String location;
  final String waterNeeds;
  const IrrigationCard({
    required this.title,
    required this.nextIrrigation,
    required this.location,
    required this.waterNeeds,
    super.key,
  });

  @override
  State<IrrigationCard> createState() => _IrrigationCardState();
}

class _IrrigationCardState extends State<IrrigationCard> {
  var now = DateTime.now();

  String _getTimeLeft(DateTime nextIrrigation) {
    Duration difference = nextIrrigation.difference(now);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;

    List<String> parts = [];

    if (days > 0) {
      parts.add('$days ${days == 1 ? "dia" : "dias"}');
    } else if (hours > 0) {
      parts.add('$hours ${hours == 1 ? "hora" : "horas"}');
    } else if (minutes > 0) {
      parts.add('$minutes ${minutes == 1 ? "minuto" : "minutos"}');
    }

    if (parts.isEmpty) {
      return "Agora";
    } else if (parts.length == 1) {
      return parts[0];
    } else if (parts.length == 2) {
      return "${parts[0]} e ${parts[1]}";
    } else {
      return "${parts[0]}, ${parts[1]} e ${parts[2]}";
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
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/waterDropletIcon.svg',
                  colorFilter: const ColorFilter.mode(
                      Color(0xFF649BDB), BlendMode.srcIn),
                  height: 24,
                  width: 24,
                ),
                Text(
                  _getTimeLeft(widget.nextIrrigation),
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
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
                      widget.title,
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
                          '${widget.waterNeeds} ml',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: const Color(0xFF737373)),
                        ),
                      ],
                    ),
                    Text(widget.location,
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
