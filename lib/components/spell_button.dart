import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import 'package:madness_meter_flutter/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpellButton extends ConsumerWidget {
  final String text;
  final int maxIncrease;
  const SpellButton({super.key, required this.text, required this.maxIncrease});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int getRandomNumber(int maxIncrease) {
      Random random = new Random();
      int value = random.nextInt(maxIncrease) + 1;
      return value;
    }

    return Bounce(
      duration: Duration(milliseconds: 100),
      onPressed: () async {
        final prefs = await SharedPreferences.getInstance();
        ref.read(currentMeter.notifier).state += getRandomNumber(maxIncrease);
        await prefs.setInt('currentMeter', ref.read(currentMeter));
        ref.watch(madnessRoll.notifier).state = getRandomNumber(4);
      },
      child: Container(
        height: 60,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Colors.lightBlue,
                  offset: Offset(0, 2),
                  spreadRadius: 1)
            ]),
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        )),
      ),
    );
  }
}
