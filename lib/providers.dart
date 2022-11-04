import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter/material.dart';
import 'global_functions.dart';

int getModifier(String baseMod) {
  if (baseMod == '') return 0;
  int mod = int.parse(baseMod);
  if (mod < 12) return 1;
  if (mod < 14) return 2;
  if (mod < 16) return 3;
  if (mod < 18) return 4;
  if (mod < 22) return 5;
  if (mod < 24) return 6;
  if (mod < 26) return 7;
  if (mod < 28) return 8;
  if (mod < 30) return 9;
  if (mod < 32) return 10;
  return 0;
}

final intScore = StateProvider<String>(
  (ref) => '20',
);

final wisScore = StateProvider<String>(
  (ref) => '20',
);

final totalMeter = StateProvider<int>((ref) =>
    5 + getModifier(ref.watch(intScore)) + getModifier((ref.watch(wisScore))));

final currentMeter = StateProvider<int>(
  (ref) => 0,
);

final currentMeterPercentage = StateProvider<double>(
    (ref) => (ref.watch(currentMeter) / ref.watch(totalMeter)));

final inMotion = StateProvider<bool>(
    (ref) => ref.watch(intScore) != '' && ref.watch(wisScore) != '');
