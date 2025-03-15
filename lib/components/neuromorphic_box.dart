import 'package:flutter/material.dart';

class NeuromorphicBox extends StatelessWidget {
  final Widget? child;

  const NeuromorphicBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          // Dark shadow on bottom-right
          BoxShadow(
            color: Colors.grey.shade500,
            offset: const Offset(4.0, 4.0),
            blurRadius: 15,
          ),
          // Light shadow on top-left
          BoxShadow(
            color: Colors.white,
            offset: const Offset(-4.0, -4.0),
            blurRadius: 15,
          ),
        ],
      ),
      padding: EdgeInsets.all(12.0),
      child: child,
    );
  }
}
