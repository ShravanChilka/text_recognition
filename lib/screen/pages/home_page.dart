import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:text_recognition/models/saves_model.dart';
import 'package:text_recognition/utils/widgets/custom_icon_button.dart';
import '../../providers/database_provider.dart';
import '../../services/text_recognise_service.dart';
import '../../utils/widgets/image_view.dart';
import '../../utils/utils.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imagePath = '';
  String scannedText = '';
  bool isLoading = false;
  final ImagePicker picker = ImagePicker();
  final TextRecogniseService textRecogniseService = TextRecogniseServiceImpl();

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            color: Palette.white300,
            width: double.maxFinite,
            child: const Padding(
              padding: EdgeInsets.only(left: 16, top: 3, bottom: 3),
              child: Text('Image Text Recogniziton'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Palette.primary500,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(children: [
                const Text(
                  'Analyse Image and convert Picture to text',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                ImageView(imagePath: imagePath),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Visibility(
                      visible: imagePath.isNotEmpty,
                      child: CustomIconButton(
                        title: 'Analyse',
                        onTap: () => analyseClickEvent(context),
                        imagePath: '$assetsPath/analyze_icon.png',
                      ),
                    ),
                    const Spacer(),
                    CustomIconButton(
                      title: '',
                      onTap: () => cameraClickEvent(context),
                      imagePath: '$assetsPath/camera_icon.png',
                    ),
                    const SizedBox(width: 5),
                    CustomIconButton(
                      title: '',
                      onTap: () => galleryClickEvent(context),
                      imagePath: '$assetsPath/gallery_icon.png',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
              ]),
            ),
          ),
          isLoading
              ? LottieBuilder.network(
                  'https://assets6.lottiefiles.com/packages/lf20_xbf1be8x.json',
                  animate: true,
                )
              : const SizedBox.shrink(),
          Visibility(
            visible: scannedText.isNotEmpty,
            child: Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Palette.white300,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const Text(
                          'Analysed Text',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 5),
                        Text(scannedText),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIconButton(
                              imagePath: '$assetsPath/copy_icon.png',
                              title: 'Copy',
                              onTap: () => copyClickEvent(context),
                            ),
                            CustomIconButton(
                              imagePath: '$assetsPath/saves_filled_icon.png',
                              title: 'Save',
                              onTap: () =>
                                  saveClickEvent(context, databaseProvider),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void cameraClickEvent(BuildContext context) async {
    try {
      final image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          imagePath = image.path;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void galleryClickEvent(BuildContext context) async {
    try {
      final image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          imagePath = image.path;
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void analyseClickEvent(BuildContext context) async {
    setState(() => isLoading = true);
    final result =
        await textRecogniseService.recogniseText(imagePath: imagePath);
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isLoading = false;
      scannedText = result;
    });
  }

  void copyClickEvent(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: scannedText)).whenComplete(
        () => showSnackBar(title: 'Copied to clipboard!', context: context));
  }

  void saveClickEvent(
      BuildContext context, DatabaseProvider databaseProvider) async {
    await databaseProvider
        .addToSave(
      savesModel: SavesModel(recogniseText: scannedText),
    )
        .whenComplete(() {
      showSnackBar(title: 'Added to Saves', context: context);
    });
  }
}
