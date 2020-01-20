import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/controlled_animation.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

class AnimatedBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 10), ColorTween(begin: Colors.deepPurple, end: Color(0xFFFC466B))),
      Track("color2").add(Duration(seconds: 10), ColorTween(begin: Colors.black, end: Color(0xFF3F5EFB)))
    ]);

    return ControlledAnimation(
      playback: Playback.MIRROR,
      tween: tween,
      duration: tween.duration,
      builder: (context, animation) {
        return Container(
          decoration:
              BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomLeft, end: Alignment.topRight, colors: [animation["color1"], animation["color2"]])),
        );
      },
    );
  }
}
