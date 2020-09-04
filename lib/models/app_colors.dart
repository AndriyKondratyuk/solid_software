import 'package:flutter/material.dart';

List<Color> colors = [
  Colors.blue,
  Colors.red,
  Colors.amber,
  Colors.green,
  Colors.orange,
  Colors.purple,
  Colors.cyan,
  Colors.yellow,
  Colors.pink,
  Colors.indigo,
];

class AppColors {
  Color bgColor, uiColor, textColor;

  AppColors(
      {this.bgColor = Colors.white,
      this.uiColor = Colors.blue,
      this.textColor = Colors.white});

  void changeColor() {
    Color _newColor = uiColor;
    do {
      _newColor = colors[random(colors.length)];
    } while (_newColor == uiColor);
    bgColor = _newColor.withAlpha(180);
    uiColor = _newColor;
  }

  //Simple randomizer without using external libs.
  int random(int lim) {
    int _seconds = DateTime.now().second;
    return _seconds % lim;
  }
}
