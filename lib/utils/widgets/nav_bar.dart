import 'package:flutter/material.dart';
import 'package:text_recognition/models/nav_model.dart';
import 'package:text_recognition/utils/widgets/nav_item.dart';

import '../utils.dart';

class NavBar extends StatelessWidget {
  final List<NavModel> navModelList;
  final Function(int index) onPageChanged;
  const NavBar(
      {Key? key, required this.navModelList, required this.onPageChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Palette.secondary500,
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ListView.builder(
                itemCount: navModelList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () => onPageChanged(index),
                    child: NavItem(
                      navModel: NavModel(
                        isSelected: navModelList[index].isSelected,
                        imageIcon: navModelList[index].imageIcon,
                        name: navModelList[index].name,
                      ),
                    ),
                  );
                }))
          ],
        ),
      ),
    );
  }
}
