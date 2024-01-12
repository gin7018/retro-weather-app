import 'package:flutter/material.dart';

const Color SUNNY_WEATHER_BOX_COLOR = Color.fromARGB(255, 113, 190, 252);
const Color SUNNY_WEATHER_BACKGROUND_COLOR = Color.fromARGB(255, 131, 195, 247);

const Color CLOUDY_WEATHER_BOX_COLOR = Color.fromARGB(255, 96, 148, 187);
const Color CLOUDY_WEATHER_BACK_COLOR = Color.fromARGB(255, 120, 155, 183);

const Color NIGHT_WEATHER_BOX_COLOR = Color.fromARGB(255, 44, 82, 113);
const Color NIGHT_WEATHER_BACK_COLOR = Color.fromARGB(255, 52, 97, 133);

class ColorThemeSetter {
  Color boxColor;
  Color background;
  late BoxDecoration containerDeco;

  ColorThemeSetter(this.boxColor, this.background) {
    containerDeco = BoxDecoration(
        color: background,
        border: const Border(
          top: BorderSide(
            color: Colors.white,
            width: 1,
          ),
          right: BorderSide(
            color: Colors.white,
            width: 1,
          ),
          left: BorderSide(
            color: Colors.black,
            width: 3,
          ),
          bottom: BorderSide(
            color: Colors.black,
            width: 3,
          ),
        ));
  }
}

BoxDecoration getContainerDeco(DateTime date) {
  Color background = SUNNY_WEATHER_BACKGROUND_COLOR;
  if (date.hour >= 18) {
    background = NIGHT_WEATHER_BACK_COLOR;
  }
  return BoxDecoration(
      color: background,
      border: const Border(
        top: BorderSide(
          color: Colors.white,
          width: 1,
        ),
        right: BorderSide(
          color: Colors.white,
          width: 1,
        ),
        left: BorderSide(
          color: Colors.white,
          width: 3,
        ),
        bottom: BorderSide(
          color: Colors.white,
          width: 3,
        ),
      ));
}

BoxDecoration searchDecoration = const BoxDecoration(
    color: Colors.black,
    border: Border(
      top: BorderSide(
        color: Colors.white,
        width: 1,
      ),
      right: BorderSide(
        color: Colors.white,
        width: 1,
      ),
      left: BorderSide(
        color: Colors.white,
        width: 1,
      ),
      bottom: BorderSide(
        color: Colors.white,
        width: 1,
      ),
    ));

final sunnyTheme =
    ColorThemeSetter(SUNNY_WEATHER_BOX_COLOR, SUNNY_WEATHER_BACKGROUND_COLOR);
final cloudyTheme =
    ColorThemeSetter(CLOUDY_WEATHER_BOX_COLOR, CLOUDY_WEATHER_BACK_COLOR);
final nightTheme =
    ColorThemeSetter(NIGHT_WEATHER_BOX_COLOR, NIGHT_WEATHER_BACK_COLOR);
