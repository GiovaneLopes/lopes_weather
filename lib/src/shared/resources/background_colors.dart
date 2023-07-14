import 'package:flutter/material.dart';

class BackgroundColors {
  static List<Color> getBackgroundColor(int hour) {
    if (hour > 6 && hour <= 12) {
      return morning;
    } else if (hour > 12 && hour < 18) {
      return day;
    } else if (hour >= 18 && hour <= 21) {
      return afternoon;
    } else {
      return night;
    }
  }

  static const List<Color> morning = [
    Colors.blue,
    Colors.blue,
    Colors.lightBlue,
    Colors.white,
    Colors.yellow,
    Colors.yellow,
    Colors.orange,
  ];

  static const List<Color> day = [
    Colors.orange,
    Colors.yellow,
    Colors.yellow,
    Colors.white,
    Colors.lightBlue,
    Colors.blue,
    Colors.blue,
  ];

  static const List<Color> afternoon = [
    Colors.black,
    Colors.black,
    Color.fromARGB(255, 117, 3, 3),
    Colors.orange,
    Colors.yellow,
  ];

  static const List<Color> night = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.indigo,
  ];
}
