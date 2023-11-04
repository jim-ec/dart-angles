library angles;

import 'dart:math' as math;

import 'package:meta/meta.dart';

/// Represents an angle.
/// The unit used for construction does not matter, as angles internally
/// always use radians.
/// The class is designed to be immutable but provides operators like adding
/// or subtracting, which all create new angles instead of mutating existing
/// ones.
@immutable
class Angle implements Comparable<Angle> {
  final double _storage;

  /// Create a zero angle.
  const Angle.zero() : _storage = 0.0;

  /// Create an angle defined by degrees.
  /// One full turn equals 360 degrees.
  const Angle.degrees(final double degrees)
      : _storage = degrees / 180.0 * math.pi;

  @Deprecated("Use Angle.degrees instead")
  const Angle.fromDegrees(final double degrees)
      : _storage = degrees / 180.0 * math.pi;

  /// Create an angle from radians.
  /// One full turn equals 2pi radians.
  const Angle.radians(final double radians) : _storage = radians;

  @Deprecated("Use Angle.radians instead")
  const Angle.fromRadians(final double radians) : _storage = radians;

  /// Create an angle defined by gradians.
  /// One full turn equals 400 gradians.
  const Angle.gradians(final double gradians)
      : _storage = gradians / 200.0 * math.pi;

  @Deprecated("Use Angle.gradians instead")
  const Angle.fromGradians(final double gradians)
      : _storage = gradians / 200.0 * math.pi;

  /// Create an angle defined by turns.
  /// One full turn equals 1 turn.
  const Angle.turns(final double turns) : _storage = turns * 2.0 * math.pi;

  @Deprecated("Use Angle.turns instead")
  const Angle.fromTurns(final double turns) : _storage = turns * 2.0 * math.pi;

  /// Create an angle defining one full turn.
  factory Angle.fullTurn() => Angle.turns(1.0);

  /// Create an angle defining one half turn.
  factory Angle.halfTurn() => Angle.turns(0.5);

  /// Create an angle defining one quarter turn.
  factory Angle.quarterTurn() => Angle.turns(0.25);

  /// Create an angle defining one third turn.
  factory Angle.thirdTurn() => Angle.turns(1.0 / 3.0);

  /// Create an angle defining one eighth turn.
  factory Angle.eighthTurn() => Angle.turns(0.125);

  /// Parse [string] to angle.
  factory Angle.parse(String string) {
    final regexGradians = RegExp(r"(grad(ians?)?|ᵍ)");
    final regexRadians = RegExp(r"(rad(ians?)?|㎭)");
    final regexPi = RegExp(r"π|(pi)");
    final regexDegrees = RegExp(
        "(°|deg(rees?)?|h(ours?)?)|(′|'|m(in(utes?)?)?)|(″|\"|s|s?ec(onds?)?)");
    // Remove spaces
    string = string.replaceAll(" ", "");
    if (string.contains(regexGradians)) {
      // Gradians
      string = string.replaceAll(regexGradians, "");
      return Angle.gradians(double.parse(string == "" ? "0" : string));
    } else if (string.contains(regexRadians) || string.contains(regexPi)) {
      // Radians
      bool pi = false;
      string = string.replaceAll(regexRadians, "");
      if (string.contains(regexPi)) {
        string = string.replaceAll(regexPi, "");
        pi = true;
        if (string == "") {
          string = "1";
        }
      }
      return Angle.radians(
          double.parse(string == "" ? "0" : string) * (pi ? math.pi : 1));
    } else if (string.contains(regexDegrees)) {
      // Degrees
      final splits = string.split(regexDegrees);
      double value = 0;
      for (int i = 0; i < splits.length; i++) {
        value +=
            double.parse(splits[i] == "" ? "0" : splits[i]) / math.pow(60, i);
      }
      return Angle.degrees(value);
    }
    // Otherwise
    return Angle.radians(double.parse(string == "" ? "0" : string));
  }

  /// Create an angle by computing the arc sine of [c].
  Angle.asin(final double c) : _storage = math.asin(c);

  /// Create an angle by computing the arc cosine of [c].
  Angle.acos(final double c) : _storage = math.acos(c);

  /// Create an angle by computing the arc tangent of [c].
  Angle.atan(final double c) : _storage = math.atan(c);

  /// Create an angle by computing the arc tangent from `y / x`.
  /// This uses the `atan2()` function, therefore there are two
  /// separate parameters for the nominator and the denominator.
  /// The result is an angle in `]-180°;180°]`.
  /// Sample values:
  ///  - `y=0, x=0` => 0°
  ///  - `y=0, x=1` => 0°
  ///  - `y=1, x=0` => 90°
  ///  - `y=0, x=-1` => 180°
  ///  - `y=-1, x=0` => -90°
  Angle.atan2(final double y, final double x) : _storage = math.atan2(y, x);

  /// Works in the same manner as [Angle.atan2], but results
  /// in an angle in `[0°, 360°)`.
  /// Sample values:
  ///  - `y=0, x=0` => 0°
  ///  - `y=0, x=1` => 0°
  ///  - `y=1, x=0` => 90°
  ///  - `y=0, x=-1` => 180°
  ///  - `y=-1, x=0` => 270°
  factory Angle.atanFullTurn(final double y, final double x) {
    if (y >= 0) {
      return Angle.atan2(y, x);
    } else {
      return Angle.atan2(-y, -x) + Angle.halfTurn();
    }
  }

  /// Returns an angle in `[0°, 360°)`, pointing to the cartesian coordinate.
  /// The `x` axis has angle `0°`, the `y` axis has angle `90°`.
  factory Angle.cartesian(final double x, final double y) {
    return Angle.atanFullTurn(y, x);
  }

  /// Get the angle in turns.
  double get turns => (_storage) / math.pi / 2.0;

  /// Get the angle in degrees.
  double get degrees => (_storage / math.pi) * 180.0;

  /// Get the angle in radians.
  double get radians => _storage;

  /// Get the angle in gradians.
  double get gradians => (_storage / math.pi) * 200.0;

  /// Compute the sine of this angle.
  double get sin => math.sin(radians);

  /// Compute the cosine of this angle.
  double get cos => math.cos(radians);

  /// Compute the tangent of this angle.
  double get tan => math.tan(radians);

  /// Accumulate this and [other], returning a new angle.
  Angle operator +(final Angle other) => Angle.radians(radians + other.radians);

  /// Compute the difference of this to [other], returning a new angle.
  Angle operator -(final Angle other) => Angle.radians(radians - other.radians);

  /// Negate this angle, returning a new angle.
  Angle operator -() => Angle.radians(-radians);

  /// Scale this angle, returning a new angle.
  Angle operator *(final double scale) => Angle.radians(radians * scale);

  /// Inverse scale this angle, returning a new angle.
  Angle operator /(final double scale) => Angle.radians(radians / scale);

  /// Returns the ratio between two angles.
  double ratio(final Angle other) => radians / other.radians;

  /// Return a string representation of this angle, optimized to be readable.
  /// The angle is printed in degrees, and only one decimal digit is included.
  @override
  String toString() => "${degrees.toStringAsFixed(1)}°";

  /// Returns an angle with the some direction, but confined to
  /// the interval `[0°, 360°)`.
  Angle get normalized {
    if (_storage == 0) {
      return Angle.zero();
    } else if (_storage > 0) {
      return Angle.turns(turns.remainder(1.0));
    } else {
      return Angle.fullTurn() + Angle.turns(turns.remainder(1.0));
    }
  }

  // Compare to another angle. Returns:
  // - `0`: Both angles are equal.
  // - `1`: This angle is greater.
  // - `-1`: This angle is smaller.
  @override
  int compareTo(Angle other) {
    if (this == other) {
      return 0;
    } else if (this > other) {
      return 1;
    } else {
      return -1;
    }
  }

  @override
  int get hashCode => _storage.hashCode;

  /// Compares this to [other].
  bool operator <(final Angle other) => _storage < other._storage;

  /// Compares this to [other].
  bool operator >(final Angle other) => _storage > other._storage;

  /// Compares this to [other].
  bool operator <=(final Angle other) => _storage <= other._storage;

  /// Compares this to [other].
  bool operator >=(final Angle other) => _storage >= other._storage;

  /// Compares to another angle.
  /// Since IEEE 754 floating points are approximations to real numbers, they cannot
  /// be really tested for equality.
  @override
  bool operator ==(covariant final Angle rhs) => _storage == rhs._storage;

  /// Checks if [rhs] is approximately this angle, +/- [range].
  /// [range] must be non-negative.
  bool approximately(final Angle rhs, final double range) {
    assert(range >= 0);
    return rhs._storage >= _storage - range && rhs._storage <= _storage + range;
  }
}
