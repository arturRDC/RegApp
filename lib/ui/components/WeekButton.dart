import 'package:flutter/material.dart';

class WeekButton extends StatefulWidget {
  final String day;
  final Function(String, bool) onPressWeek;
  final bool isRoundedLeft;
  final bool isRoundedRight;
  final bool isActive;
  const WeekButton(
      {required this.day,
      required this.onPressWeek,
      required this.isRoundedLeft,
      required this.isRoundedRight,
      required this.isActive,
      super.key});

  @override
  State<WeekButton> createState() => _WeekButtonState();
}

class _WeekButtonState extends State<WeekButton> {
  bool _isActive = false;

  @override
  void initState() {
    super.initState();
    _isActive = widget.isActive;
  }

  void _handleTapWeek() {
    widget.onPressWeek(widget.day, !_isActive);
    setState(() {
      _isActive = !_isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _handleTapWeek(),
        child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xff727970), width: 1),
            color: _isActive
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: widget.isRoundedLeft
                  ? const Radius.circular(20)
                  : Radius.zero,
              bottomLeft: widget.isRoundedLeft
                  ? const Radius.circular(20)
                  : Radius.zero,
              topRight: widget.isRoundedRight
                  ? const Radius.circular(20)
                  : Radius.zero,
              bottomRight: widget.isRoundedRight
                  ? const Radius.circular(20)
                  : Radius.zero,
            ),
          ),
          child: Text(
            widget.day,
            style: TextStyle(
              color: _isActive ? Colors.white : Colors.black,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
