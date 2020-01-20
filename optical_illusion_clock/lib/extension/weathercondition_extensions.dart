import 'package:flutter_clock_helper/model.dart';

extension WeatherConditionEmoji on WeatherCondition {
  String toEmoji() {
    switch (this) {
      case WeatherCondition.cloudy:
        return "⛅️";
      case WeatherCondition.foggy:
        return "🌫";
      case WeatherCondition.rainy:
        return "🌧";
      case WeatherCondition.snowy:
        return "🌨";
      case WeatherCondition.sunny:
        return "🔆";
      case WeatherCondition.thunderstorm:
        return "⛈";
      default:
        return "🌬";
    }
  }
}
