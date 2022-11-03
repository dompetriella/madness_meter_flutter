import 'package:flutter/material.dart';

Color percentageToHsl(double percent, int hue0, int hue1, double lightness) {
  percent > 1 ? 1 : percent;
  double returnHue = ((percent * (hue1 - hue0)) + hue0);
  return HSLColor.fromAHSL(1, returnHue, 1, lightness).toColor();
}
