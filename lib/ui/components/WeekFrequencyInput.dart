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
    isActive ? frequency.add(week) : frequency.remove(week);
    widget.onFreqChange(frequency);
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
            isActive: false,
          ),
          WeekButton(
            day: 'Ter',
            onPressWeek: _handleClickWeek,
            isRoundedLeft: false,
            isRoundedRight: false,
            isActive: true,
          ),
          WeekButton(
            day: 'Qua',
            onPressWeek: _handleClickWeek,
            isRoundedLeft: false,
            isRoundedRight: false,
            isActive: false,
          ),
          WeekButton(
            day: 'Qui',
            onPressWeek: _handleClickWeek,
            isRoundedLeft: false,
            isRoundedRight: false,
            isActive: true,
          ),
          WeekButton(
            day: 'Sex',
            onPressWeek: _handleClickWeek,
            isRoundedLeft: false,
            isRoundedRight: false,
            isActive: false,
          ),
          WeekButton(
            day: 'Sab',
            onPressWeek: _handleClickWeek,
            isRoundedLeft: false,
            isRoundedRight: false,
            isActive: true,
          ),
          WeekButton(
            day: 'Dom',
            onPressWeek: _handleClickWeek,
            isRoundedLeft: false,
            isRoundedRight: true,
            isActive: false,
          ),
        ],
      ),
    );
  }
}
