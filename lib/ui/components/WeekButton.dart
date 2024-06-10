import 'package:flutter/material.dart';

class WeekButton extends StatefulWidget {
  final String day;
  final Function(String, bool) onPressWeek;
  final bool isRoundedLeft;
  final bool isRoundedRight;
  const WeekButton(
      {required this.day,
      required this.onPressWeek,
      required this.isRoundedLeft,
      required this.isRoundedRight,
      super.key});

  @override
  State<WeekButton> createState() => _WeekButtonState();
}

class _WeekButtonState extends State<WeekButton> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPressWeek(widget.day, isActive),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(),
          color: isActive ? Colors.green : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft:
                widget.isRoundedLeft ? const Radius.circular(20) : Radius.zero,
            bottomLeft:
                widget.isRoundedLeft ? const Radius.circular(20) : Radius.zero,
            topRight:
                widget.isRoundedRight ? const Radius.circular(20) : Radius.zero,
            bottomRight:
                widget.isRoundedRight ? const Radius.circular(20) : Radius.zero,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.day,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
