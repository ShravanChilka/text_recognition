import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_recognition/screen/details_screen.dart';
import '../../providers/database_provider.dart';
import '../../utils/utils.dart';

class SavesPage extends StatelessWidget {
  const SavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    databaseProvider.getSaves();
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
        databaseProvider.savesModelList.isNotEmpty
            ? Expanded(
                child: GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2),
                    itemCount: databaseProvider.savesModelList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            savesModel: databaseProvider.savesModelList[index],
                          ),
                        )),
                        child: Ink(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Palette.white300,
                          ),
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(databaseProvider
                                .savesModelList[index].recogniseText),
                          ),
                        ),
                      );
                    }),
              )
            : const Text('No saves found!'),
      ],
    );
  }
}
