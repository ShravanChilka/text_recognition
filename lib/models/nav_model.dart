import 'package:flutter/material.dart';

class NavModel {
  String name;
  ImageIcon imageIcon;
  bool isSelected;

  NavModel({
    required this.name,
    required this.imageIcon,
    required this.isSelected,
  });
}
