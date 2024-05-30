import 'package:flutter/material.dart';

class DecrementIndicatorWidget extends StatelessWidget {
  const DecrementIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red.withOpacity(0.25),
      ),
      child: const Icon(
        Icons.arrow_downward_rounded,
        color: Colors.red,
        size: 20,
      ),
    );
  }
}
