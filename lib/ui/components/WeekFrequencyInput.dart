import 'package:flutter/material.dart';
import 'package:regapp/ui/components/WeekButton.dart';

class WeekFrequencyInput extends StatefulWidget {
  final Function(Set<String>) onFreqChange;
  final Set<String> defaultFreq;
  const WeekFrequencyInput(
      {required this.onFreqChange, required this.defaultFreq, super.key});

  @override
  State<WeekFrequencyInput> createState() => _WeekFrequencyInputState();
}

class _WeekFrequencyInputState extends State<WeekFrequencyInput> {
  Set<String> frequency = {};
  void _handleClickWeek(String week, bool isActive) {
    isActive ? frequency.add(week) : frequency.remove(week);
    widget.onFreqChange(frequency);
  }

  @override
  void initState() {
    super.initState();
    frequency = widget.defaultFreq;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          WeekButton(
            day: 'Seg',
            onPressWeek: _handleClickWeek,
            isRoundedLeft: true,
            isRoundedRight: false,
            isActive: frequency.contains('Seg'),
          ),
          WeekButton(
            day: 'Ter',
            onPressWeek: _handleClickWeek,
            isRoundedLeft: false,
            isRoundedRight: false,
            isActive: frequency.contains('Ter'),
          ),
          WeekButton(
            day: 'Qua',
            onPressWeek: _handleClickWeek,
            isRoundedLeft: false,
            isRoundedRight: false,
            isActive: frequency.contains('Qua'),
          ),
          WeekButton(
            day: 'Qui',
            onPressWeek: _handleClickWeek,
            isRoundedLeft: false,
            isRoundedRight: false,
            isActive: frequency.contains('Qui'),
          ),
          WeekButton(
            day: 'Sex',
            onPressWeek: _handleClickWeek,
            isRoundedLeft: false,
            isRoundedRight: false,
            isActive: frequency.contains('Sex'),
          ),
          WeekButton(
            day: 'Sab',
            onPressWeek: _handleClickWeek,
            isRoundedLeft: false,
            isRoundedRight: false,
            isActive: frequency.contains('Sab'),
          ),
          WeekButton(
            day: 'Dom',
            onPressWeek: _handleClickWeek,
            isRoundedLeft: false,
            isRoundedRight: true,
            isActive: frequency.contains('Dom'),
          ),
        ],
      ),
    );
  }
}
