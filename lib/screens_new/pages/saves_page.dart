import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class SavesPage extends StatefulWidget {
  const SavesPage({Key? key}) : super(key: key);

  @override
  _SavesPageState createState() => _SavesPageState();
}

class _SavesPageState extends State<SavesPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30),
          color: Palette.white300,
          width: double.maxFinite,
          child: const Padding(
            padding: EdgeInsets.only(left: 16, top: 3, bottom: 3),
            child: Text('Saves'),
          ),
        ),
      ],
    );
  }
}
