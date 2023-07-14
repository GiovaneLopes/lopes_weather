import 'package:flutter/material.dart';

class WeatherExtension {
  IconData getIconFromCode(int code) {
    if (code >= 200 && code <= 232) return Icons.thunderstorm_outlined;
    if (code >= 300 && code <= 321) return Icons.water_drop_rounded;
    if (code >= 500 && code <= 531) return Icons.cloudy_snowing;
    if (code >= 600 && code <= 622) return Icons.snowing;
    if (code >= 701 && code <= 781) return Icons.storm;
    if (code == 800) return Icons.sunny;
    if (code > 800) return Icons.cloud;
    return Icons.question_mark_rounded;
  }


}
