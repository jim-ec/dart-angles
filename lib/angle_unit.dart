part of 'package:angles/angles.dart';

/// Type of angle
///
/// Each type has `expressions` for matching strings. Also it is possible that
/// Creating [Angle] instances via the corresponding [Angle]'s [constructor].
/// The [radix] is a number for conversion to subunits such as minutes and
/// seconds, so `60` for [degrees] and `0` otherwise.
enum AngleUnit {
  // Gradians
  gradians([r"(grad(ians?)?|ᵍ)"], Angle.gradians, 0),
  // Radians
  radians([r"(rad(ians?)?|㎭)"], Angle.radians, 0),
  // Degrees
  degrees([r"(°|deg(rees?)?|h(ours?)?)", r"(′|'|m(in(utes?)?)?)", r'(″|"|s(ec(onds?)?)?)'], Angle.degrees, 60),
  // Unknown
  unknown([], Angle.radians, 0);

  /// List of expressions
  final List<String> expressions;

  /// Constructor of [Angle] class.
  final Angle Function(double) constructor;

  /// Radix number of type.
  final int radix;

  const AngleUnit(this.expressions, this.constructor, this.radix);

  /// [RegExp] pattern to match strings
  RegExp get pattern => RegExp(this.expressions.join("|"));

}