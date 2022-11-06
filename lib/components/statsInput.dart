import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:madness_meter_flutter/providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsInput extends ConsumerWidget {
  final String text;
  StatsInput({super.key, required this.text});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 120,
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
                color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900),
          ),
          Container(
            height: 70,
            decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade200, width: 10)),
            child: Center(
              child: TextField(
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                cursorColor: Colors.white,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText:
                      text == 'INT' ? ref.watch(intScore) : ref.watch(wisScore),
                  hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold),
                ),
                onChanged: (input) async {
                  final prefs = await SharedPreferences.getInstance();
                  if (text == 'INT') {
                    ref.watch(intScore.notifier).state = input;
                    await prefs.setString('intScore', input);
                  }
                  if (text == 'WIS') {
                    ref.watch(wisScore.notifier).state = input;
                    await prefs.setString('wisScore', input);
                  }
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
