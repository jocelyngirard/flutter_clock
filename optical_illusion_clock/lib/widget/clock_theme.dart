import 'package:flutter/material.dart';

class ClockTheme extends InheritedWidget {
  static ClockTheme of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<ClockTheme>();

  final lightTheme = ClockThemeData(
    backgroundColor: Colors.white,
    textColor: Colors.black87,
    disabledTextColor: Colors.black12,
    gradientColors: [
      Colors.deepPurple,
      Colors.black,
      Color(0xFFFC466B),
      Color(0xFF3F5EFB),
    ],
  );

  final darkTheme = ClockThemeData(
    backgroundColor: Color(0xFF121212),
    textColor: Colors.white70,
    disabledTextColor: Colors.white10,
    gradientColors: [
      Colors.grey,
      Colors.white12,
      Colors.white30,
      Colors.white70,
    ],
  );

  ClockTheme({Widget child, Key key}) : super(key: key, child: child);

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
