/*library angles;

import 'package:angles/angles.dart';

/// Represent angle by given format
///
///
///
/// The following characters are available:
/// ```
/// Symbol Meaning
/// ------ -------------------------
/// r      radians
/// d      degrees
/// m      minutes
/// s      seconds
/// D      degrees (decimal digits)
/// g      gradians
/// t      turns
/// '      escape letter
/// ```
class AngleFormat {

  final String format;

  AngleFormat(this.format);

  String format(Angle angle, [String? format]) {
    format = format ?? this.format;

  }

}

enum AngleFormatFields {
  r("r"),
  d("d"),
  m("m"),
  s("s"),
  D("D"),
  g("g"),
  t("t");

  final String char;

  const AngleFormatFields(this.char);

  RegExp get pattern => RegExp("[^']$char+");

}*/