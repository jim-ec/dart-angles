import 'dart:math' as math;
import 'package:test/test.dart';

import 'package:angles/angles.dart';

void main() {
  group("Arithmetical operations", () {
    test("Zero angle", () {
      expect(Angle.zero() + Angle.turns(1), Angle.turns(1));
      expect(Angle.turns(1) * 0, Angle.zero());
    });

    test("Multiplication", () {
      expect(Angle.turns(1) * 1, Angle.turns(1));
      expect(Angle.turns(1) * 2, Angle.turns(2));
      expect(-Angle.turns(2), Angle.turns(-2));
    });

    test("Division", () {
      expect(Angle.turns(5) / 1, Angle.turns(5));
      expect(Angle.turns(6) / 3, Angle.turns(2));
    });

    test("Ratio", () {
      expect(Angle.turns(3).ratio(Angle.turns(3)), 1);
      expect(Angle.turns(6).ratio(Angle.turns(3)), 2);
    });

    test("Addition", () {
      expect(Angle.turns(2) + Angle.turns(3), Angle.turns(5));
      expect(Angle.turns(2) - Angle.turns(3), Angle.turns(-1));
    });
  });
  group("Relational operators", () {
    test("Inequality", () {
      expect(Angle.turns(1).compareTo(Angle.turns(2)), -1);
      expect(Angle.turns(2).compareTo(Angle.turns(1)), 1);
      expect(Angle.turns(1) != Angle.turns(2), true);
      expect(Angle.turns(1) < Angle.turns(2), true);
      expect(Angle.turns(1) <= Angle.turns(2), true);
      expect(Angle.turns(2) > Angle.turns(1), true);
      expect(Angle.turns(2) >= Angle.turns(1), true);
    });
    test("Equality", () {
      expect(Angle.turns(2).compareTo(Angle.turns(2)), 0);
      expect(Angle.turns(2) <= Angle.turns(2), true);
      expect(Angle.turns(2) >= Angle.turns(2), true);
      expect(Angle.turns(2) == Angle.turns(2), true);
    });
  });
  group("Units", () {
    test("Turns", () {
      expect(Angle.turns(0), Angle.zero());
      expect(Angle.turns(0.5), Angle.halfTurn());
      expect(Angle.turns(0.25), Angle.quarterTurn());
      expect(Angle.turns(0.125), Angle.eighthTurn());
      expect(Angle.turns(1), Angle.fullTurn());
      expect(Angle.turns(1 / 3), Angle.thirdTurn());
    });
    test("Degrees", () {
      expect(Angle.degrees(0), Angle.zero());
      expect(Angle.degrees(90), Angle.quarterTurn());
      expect(Angle.degrees(360), Angle.fullTurn());
    });
    test("Gradians", () {
      expect(Angle.gradians(0), Angle.zero());
      expect(Angle.gradians(100), Angle.quarterTurn());
      expect(Angle.gradians(400), Angle.fullTurn());
    });
  });
  group("Utility functions", () {
    test("Stringification", () {
      expect(Angle.degrees(45).toString(), "45.0°");
    });
    test("Apprixmate equality", () {
      final Angle x = Angle.degrees(45);
      expect(x.approximately(Angle.degrees(45.01), 0.1), true);
      expect(x.approximately(Angle.degrees(44.99), 0.1), true);
      expect(x.approximately(Angle.degrees(45.1), 0.1), true);
      expect(x.approximately(Angle.degrees(44.9), 0.1), true);

      expect(x.approximately(Angle.degrees(45.1), 0.01), true);
      expect(x.approximately(Angle.degrees(44.9), 0.01), true);
    });
    test("Normalization", () {
      expect(Angle.turns(0.0).normalized, Angle.turns(0.0));
      expect(Angle.turns(-0.0).normalized, Angle.turns(0.0));
      expect(Angle.turns(1.0).normalized, Angle.turns(0.0));

      expect(Angle.turns(0.3).normalized, Angle.turns(0.3));
      expect(Angle.turns(2.5).normalized, Angle.turns(0.5));

      expect(Angle.turns(-0.25).normalized, Angle.turns(0.75));
      expect(Angle.turns(-2.25).normalized, Angle.turns(0.75));
    });
  });
  group("Trigonometric functions", () {
    test("Sinusoidals", () {
      final Angle x = Angle.degrees(45);
      final double epsilon = 1e-9;
      expect(Angle.asin(x.sin).approximately(x, epsilon), true);
      expect(Angle.acos(x.cos).approximately(x, epsilon), true);
      expect(Angle.atan(x.tan).approximately(x, epsilon), true);

      expect(Angle.atan2(0, 0), Angle.degrees(0));
      expect(Angle.atan2(0, 1), Angle.degrees(0));
      expect(Angle.atan2(1, 1), Angle.degrees(45));
      expect(Angle.atan2(1, 0), Angle.degrees(90));
      expect(Angle.atan2(1, -1), Angle.degrees(135));
      expect(Angle.atan2(0, -1), Angle.degrees(180));
      expect(Angle.atan2(-1, -1), Angle.degrees(-135));
      expect(Angle.atan2(-1, 0), Angle.degrees(-90));
      expect(Angle.atan2(-1, 1), Angle.degrees(-45));

      expect(Angle.atanFullTurn(0, 0), Angle.degrees(0));
      expect(Angle.atanFullTurn(0, 1), Angle.degrees(0));
      expect(Angle.atanFullTurn(1, 1), Angle.degrees(45));
      expect(Angle.atanFullTurn(1, 0), Angle.degrees(90));
      expect(Angle.atanFullTurn(1, -1), Angle.degrees(135));
      expect(Angle.atanFullTurn(0, -1), Angle.degrees(180));
      expect(Angle.atanFullTurn(-1, -1), Angle.degrees(225));
      expect(Angle.atanFullTurn(-1, 0), Angle.degrees(270));
      expect(Angle.atanFullTurn(-1, 1), Angle.degrees(315));

      expect(Angle.cartesian(0, 0), Angle.degrees(0));
      expect(Angle.cartesian(1, 0), Angle.degrees(0));
      expect(Angle.cartesian(1, 1), Angle.degrees(45));
      expect(Angle.cartesian(0, 1), Angle.degrees(90));
      expect(Angle.cartesian(-1, 1), Angle.degrees(135));
      expect(Angle.cartesian(-1, 0), Angle.degrees(180));
      expect(Angle.cartesian(-1, -1), Angle.degrees(225));
      expect(Angle.cartesian(0, -1), Angle.degrees(270));
      expect(Angle.cartesian(1, -1), Angle.degrees(315));
    });
  });
  group("Compatibility", () {
    test("Constructors", () {
      // ignore: deprecated_member_use_from_same_package
      expect(Angle.fromDegrees(45), Angle.degrees(45));
      // ignore: deprecated_member_use_from_same_package
      expect(Angle.fromGradians(45), Angle.gradians(45));
      // ignore: deprecated_member_use_from_same_package
      expect(Angle.fromRadians(45), Angle.radians(45));
      // ignore: deprecated_member_use_from_same_package
      expect(Angle.fromTurns(45), Angle.turns(45));
    });
  });
  group("Parse", () {
    test("Radians", () {
      expect(Angle.parse(""), Angle.radians(0));
      expect(Angle.parse("㎭"), Angle.radians(0));
      expect(Angle.parse("rad"), Angle.radians(0));
      expect(Angle.parse(" rad"), Angle.radians(0));
      expect(Angle.parse("radians"), Angle.radians(0));
      expect(Angle.parse(" radians"), Angle.radians(0));

      expect(Angle.parse("1"), Angle.radians(1));
      expect(Angle.parse("1㎭"), Angle.radians(1));
      expect(Angle.parse("1rad"), Angle.radians(1));
      expect(Angle.parse("1 rad"), Angle.radians(1));
      expect(Angle.parse("1radians"), Angle.radians(1));
      expect(Angle.parse("1 radians"), Angle.radians(1));

      expect(Angle.parse("pi"), Angle.radians(math.pi));
      expect(Angle.parse("pi㎭"), Angle.radians(math.pi));
      expect(Angle.parse("pirad"), Angle.radians(math.pi));
      expect(Angle.parse("pi rad"), Angle.radians(math.pi));
      expect(Angle.parse("piradians"), Angle.radians(math.pi));
      expect(Angle.parse("pi radians"), Angle.radians(math.pi));

      expect(Angle.parse("π"), Angle.radians(math.pi));
      expect(Angle.parse("π㎭"), Angle.radians(math.pi));
      expect(Angle.parse("πrad"), Angle.radians(math.pi));
      expect(Angle.parse("π rad"), Angle.radians(math.pi));
      expect(Angle.parse("πradians"), Angle.radians(math.pi));
      expect(Angle.parse("π radians"), Angle.radians(math.pi));

      expect(Angle.parse("3.5π"), Angle.radians(3.5 * math.pi));
      expect(Angle.parse("3.5π㎭"), Angle.radians(3.5 * math.pi));
      expect(Angle.parse("3.5πrad"), Angle.radians(3.5 * math.pi));
      expect(Angle.parse("3.5π rad"), Angle.radians(3.5 * math.pi));
      expect(Angle.parse("3.5πradians"), Angle.radians(3.5 * math.pi));
      expect(Angle.parse("3.5π radians"), Angle.radians(3.5 * math.pi));

      expect(Angle.parse("-2."), Angle.radians(-2));
      expect(Angle.parse("-2.㎭"), Angle.radians(-2));
      expect(Angle.parse("-2.rad"), Angle.radians(-2));
      expect(Angle.parse("-2. rad"), Angle.radians(-2));
      expect(Angle.parse("-2.radians"), Angle.radians(-2));
      expect(Angle.parse("-2. radians"), Angle.radians(-2));

      expect(Angle.parse("+8e+9"), Angle.radians(8e+9));
      expect(Angle.parse("+8e+9㎭"), Angle.radians(8e+9));
      expect(Angle.parse("+8e+9rad"), Angle.radians(8e+9));
      expect(Angle.parse("+8e+9 rad"), Angle.radians(8e+9));
      expect(Angle.parse("+8e+9radians"), Angle.radians(8e+9));
      expect(Angle.parse("+8e+9 radians"), Angle.radians(8e+9));

      expect(Angle.parse("2.5e-9"), Angle.radians(2.5e-9));
      expect(Angle.parse("2.5e-9㎭"), Angle.radians(2.5e-9));
      expect(Angle.parse("2.5e-9rad"), Angle.radians(2.5e-9));
      expect(Angle.parse("2.5e-9 rad"), Angle.radians(2.5e-9));
      expect(Angle.parse("2.5e-9radians"), Angle.radians(2.5e-9));
      expect(Angle.parse("2.5e-9 radians"), Angle.radians(2.5e-9));

      expect(Angle.parse("3.e-2"), Angle.radians(3e-2));
      expect(Angle.parse("3.e-2㎭"), Angle.radians(3e-2));
      expect(Angle.parse("3.e-2rad"), Angle.radians(3e-2));
      expect(Angle.parse("3.e-2 rad"), Angle.radians(3e-2));
      expect(Angle.parse("3.e-2radians"), Angle.radians(3e-2));
      expect(Angle.parse("3.e-2 radians"), Angle.radians(3e-2));

      expect(Angle.parse("-.12e-9"), Angle.radians(-.12e-9));
      expect(Angle.parse("-.12e-9㎭"), Angle.radians(-.12e-9));
      expect(Angle.parse("-.12e-9rad"), Angle.radians(-.12e-9));
      expect(Angle.parse("-.12e-9 rad"), Angle.radians(-.12e-9));
      expect(Angle.parse("-.12e-9radians"), Angle.radians(-.12e-9));
      expect(Angle.parse("-.12e-9 radians"), Angle.radians(-.12e-9));

      expect(Angle.parse("Infinity"), Angle.radians(double.infinity));
      expect(Angle.parse("Infinity㎭"), Angle.radians(double.infinity));
      expect(Angle.parse("Infinityrad"), Angle.radians(double.infinity));
      expect(Angle.parse("Infinity rad"), Angle.radians(double.infinity));
      expect(Angle.parse("Infinityradians"), Angle.radians(double.infinity));
      expect(Angle.parse("Infinity radians"), Angle.radians(double.infinity));

      expect(Angle.parse("NaN").radians, isNaN);
      expect(Angle.parse("NaN㎭").radians, isNaN);
      expect(Angle.parse("NaNrad").radians, isNaN);
      expect(Angle.parse("NaN rad").radians, isNaN);
      expect(Angle.parse("NaNradians").radians, isNaN);
      expect(Angle.parse("NaN radians").radians, isNaN);
    });
    test("Degrees", () {
      expect(Angle.parse("deg"), Angle.degrees(0));
      expect(Angle.parse("degree"), Angle.degrees(0));
      expect(Angle.parse("degrees"), Angle.degrees(0));
      expect(Angle.parse("°"), Angle.degrees(0));
      expect(Angle.parse("°′"), Angle.degrees(0));
      expect(Angle.parse("°′″"), Angle.degrees(0));
      expect(Angle.parse("°'"), Angle.degrees(0));
      expect(Angle.parse("°'\""), Angle.degrees(0));
      expect(Angle.parse("h"), Angle.degrees(0));
      expect(Angle.parse("hm"), Angle.degrees(0));
      expect(Angle.parse("hms"), Angle.degrees(0));
      expect(Angle.parse("hour"), Angle.degrees(0));
      expect(Angle.parse("hour minute"), Angle.degrees(0));
      expect(Angle.parse("hour minute second"), Angle.degrees(0));

      expect(Angle.parse("1deg"), Angle.degrees(1));
      expect(Angle.parse("1degree"), Angle.degrees(1));
      expect(Angle.parse("1degrees"), Angle.degrees(1));
      expect(Angle.parse("1°"), Angle.degrees(1));
      expect(Angle.parse("1° 0′ 0"), Angle.degrees(1));
      expect(Angle.parse("1° 0′ 0″"), Angle.degrees(1));
      expect(Angle.parse("1° 0' 0"), Angle.degrees(1));
      expect(Angle.parse("1° 0' 0\""), Angle.degrees(1));
      expect(Angle.parse("1h"), Angle.degrees(1));
      expect(Angle.parse("1h 0m"), Angle.degrees(1));
      expect(Angle.parse("1h 0m 0s"), Angle.degrees(1));
      expect(Angle.parse("1hour"), Angle.degrees(1));
      expect(Angle.parse("1hour 0minute"), Angle.degrees(1));
      expect(Angle.parse("1hour 0minute 0second"), Angle.degrees(1));

      expect(Angle.parse("3.5deg"), Angle.degrees(3.5));
      expect(Angle.parse("3.5degree"), Angle.degrees(3.5));
      expect(Angle.parse("3.5degrees"), Angle.degrees(3.5));
      expect(Angle.parse("3.5°"), Angle.degrees(3.5));
      expect(Angle.parse("3° 30′"), Angle.degrees(3.5));
      expect(Angle.parse("3° 30′ 0″"), Angle.degrees(3.5));
      expect(Angle.parse("3° 30'"), Angle.degrees(3.5));
      expect(Angle.parse("3° 30' 0\""), Angle.degrees(3.5));
      expect(Angle.parse("3.5h"), Angle.degrees(3.5));
      expect(Angle.parse("3h 30m"), Angle.degrees(3.5));
      expect(Angle.parse("3 h 30m 0s"), Angle.degrees(3.5));
      expect(Angle.parse("3.5hours"), Angle.degrees(3.5));
      expect(Angle.parse("3hours 30minutes"), Angle.degrees(3.5));
      expect(Angle.parse("3hours 30minutes 0second"), Angle.degrees(3.5));

      expect(Angle.parse("-2.deg"), Angle.degrees(-2));
      expect(Angle.parse("-2.degree"), Angle.degrees(-2));
      expect(Angle.parse("-2.degrees"), Angle.degrees(-2));
      expect(Angle.parse("-2.°"), Angle.degrees(-2));
      expect(Angle.parse("-2.° 0.′"), Angle.degrees(-2));
      expect(Angle.parse("-2.° 0.′ 0.″"), Angle.degrees(-2));
      expect(Angle.parse("-2.° 0.'"), Angle.degrees(-2));
      expect(Angle.parse("-2.° 0.' 0.\""), Angle.degrees(-2));
      expect(Angle.parse("-2.h"), Angle.degrees(-2));
      expect(Angle.parse("-2.h 0.m"), Angle.degrees(-2));
      expect(Angle.parse("-2.h 0.m 0.s"), Angle.degrees(-2));
      expect(Angle.parse("-2.hours"), Angle.degrees(-2));
      expect(Angle.parse("-2.hours 0.minute"), Angle.degrees(-2));
      expect(Angle.parse("-2.hours 0.minute 0.second"), Angle.degrees(-2));

      expect(Angle.parse("0.557625e+2deg"), Angle.degrees(55.7625));
      expect(Angle.parse("0.557625e+2degree"), Angle.degrees(55.7625));
      expect(Angle.parse("0.557625e+2degrees"), Angle.degrees(55.7625));
      expect(Angle.parse("0.557625e+2°"), Angle.degrees(55.7625));
      expect(Angle.parse("0.55e+2° 0.4575e+2′"), Angle.degrees(55.7625));
      expect(Angle.parse("0.55e+2° 0.45e+2′ 0.45e+2″"), Angle.degrees(55.7625));
      expect(Angle.parse("0.55e+2° 0.4575e+2'"), Angle.degrees(55.7625));
      expect(
          Angle.parse("0.55e+2° 0.45e+2' 0.45e+2\""), Angle.degrees(55.7625));
      expect(Angle.parse("0.557625e+2h"), Angle.degrees(55.7625));
      expect(Angle.parse("0.55e+2h 0.4575e+2m"), Angle.degrees(55.7625));
      expect(Angle.parse("0.55e+2h 0.45e+2m 0.45e+2s"), Angle.degrees(55.7625));
      expect(Angle.parse("0.557625e+2hour"), Angle.degrees(55.7625));
      expect(
          Angle.parse("0.55e+2hour 0.4575e+2minute"), Angle.degrees(55.7625));
      expect(Angle.parse("0.55e+2hour 0.45e+2minute 0.45e+2second"),
          Angle.degrees(55.7625));

      expect(Angle.parse("5576.25e-2deg"), Angle.degrees(55.7625));
      expect(Angle.parse("5576.25e-2degree"), Angle.degrees(55.7625));
      expect(Angle.parse("5576.25e-2degrees"), Angle.degrees(55.7625));
      expect(Angle.parse("5576.25e-2°"), Angle.degrees(55.7625));
      expect(Angle.parse("5500.0e-2° 4575.0e-2′"), Angle.degrees(55.7625));
      expect(Angle.parse("5500.0e-2° 4500.0e-2′ 4500.0e-2″"),
          Angle.degrees(55.7625));
      expect(Angle.parse("5500.0e-2° 4575.0e-2'"), Angle.degrees(55.7625));
      expect(Angle.parse("5500.0e-2° 4500.0e-2' 4500.0e-2\""),
          Angle.degrees(55.7625));
      expect(Angle.parse("5576.25e-2h"), Angle.degrees(55.7625));
      expect(Angle.parse("5500.0e-2h 4575e-2m"), Angle.degrees(55.7625));
      expect(Angle.parse("5500.0e-2h 4500e-2m 4500.0e-2s"),
          Angle.degrees(55.7625));
      expect(Angle.parse("5576.25e-2hour"), Angle.degrees(55.7625));
      expect(
          Angle.parse("5500.0e-2hour 4575.0e-2minute"), Angle.degrees(55.7625));
      expect(Angle.parse("5500.0e-2hour 4500.0e-2minute 4500e-2second"),
          Angle.degrees(55.7625));

      expect(Angle.parse("-.557625e+2deg"), Angle.degrees(-55.7625));
      expect(Angle.parse("-.557625e+2degree"), Angle.degrees(-55.7625));
      expect(Angle.parse("-.557625e+2degrees"), Angle.degrees(-55.7625));
      expect(Angle.parse("-.557625e+2°"), Angle.degrees(-55.7625));
      expect(Angle.parse("-.5500e+2° -.4575e+2′"), Angle.degrees(-55.7625));
      expect(Angle.parse("-.5500e+2° -.4500e+2′ -.4500e+2″"),
          Angle.degrees(-55.7625));
      expect(Angle.parse("-.5500e+2° -.4575e+2'"), Angle.degrees(-55.7625));
      expect(Angle.parse("-.5500e+2° -.4500e+2' -.4500e+2\""),
          Angle.degrees(-55.7625));
      expect(Angle.parse("-.557625e+2h"), Angle.degrees(-55.7625));
      expect(Angle.parse("-.5500e+2h -.4575e+2m"), Angle.degrees(-55.7625));
      expect(Angle.parse("-.5500e+2h -.4500e+2m -.4500e+2s"),
          Angle.degrees(-55.7625));
      expect(Angle.parse("-.557625e+2hour"), Angle.degrees(-55.7625));
      expect(Angle.parse("-.5500e+2hour -.4575e+2minute"),
          Angle.degrees(-55.7625));
      expect(Angle.parse("-.5500e+2hour -.4500e+2minute -.4500e+2second"),
          Angle.degrees(-55.7625));

      expect(Angle.parse("Infinity deg"), Angle.degrees(double.infinity));
      expect(Angle.parse("Infinity degree"), Angle.degrees(double.infinity));
      expect(Angle.parse("Infinity degrees"), Angle.degrees(double.infinity));
      expect(Angle.parse("Infinity°"), Angle.degrees(double.infinity));
      expect(
          Angle.parse("Infinity° Infinity′"), Angle.degrees(double.infinity));
      expect(Angle.parse("Infinity° Infinity′ Infinity″"),
          Angle.degrees(double.infinity));
      expect(
          Angle.parse("Infinity° Infinity'"), Angle.degrees(double.infinity));
      expect(Angle.parse("Infinity° Infinity' Infinity\""),
          Angle.degrees(double.infinity));
      expect(Angle.parse("Infinity h"), Angle.degrees(double.infinity));
      expect(
          Angle.parse("Infinity h Infinity m"), Angle.degrees(double.infinity));
      expect(Angle.parse("Infinity h Infinity m Infinity s"),
          Angle.degrees(double.infinity));
      expect(Angle.parse("Infinity hour"), Angle.degrees(double.infinity));
      expect(Angle.parse("Infinity hour Infinity minute"),
          Angle.degrees(double.infinity));
      expect(Angle.parse("Infinity hour Infinity minute Infinity second"),
          Angle.degrees(double.infinity));

      expect(Angle.parse("NaN deg").degrees, isNaN);
      expect(Angle.parse("NaN degree").degrees, isNaN);
      expect(Angle.parse("NaN degrees").degrees, isNaN);
      expect(Angle.parse("NaN°").degrees, isNaN);
      expect(Angle.parse("NaN° NaN′").degrees, isNaN);
      expect(Angle.parse("NaN° NaN′ NaN″").degrees, isNaN);
      expect(Angle.parse("NaN° NaN'").degrees, isNaN);
      expect(Angle.parse("NaN° NaN' NaN\"").degrees, isNaN);
      expect(Angle.parse("NaN h").degrees, isNaN);
      expect(Angle.parse("NaN h NaN m").degrees, isNaN);
      expect(Angle.parse("NaN h NaN m NaN s").degrees, isNaN);
      expect(Angle.parse("NaN hours").degrees, isNaN);
      expect(Angle.parse("NaN hours NaN minute").degrees, isNaN);
      expect(Angle.parse("NaN hours NaN minute NaN second").degrees, isNaN);
    });
    test("Gradians", () {
      expect(Angle.parse("grad"), Angle.gradians(0));
      expect(Angle.parse("gradians"), Angle.gradians(0));
      expect(Angle.parse("ᵍ"), Angle.gradians(0));

      expect(Angle.parse("1grad"), Angle.gradians(1));
      expect(Angle.parse("1gradians"), Angle.gradians(1));
      expect(Angle.parse("1ᵍ"), Angle.gradians(1));

      expect(Angle.parse("3.5grad"), Angle.gradians(3.5));
      expect(Angle.parse("3.5gradians"), Angle.gradians(3.5));
      expect(Angle.parse("3.5ᵍ"), Angle.gradians(3.5));

      expect(Angle.parse("-2.grad"), Angle.gradians(-2));
      expect(Angle.parse("-2.gradians"), Angle.gradians(-2));
      expect(Angle.parse("-2.ᵍ"), Angle.gradians(-2));

      expect(Angle.parse("+8e+9grad"), Angle.gradians(8e+9));
      expect(Angle.parse("+8e+9gradians"), Angle.gradians(8e+9));
      expect(Angle.parse("+8e+9ᵍ"), Angle.gradians(8e+9));

      expect(Angle.parse("2.5e-9grad"), Angle.gradians(2.5e-9));
      expect(Angle.parse("2.5e-9gradians"), Angle.gradians(2.5e-9));
      expect(Angle.parse("2.5e-9ᵍ"), Angle.gradians(2.5e-9));

      expect(Angle.parse("3.e-2grad"), Angle.gradians(3e-2));
      expect(Angle.parse("3.e-2gradians"), Angle.gradians(3e-2));
      expect(Angle.parse("3.e-2ᵍ"), Angle.gradians(3e-2));

      expect(Angle.parse("-.12e-9grad"), Angle.gradians(-.12e-9));
      expect(Angle.parse("-.12e-9gradians"), Angle.gradians(-.12e-9));
      expect(Angle.parse("-.12e-9ᵍ"), Angle.gradians(-.12e-9));

      expect(Angle.parse("Infinity grad"), Angle.gradians(double.infinity));
      expect(Angle.parse("Infinity gradians"), Angle.gradians(double.infinity));
      expect(Angle.parse("Infinity ᵍ"), Angle.gradians(double.infinity));

      expect(Angle.parse("NaN grad").gradians, isNaN);
      expect(Angle.parse("NaN gradians").gradians, isNaN);
      expect(Angle.parse("NaN ᵍ").gradians, isNaN);
    });
  });
}
