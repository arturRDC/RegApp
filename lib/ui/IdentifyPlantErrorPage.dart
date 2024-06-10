import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IdentifyPlantErrorPage extends StatelessWidget {
  const IdentifyPlantErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Identificar Planta",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Image.asset('assets/images/identification_fail.png'),
              ),
              Text(
                'Erro ao identificar planta',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Tente novamente em outro ângulo',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle form submission
                      context.pop();
                    },
                    child: Text(
                      'Tentar novamente',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
