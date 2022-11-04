import 'package:flutter/material.dart';
import 'dart:math';

Color percentageToHsl(double percent, int hue0, int hue1, double lightness) {
  var percentFilled = percent;
  if (percent >= 1) {
    percentFilled = 1;
  }
  double returnHue = ((percentFilled * (hue1 - hue0)) + hue0);
  return HSLColor.fromAHSL(1, returnHue, 1, lightness).toColor();
}

int getRandomNumber(int maxIncrease) {
  Random random = new Random();
  int value = random.nextInt(maxIncrease) + 1;
  return value;
}
