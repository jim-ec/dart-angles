# Dart Angles

[Official Dart package](https://pub.dartlang.org/packages/angles)

**Never ever suffix your angle variables** with `...degress` or `...rad` and **forget about manual angle** conversions like `x * rad2deg`!

This library provides a single class named `Angle`, wrapping your angle variables in a far more readable way, whereas raw doubles aren't very expressive about how they store their values. One can create an angle from various units, including degrees, radians, gradians and turns.

```dart

// Various ways to define a half turn:
x = Angle.fromDegrees(180.0);
y = Angle.fromRadians(math.pi);
z = Angle.fromTurns(0.5);

x.degrees; // = 180.0
x.radians; // = 3.1415...
x.turns;   // = 0.5

```

One can use built-in trigonometric functions:

```dart

x = Angle.asin(0.3);
y = x.sin; // = 0.3

```

Angles are immutable, but there are operators like `+`, creating new angles:

```dart

x = Angle.halfTurn() + Angle.fromDegrees(90.0);

```
