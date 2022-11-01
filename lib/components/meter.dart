import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Meter extends StatelessWidget {
  const Meter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550,
      width: 350,
      color: Colors.black,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton(
                style: ButtonStyle(),
                onPressed: () => print("less"),
                child: Icon(Icons.remove),
              ),
            ),
            Column(
              children: [
                Text(
                  "15/20",
                  style: TextStyle(fontSize: 32, color: Colors.white),
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 480,
                      width: 80,
                      color: Colors.blue.shade200,
                      child: Center(
                        child: Container(
                          height: 400,
                          width: 60,
                          color: Colors.yellow,
                        ),
                      ),
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
                      bottom: -20,
                      left: -24,
                      right: -25,
                      child: FaIcon(
                        FontAwesomeIcons.skull,
                        size: 128,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ElevatedButton(
                  onPressed: () => print("more"), child: Icon(Icons.add)),
            )
          ],
        ),
      ),
    );
  }
}
