import 'package:flutter/material.dart';

class ClockTheme extends InheritedWidget {
  static ClockTheme of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ClockTheme>();

  ClockTheme({Widget child, Key key}) : super(key: key, child: child);

  final lightTheme = ClockThemeData(
    backgroundColor: Colors.white,
    textColor: Colors.black87,
    disabledTextColor: Colors.grey,
    gradientColors: List(),
  );

  final darkTheme = ClockThemeData(
    backgroundColor: Colors.black54,
    textColor: Colors.white70,
    disabledTextColor: Colors.white10,
    gradientColors: List(),
  );

  ClockThemeData getTheme(BuildContext context) => Theme.of(context).brightness == Brightness.light ? lightTheme : darkTheme;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}

class ClockThemeData {
  final Color backgroundColor;
  final Color textColor;
  final Color disabledTextColor;
  final List<Color> gradientColors;

  ClockThemeData({
    this.backgroundColor,
    this.textColor,
    this.disabledTextColor,
    this.gradientColors,
  });
}
