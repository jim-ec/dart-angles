# Dart Angles

[Official Dart package](https://pub.dartlang.org/packages/angles)

This package provides an `Angle` type seeking to eliminate the use of variable suffixes like `...deg` or `...rad`
as well as manual angle unit conversions like `x * rad2deg` and the likes.

Therefore, this package's *raison d'être* is not to serve features but to increase code maintainability,
thus reducing maintaince cost and bugs.

Angles can be constructed from these units: degrees, radians, gradians and turns.

| Unit | Quantity of a full turn |
|--|--|
| Degree | 360° |
| Radian | 2π |
| Gradian | 400ᵍ |
| Turn | 1 |


## Sample code


```dart
// Various ways to define a half turn:
a0 = Angle.degrees(180.0);
a1 = Angle.radians(math.pi);
a2 = Angle.turns(0.5);

a0.degrees; // = 180.0
a1.radians; // = 3.1415...
a2.turns;   // = 0.5
```


## Documentation


Constructors:
- `Angle.degrees(x)`
- `Angle.radians(x)`
- `Angle.gradians(x)`
- `Angle.turns(x)`

Accessors:
- `.degrees()`
- `.radians()`
- `.gradians()`
- `.turns()`

Trigonometric functions:
- `.sin()`
- `.cos()`
- `.tan()`
- `Angle.asin(x)`
- `Angle.acos(x)`
- `Angle.atan(x)`
- `Angle.atan2(y, x)`
- `Angle.atanFullTurn(y, x)`

Utility functions:
- `.toString()`
- `.approximately(other, range)`
- `.ratio(other)`

All arithmetic and relational operators are defined on angles as well.
