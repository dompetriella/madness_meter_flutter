import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:madness_meter_flutter/components/spell_button.dart';
import 'package:madness_meter_flutter/components/statsInput.dart';
import 'colors.dart';
import 'package:madness_meter_flutter/providers.dart';

import 'components/meter.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: ref.watch(currentMeterPercentage) == 0
            ? Colors.black
            : percentageToHsl(ref.watch(currentMeterPercentage), 250, 0, .05),
        body: MediaQuery.of(context).size.height < 750
            ? ListView(
                children: [Body()],
              )
            : Body());
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                StatsInput(
                  text: "INT",
                ),
                StatsInput(
                  text: "WIS",
                )
              ],
            ),
            Meter(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SpellButton(
                  text: 'Thought',
                  maxIncrease: 2,
                ),
                SpellButton(
                  text: 'Scheme',
                  maxIncrease: 4,
                ),
                SpellButton(
                  text: 'Machination',
                  maxIncrease: 8,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
