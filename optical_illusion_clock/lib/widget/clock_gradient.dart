import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

import 'clock_theme.dart';

class ClockGradient extends StatefulWidget {

  @override
  _ClockGradientState createState() => _ClockGradientState();
}

class _ClockGradientState extends State<ClockGradient> {

  @override
  Widget build(BuildContext context) {
    final clockTheme = ClockTheme.of(context).getTheme(context);

    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 10), ColorTween(begin: clockTheme.gradientColors[0], end: clockTheme.gradientColors[2])),
      Track("color2").add(Duration(seconds: 10), ColorTween(begin: clockTheme.gradientColors[1], end: clockTheme.gradientColors[3]))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                animation["color1"],
                animation["color2"],
              ],
            ),
          ),
        );
      },
    );
  }
}
