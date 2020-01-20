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
      Color(0xFF32243e),
      Color(0xFF355C7D),
      Color(0xFF302b63),
      Color(0x88C06C84),
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
