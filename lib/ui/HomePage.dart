import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:regapp/ui/components/IrrigationList.dart';
import 'package:regapp/ui/components/WeatherCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final currentHour = currentTime.hour;

    String greeting;

    if (currentHour < 12) {
      greeting = 'Bom Dia';
    } else if (currentHour < 18) {
      greeting = 'Boa Tarde';
    } else {
      greeting = 'Boa Noite';
    }

    const user = 'User';

    return Container(
      padding: const EdgeInsets.all(24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$greeting, $user',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: GestureDetector(
                onTap: () => context.push('/irrigations'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Próximas irrigações',
                        style: Theme.of(context).textTheme.headlineSmall),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: IrrigationList(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text('Clima agora',
                  style: Theme.of(context).textTheme.headlineSmall),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: WeatherCard(
                title: 'Ensolarado',
                rainPct: '15',
                location: 'Natal, RN',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
