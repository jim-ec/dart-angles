import 'package:test/test.dart';

import '../lib/angles.dart';

void main() {
  group("Arithmetical operations", () {
    test("Zero angle", () {
      expect(Angle.zero() + Angle.fromTurns(1), Angle.fromTurns(1));
      expect(Angle.fromTurns(1) * 0, Angle.zero());
    });

    test("Multiplication", () {
      expect(Angle.fromTurns(1) * 1, Angle.fromTurns(1));
      expect(Angle.fromTurns(1) * 2, Angle.fromTurns(2));
      expect(-Angle.fromTurns(2), Angle.fromTurns(-2));
    });

    test("Division", () {
      expect(Angle.fromTurns(5) / 1, Angle.fromTurns(5));
      expect(Angle.fromTurns(6) / 3, Angle.fromTurns(2));
    });

    test("Addition", () {
      expect(Angle.fromTurns(2) + Angle.fromTurns(3), Angle.fromTurns(5));
      expect(Angle.fromTurns(2) - Angle.fromTurns(3), Angle.fromTurns(-1));
    });
  });
  group("Relational operators", () {
    test("Inequality", () {
      expect(Angle.fromTurns(1).compareTo(Angle.fromTurns(2)), -1);
      expect(Angle.fromTurns(2).compareTo(Angle.fromTurns(1)), 1);
      expect(Angle.fromTurns(1) != Angle.fromTurns(2), true);
      expect(Angle.fromTurns(1) < Angle.fromTurns(2), true);
      expect(Angle.fromTurns(1) <= Angle.fromTurns(2), true);
      expect(Angle.fromTurns(2) > Angle.fromTurns(1), true);
      expect(Angle.fromTurns(2) >= Angle.fromTurns(1), true);
    });
    test("Equality", () {
      expect(Angle.fromTurns(2).compareTo(Angle.fromTurns(2)), 0);
      expect(Angle.fromTurns(2) <= Angle.fromTurns(2), true);
      expect(Angle.fromTurns(2) >= Angle.fromTurns(2), true);
      expect(Angle.fromTurns(2) == Angle.fromTurns(2), true);
    });
  });
  group("Units", () {
    test("Turns", () {
      expect(Angle.fromTurns(0), Angle.zero());
      expect(Angle.fromTurns(0.5), Angle.halfTurn());
      expect(Angle.fromTurns(0.25), Angle.quarterTurn());
      expect(Angle.fromTurns(0.125), Angle.eighthTurn());
      expect(Angle.fromTurns(1), Angle.fullTurn());
      expect(Angle.fromTurns(1 / 3), Angle.thirdTurn());
    });
    test("Degrees", () {
      expect(Angle.fromDegrees(0), Angle.zero());
      expect(Angle.fromDegrees(90), Angle.quarterTurn());
      expect(Angle.fromDegrees(360), Angle.fullTurn());
    });
    test("Gradians", () {
      expect(Angle.fromGradians(0), Angle.zero());
      expect(Angle.fromGradians(100), Angle.quarterTurn());
      expect(Angle.fromGradians(400), Angle.fullTurn());
    });
  });
  group("Utility functions", () {
    test("Stringification", () {
      expect(Angle.fromDegrees(45).toString(), "45.0°");
    });
    test("Apprixmate equality", () {
      final Angle x = Angle.fromDegrees(45);
      expect(x.approximately(Angle.fromDegrees(45.01), 0.1), true);
      expect(x.approximately(Angle.fromDegrees(44.99), 0.1), true);
      expect(x.approximately(Angle.fromDegrees(45.1), 0.1), true);
      expect(x.approximately(Angle.fromDegrees(44.9), 0.1), true);

      expect(x.approximately(Angle.fromDegrees(45.1), 0.01), true);
      expect(x.approximately(Angle.fromDegrees(44.9), 0.01), true);
    });
  });
  group("Trigonometric functions", () {
    test("Sinusoidals", () {
      final Angle x = Angle.fromDegrees(45);
      final double epsilon = 1e-9;
      expect(Angle.asin(x.sin).approximately(x, epsilon), true);
      expect(Angle.acos(x.cos).approximately(x, epsilon), true);
      expect(Angle.atan(x.tan).approximately(x, epsilon), true);

      expect(Angle.atan2(0, 0), Angle.fromDegrees(0));
      expect(Angle.atan2(0, 1), Angle.fromDegrees(0));
      expect(Angle.atan2(1, 1), Angle.fromDegrees(45));
      expect(Angle.atan2(1, 0), Angle.fromDegrees(90));
      expect(Angle.atan2(1, -1), Angle.fromDegrees(135));
      expect(Angle.atan2(0, -1), Angle.fromDegrees(180));
      expect(Angle.atan2(-1, -1), Angle.fromDegrees(-135));
      expect(Angle.atan2(-1, 0), Angle.fromDegrees(-90));
      expect(Angle.atan2(-1, 1), Angle.fromDegrees(-45));

      expect(Angle.atanFullTurn(0, 0), Angle.fromDegrees(0));
      expect(Angle.atanFullTurn(0, 1), Angle.fromDegrees(0));
      expect(Angle.atanFullTurn(1, 1), Angle.fromDegrees(45));
      expect(Angle.atanFullTurn(1, 0), Angle.fromDegrees(90));
      expect(Angle.atanFullTurn(1, -1), Angle.fromDegrees(135));
      expect(Angle.atanFullTurn(0, -1), Angle.fromDegrees(180));
      expect(Angle.atanFullTurn(-1, -1), Angle.fromDegrees(225));
      expect(Angle.atanFullTurn(-1, 0), Angle.fromDegrees(270));
      expect(Angle.atanFullTurn(-1, 1), Angle.fromDegrees(315));
    });
  });
}
