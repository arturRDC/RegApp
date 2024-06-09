import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:regapp/ui/components/PlantList.dart';

class PlantsPage extends StatefulWidget {
  const PlantsPage({super.key});

  @override
  State<PlantsPage> createState() => _PlantsPageState();
}

class _PlantsPageState extends State<PlantsPage> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: PlantList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.push('/plants/addPlant'),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                      child: Icon(Icons.add),
                    ),
                    Text(
                      'Adicionar planta',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
