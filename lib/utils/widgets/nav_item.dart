import 'package:flutter/material.dart';
import '../../models/nav_model.dart';
import '../utils.dart';

class NavItem extends StatelessWidget {
  final NavModel navModel;
  const NavItem({Key? key, required this.navModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (navModel.isSelected) {
      return Container(
        height: double.maxFinite,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.only(left: 12, right: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Palette.secondary300,
        ),
        child: Row(
          children: [
            navModel.imageIcon,
            const SizedBox(width: 5),
            Text(
              navModel.name,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      );
    } else {
      return Container(
          padding: const EdgeInsets.all(12), child: navModel.imageIcon);
    }
  }
}
