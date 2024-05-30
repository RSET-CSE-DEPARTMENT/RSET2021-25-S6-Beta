import 'package:flutter/material.dart';

class IncrementIndicatorWidget extends StatelessWidget {
  const IncrementIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.green.withOpacity(0.25),
      ),
      child: const Icon(
        Icons.arrow_upward_rounded,
        color: Colors.green,
        size: 20,
      ),
    );
  }
}
