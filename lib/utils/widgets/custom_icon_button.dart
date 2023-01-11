import 'package:flutter/material.dart';
import '../utils.dart';

class CustomIconButton extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;
  const CustomIconButton({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: Palette.primary500,
        onTap: () => onTap(),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Palette.secondary500,
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ImageIcon(
                  AssetImage(imagePath),
                  size: 20,
                  color: Colors.white,
                ),
                const SizedBox(width: 5),
                Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
