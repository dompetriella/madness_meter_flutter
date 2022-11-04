import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madness_meter_flutter/providers.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../colors.dart';

class Meter extends ConsumerWidget {
  Meter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = 480;

    return Container(
      height: 550,
      width: 350,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: ModifierButton(
                increase: false,
              ),
            ).animate().fadeIn(delay: 4000.ms, duration: 1000.milliseconds),
            Column(
              children: [
                Text(
                  (ref.watch(currentMeterPercentage) > 1)
                      ? "MADNESS"
                      : "${ref.watch(currentMeter)}/${ref.watch(totalMeter)}",
                  style: TextStyle(fontSize: 32, color: Colors.white),
                )
                    .animate()
                    .fadeIn(delay: 4500.ms)
                    .scale(begin: Offset(2, 2), duration: 500.milliseconds),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // meter container
                    Container(
                      height: height,
                      width: 80,
                      color: Colors.blue.shade200,
                    ).animate().scaleY(duration: 2000.ms, delay: 2000.ms),
                    // meter fill
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 800),
                          curve: Curves.easeIn,
                          height: ref.watch(currentMeterPercentage) > 1
                              ? height
                              : height * ref.watch(currentMeterPercentage),
                          color: percentageToHsl(
                              ref.watch(currentMeterPercentage), 250, 0, .35),
                        ),
                      ),
                    ),
                    // skull eye base
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 700),
                        curve: Curves.easeIn,
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: percentageToHsl(
                                ref.watch(currentMeterPercentage), 250, 0, .30),
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                color: percentageToHsl(
                                    ref.watch(currentMeterPercentage),
                                    250,
                                    0,
                                    .35),
                                spreadRadius: ref
                                            .watch(currentMeterPercentage) <=
                                        1
                                    ? (12 +
                                        (55 *
                                            ref.watch(currentMeterPercentage)))
                                    : 67,
                                blurRadius: ref.watch(currentMeterPercentage) <=
                                        1
                                    ? (12 +
                                        (55 *
                                            ref.watch(currentMeterPercentage)))
                                    : 67,
                              )
                            ]),
                      )
                          .animate()
                          .fadeIn()
                          .scale(begin: Offset(2, 2), duration: 1.seconds)
                          .move(
                              begin: Offset(0, -200),
                              duration: 2000.ms,
                              delay: 2.seconds),
                    ),
                    // skull base
                    Positioned(
                      bottom: -20,
                      left: -24,
                      right: -25,
                      child: GestureDetector(
                        onTap: () => ref.watch(currentMeter.notifier).state = 0,
                        child: FaIcon(FontAwesomeIcons.skull,
                                size: 128,
                                color: Color.lerp(Colors.black, Colors.white,
                                    ref.watch(currentMeterPercentage)))
                            .animate()
                            .fadeIn()
                            .shimmer(duration: 1500.ms)
                            .scale(begin: Offset(2, 2), duration: 1.seconds)
                            .move(
                                begin: Offset(0, -200),
                                duration: 2000.ms,
                                delay: 2.seconds),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // increase button
            const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: ModifierButton())
                .animate()
                .untint(delay: 4000.ms, duration: 1000.milliseconds)
          ],
        ),
      ),
    );
  }
}

class ModifierButton extends ConsumerWidget {
  final bool increase;
  const ModifierButton({Key? key, this.increase = true}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialButton(
      color: Colors.lightBlue,
      minWidth: 60,
      height: 40,
      enableFeedback: false,
      child: Icon(
        increase ? Icons.add : Icons.remove,
        color: Colors.white,
      ),
      onPressed: () {
        if (increase) {
          ref.watch(currentMeter.notifier).state++;
          print(ref.watch(currentMeter));
        } else {
          if (ref.watch(currentMeter) > 0) {
            ref.watch(currentMeter.notifier).state--;
          }
        }
      },
    );
  }
}
