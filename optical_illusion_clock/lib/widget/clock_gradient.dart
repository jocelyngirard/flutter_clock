import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations/multi_track_tween.dart';

class ClockGradient extends StatefulWidget {
  final List<Color> gradientColors;

  const ClockGradient({Key key, this.gradientColors}) : super(key: key);

  @override
  _ClockGradientState createState() => _ClockGradientState();
}

class _ClockGradientState extends State<ClockGradient> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  MultiTrackTween _tween;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(duration: Duration(seconds: 10), vsync: this)..repeat(reverse: true);
    _setAnimation();
  }

  @override
  void didUpdateWidget(ClockGradient oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gradientColors != widget.gradientColors) {
      _animationController.stop();
      setState(() {
        _setAnimation();
      });
      _animationController.repeat(reverse: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            _animation.value["color1"],
            _animation.value["color2"],
          ],
        ),
      ),
    );
  }

  void _setAnimation() {
    _tween = MultiTrackTween([
      Track("color1").add(Duration(seconds: 10), ColorTween(begin: widget.gradientColors[0], end: widget.gradientColors[2])),
      Track("color2").add(Duration(seconds: 10), ColorTween(begin: widget.gradientColors[1], end: widget.gradientColors[3]))
    ]);
    _animation = _tween.animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
  }
}
