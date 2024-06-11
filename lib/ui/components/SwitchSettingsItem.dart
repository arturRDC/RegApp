import 'package:flutter/material.dart';

class SwitchSettingsItem extends StatelessWidget {
  final String title;
  final Function(bool) onChanged;
  final bool isEnabled;
  const SwitchSettingsItem(
      {required this.title,
      required this.onChanged,
      required this.isEnabled,
      super.key});

  void _toggleSwitch(bool value) {
    onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Expanded(
                child: Container(
                    alignment: Alignment.centerRight,
                    child: Switch(
                      value: isEnabled,
                      onChanged: _toggleSwitch,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
