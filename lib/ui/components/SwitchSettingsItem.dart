import 'package:flutter/material.dart';

class SwitchSettingsItem extends StatefulWidget {
  final String title;
  final Function(bool) onChanged;
  final bool isEnabled;
  const SwitchSettingsItem(
      {required this.title,
      required this.onChanged,
      required this.isEnabled,
      super.key});

  @override
  _SwitchSettingsItemState createState() => _SwitchSettingsItemState();
}

class _SwitchSettingsItemState extends State<SwitchSettingsItem> {
  bool _isSwitched = true;
  void _toggleSwitch(bool value) {
    setState(() {
      _isSwitched = value;
    });
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
                widget.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Expanded(
                child: Container(
                    alignment: Alignment.centerRight,
                    child: Switch(
                      value: _isSwitched,
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
