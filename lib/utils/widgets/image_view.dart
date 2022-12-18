import 'dart:io';

import 'package:flutter/material.dart';

import '../utils.dart';

class ImageView extends StatelessWidget {
  final String imagePath;
  const ImageView({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imagePath.isEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 250,
          width: double.maxFinite,
          child: Image.asset(
            '$assetsPath/sample.jpg',
            fit: BoxFit.fitWidth,
          ),
        ),
      );
    } else {
      return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            height: 250,
            width: double.maxFinite,
            child: Image.file(
              File(imagePath),
              fit: BoxFit.fitWidth,
            ),
          ));
    }
  }
}
