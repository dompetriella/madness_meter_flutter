import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:madness_meter_flutter/components/spell_button.dart';
import 'package:madness_meter_flutter/components/statsInput.dart';
import 'global_functions.dart';
import 'package:madness_meter_flutter/providers.dart';
import 'components/meter.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: ref.watch(currentMeterPercentage) == 0
            ? Colors.black
            : percentageToHsl(ref.watch(currentMeterPercentage), 250, 0, .05),
        body: Body());
  }
}

class Body extends ConsumerWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      height: height,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            if (ref.watch(inMotion)) Blobs(),
            Column(
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
                if (ref.watch(inMotion))
                  Meter(
                    inheritedHeight: height * .65,
                  ),
                if (ref.watch(inMotion))
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SpellButton(
                        text: 'Thought',
                        maxIncrease: 2,
                      )
                          .animate()
                          .blur(begin: Offset(2, 2), duration: 2.seconds),
                      SpellButton(
                        text: 'Scheme',
                        maxIncrease: 4,
                      )
                          .animate()
                          .blur(begin: Offset(8, 8), duration: 2.seconds),
                      SpellButton(
                        text: 'Machination',
                        maxIncrease: 8,
                      )
                          .animate()
                          .blur(begin: Offset(14, 14), duration: 2.seconds)
                    ].animate(interval: 500.ms, effects: [
                      FadeEffect(delay: 200.ms),
                      MoveEffect(begin: Offset(0, 50))
                    ]),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Blobs extends ConsumerWidget {
  const Blobs({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          top: -1000 +
              (ref.watch(currentMeterPercentage) > 1.5
                  ? 400 * 1.5
                  : 400 * ref.watch(currentMeterPercentage)),
          left: -250,
          child: Builder(builder: (context) {
            return Blob.animatedRandom(
              styles: BlobStyles(
                color: ref.watch(currentMeterPercentage) == 0
                    ? Colors.black
                    : percentageToHsl(
                        ref.watch(currentMeterPercentage), 250, 0, .20),
              ),
              size: 1000,
              edgesCount: 15,
              minGrowth: 6,
              duration: Duration(milliseconds: 3000),
              loop: true,
            ).animate().fadeIn();
          }),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          top: -400 +
              (ref.watch(currentMeterPercentage) > 1.5
                  ? 150 * 1.5
                  : 150 * ref.watch(currentMeterPercentage)),
          left: 0,
          child: Blob.animatedRandom(
            styles: BlobStyles(
              color: ref.watch(currentMeterPercentage) == 0
                  ? Colors.black
                  : percentageToHsl(
                      ref.watch(currentMeterPercentage), 250, 0, .40),
            ),
            size: 350,
            edgesCount: 15,
            minGrowth: 6,
            duration: Duration(milliseconds: 2000),
            loop: true,
          ),
        ),
      ],
    );
  }
}
