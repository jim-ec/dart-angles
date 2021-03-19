import 'package:angles/angles.dart';
import 'dart:math' as math;

main() {
  // Various ways to define a half turn:
  final x = Angle.degrees(180.0);
  final y = Angle.radians(math.pi);
  final z = Angle.turns(0.5);

  print(x.degrees); // = 180.0
  print(x.radians); // = 3.1415...
  print(x.turns); // = 0.5

  // One can use built-in trigonometric functions:
  final a = Angle.asin(0.3);
  print(a.sin); // = 0.3

  // Angles are immutable, but there are operators like +, creating new angles:
  final threeQuarterTurn = Angle.halfTurn() + Angle.degrees(90.0);
  print(threeQuarterTurn); // 270°
}
