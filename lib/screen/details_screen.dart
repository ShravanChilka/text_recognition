import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_recognition/models/saves_model.dart';
import 'package:text_recognition/providers/database_provider.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import '../utils/utils.dart';
import '../utils/widgets/custom_icon_button.dart';

class DetailsScreen extends StatelessWidget {
  final SavesModel savesModel;
  const DetailsScreen({
    super.key,
    required this.savesModel,
  });

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    return Scaffold(
      backgroundColor: Palette.primary300,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                color: Palette.white300,
                width: double.maxFinite,
                child: const Padding(
                  padding: EdgeInsets.only(left: 16, top: 3, bottom: 3),
                  child: Text('Details'),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Palette.white300,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(savesModel.recogniseText),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIconButton(
                              imagePath: '$assetsPath/copy_icon.png',
                              title: 'Copy',
                              onTap: () => copyClickEvent(context),
                            ),
                            CustomIconButton(
                              imagePath: '$assetsPath/saves_icon.png',
                              title: 'Unsave',
                              onTap: () =>
                                  unsaveClickEvent(context, databaseProvider),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void copyClickEvent(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: savesModel.recogniseText))
        .whenComplete(() =>
            showSnackBar(title: 'Copied to clipboard!', context: context));
  }

  void unsaveClickEvent(
      BuildContext context, DatabaseProvider databaseProvider) async {
    await databaseProvider.removeSave(savesModel: savesModel).whenComplete(() {
      showSnackBar(title: 'Removed from saves', context: context);
      Navigator.of(context).pop();
    });
  }
}
