import 'dart:ui';

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}

Color colorGreen = _colorFromHex("#1fda46");
Color colorDarkGreen = _colorFromHex("#075e55");
Color colorGray = _colorFromHex("#acaaaa");
Color colorDarkGray = _colorFromHex("#504f4f");
Color colorLightGray = _colorFromHex("#797979");
Color colorLightGreen = _colorFromHex("#e6f7ff");
