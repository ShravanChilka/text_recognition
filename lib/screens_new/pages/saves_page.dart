import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class SavesPage extends StatefulWidget {
  const SavesPage({Key? key}) : super(key: key);

  @override
  _SavesPageState createState() => _SavesPageState();
}

class _SavesPageState extends State<SavesPage> {
  List<String> savesList = [
    'Save 1',
    'Save 2',
    'Save 3',
    'Save 4',
    'Save 5',
  ];

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
        const SizedBox(height: 10),
        Expanded(
          child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 2),
              itemCount: savesList.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Palette.white300,
                  ),
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(savesList[index]),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
