import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:madness_meter_flutter/providers.dart';

class Meter extends ConsumerWidget {
  const Meter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double height = 480;

    return Container(
      height: 550,
      width: 350,
      color: Colors.black,
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
                // if (ref.watch(intScore) == 'none' ||
                //     ref.watch(wisScore) == 'none')
                Text(
                  "${ref.watch(currentMeter)}/${ref.watch(totalMeter)}",
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
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.blue.shade900,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.lightBlue,
                                  spreadRadius: 12,
                                  blurRadius: 12)
                            ]),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 600),
                        curve: Curves.bounceInOut,
                        height: ref.watch(currentMeterPercentage) > 1
                            ? height
                            : height * ref.watch(currentMeterPercentage),
                        color: Colors.yellow,
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      left: -24,
                      right: -25,
                      child: GestureDetector(
                        onTap: () => ref.watch(currentMeter.notifier).state = 0,
                        child: FaIcon(
                          FontAwesomeIcons.skull,
                          size: 128,
                          color: Colors.black,
                        ),
                      ),
                    )
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
