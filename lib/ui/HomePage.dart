import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:regapp/ui/components/PlantCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: <Color>[Color(0xFFF7FBF2), Color(0xFFD7DBD3)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bom dia, ' 'User',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: GestureDetector(
              onTap: () => context.go('/plants'),
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
            child: ListView(
              shrinkWrap: true,
              children: const [
                PlantCard(title: 'Samambaia'),
                SizedBox(height: 8),
                PlantCard(title: 'Orquídea'),
                SizedBox(height: 8),
                PlantCard(title: 'Bromélia'),
                SizedBox(height: 8),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32),
            child: Text('Clima agora',
                style: Theme.of(context).textTheme.headlineSmall),
          )
        ],
      ),
    );
  }
}
