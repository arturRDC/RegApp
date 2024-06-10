import 'package:flutter/material.dart';
import 'package:regapp/ui/components/WeekButton.dart';

class WeekFrequencyInput extends StatefulWidget {
  final Function(Set<String>) onFreqChange;
  const WeekFrequencyInput({required this.onFreqChange, super.key});

  @override
  State<WeekFrequencyInput> createState() => _WeekFrequencyInputState();
}

class _WeekFrequencyInputState extends State<WeekFrequencyInput> {
  Set<String> frequency = {};
  void _handleClickWeek(String week, bool isActive) {
    isActive ? frequency.remove(week) : frequency.add(week);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        WeekButton(
          day: 'Seg',
          onPressWeek: _handleClickWeek,
          isRoundedLeft: true,
          isRoundedRight: false,
        ),
        WeekButton(
          day: 'Ter',
          onPressWeek: _handleClickWeek,
          isRoundedLeft: false,
          isRoundedRight: false,
        ),
        WeekButton(
          day: 'Qua',
          onPressWeek: _handleClickWeek,
          isRoundedLeft: false,
          isRoundedRight: false,
        ),
        WeekButton(
          day: 'Qui',
          onPressWeek: _handleClickWeek,
          isRoundedLeft: false,
          isRoundedRight: false,
        ),
        WeekButton(
          day: 'Sex',
          onPressWeek: _handleClickWeek,
          isRoundedLeft: false,
          isRoundedRight: false,
        ),
        WeekButton(
          day: 'Sab',
          onPressWeek: _handleClickWeek,
          isRoundedLeft: false,
          isRoundedRight: false,
        ),
        WeekButton(
          day: 'Dom',
          onPressWeek: _handleClickWeek,
          isRoundedLeft: false,
          isRoundedRight: true,
        ),
      ],
    );
  }
}
