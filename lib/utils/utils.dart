import 'package:flutter/material.dart';

const assetsPath = 'assets';

class Palette {
  static const primary500 = Color(0xFFC2C8D1);
  static const primary300 = Color(0xFFD8DDE9);
  static const secondary300 = Color(0xFF526281);
  static const secondary500 = Color(0xFF070F25);
  static const white300 = Color(0xFFEAEEF6);
}

void showSnackBar({required String title, required BuildContext context}) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Palette.secondary500,
    ));

class DatabaseBoxKey {
  static const savesBoxKey = 'saves_box_key';
}

class DatabaseKey {
  static const savesKey = 'saves_key';
}
