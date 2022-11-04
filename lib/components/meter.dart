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
            ),
            Column(
              children: [
                Text(
                  (ref.watch(currentMeterPercentage) > 1)
                      ? "MADNESS"
                      : "${ref.watch(currentMeter)}/${ref.watch(totalMeter)}",
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: height,
                      width: 80,
                      color: Colors.blue.shade200,
                    ),
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
                      ),
                    ),
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
                            .animate(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Padding(
                padding: EdgeInsets.only(bottom: 8.0), child: ModifierButton())
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
