import 'package:flutter/material.dart';
import 'package:flutter_clock_helper/model.dart';

class OpticalIllusionDigits extends InheritedWidget {
  static const String zero = """0000000
0111110
0100010
0100010
0100010
0100010
0100010
0111110
0000000
""";

  static const String one = """0000000
0001100
0000100
0000100
0000100
0000100
0000100
0000100
0000000
""";

  static const String two = """0000000
0111110
0000010
0000010
0000010
0111110
0100000
0111110
0000000
""";

  static const String three = """0000000
0111110
0000010
0011110
0000010
0000010
0000010
0111110
0000000
""";

  static const String four = """0000000
0100010
0100010
0100010
0100010
0100010
0111110
0000010
0000000
""";

  static const String five = """0000000
0111110
0100000
0111110
0000010
0000010
0000010
0111110
0000000
""";

  static const String six = """0000000
0111110
0100000
0111110
0100010
0100010
0100010
0111110
0000000
""";

  static const String seven = """0000000
0111110
0000010
0000010
0000010
0000010
0000010
0000010
0000000
""";

  static const String eight = """0000000
0111110
0100010
0111110
0100010
0100010
0100010
0111110
0000000
""";

  static const String nine = """0000000
0111110
0100010
0100010
0100010
0111110
0000010
0011110
0000000
""";

  static OpticalIllusionDigits of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<OpticalIllusionDigits>();

  final digits = const {0: zero, 1: one, 2: two, 3: three, 4: four, 5: five, 6: six, 7: seven, 8: eight, 9: nine};

  String forecast(WeatherCondition condition) {
    switch (condition) {
      case WeatherCondition.cloudy:
        return "⛅️";
      case WeatherCondition.foggy:
        return "⛅️";
      case WeatherCondition.rainy:
        return "⛅️";
      case WeatherCondition.snowy:
        return "⛅️";
      case WeatherCondition.sunny:
        return "⛅️";
      case WeatherCondition.thunderstorm:
        return "⛅️";
      default:
        return "⛅️";
    }
  }

  const OpticalIllusionDigits({Widget child, Key key}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

}
