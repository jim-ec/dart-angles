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
}
