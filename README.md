# Dart Angles

[Official Dart package](https://pub.dartlang.org/packages/angles)

Say goodby to naming suffixes like `...deg` or `...rad`, manual angle conversions like `x * rad2deg` and the inevitable mess when mixing up multiple angle units in your code.

This library provides a single class named `Angle`, wrapping your angle variables in a far more readable way, whereas raw doubles aren't very expressive about how they store their values. One can create an angle from various units, including degrees, radians, gradians and turns.

```dart

// Various ways to define a half turn:
a0 = Angle.fromDegrees(180.0);
a1 = Angle.fromRadians(math.pi);
a2 = Angle.fromTurns(0.5);

a0.degrees; // = 180.0
a1.radians; // = 3.1415...
a2.turns;   // = 0.5

```

Trigonometric functions are defined on instances:

```dart

x = Angle.asin(0.3);
y = x.sin; // = 0.3

```

Angles are immutable by design, but there are operators like `+`, creating new angles:

```dart

// 270°:
x = Angle.halfTurn() + Angle.fromDegrees(90.0);

```
