import 'package:flutter/material.dart';

class SpellButton extends StatelessWidget {
  const SpellButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 120,
      decoration: BoxDecoration(
          color: Colors.blue.shade900,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue.shade200, width: 10)),
    );
  }
}
