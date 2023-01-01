import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/text_recognise_service.dart';
import '../../utils/widgets/custom_button.dart';
import '../../utils/widgets/image_view.dart';
import '../../utils/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String imagePath = '';
  String scannedText = '';
  final ImagePicker picker = ImagePicker();
  final TextRecogniseService textRecogniseService = TextRecogniseServiceImpl();

  @override
  Widget build(BuildContext context) {
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                ImageView(imagePath: imagePath),
                const SizedBox(height: 10),
                Row(
                  children: [
                    CustomButton(
                      title: 'Camera',
                      onTap: () => cameraClickEvent(context),
                    ),
                    const SizedBox(width: 5),
                    CustomButton(
                      title: 'Gallery',
                      onTap: () => galleryClickEvent(context),
                    ),
                    const Spacer(),
                    Visibility(
                      visible: imagePath.isNotEmpty,
                      child: CustomButton(
                        title: 'Analyse',
                        onTap: () => analyseClickEvent(context),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          Visibility(
            visible: scannedText.isNotEmpty,
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Palette.white300,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(scannedText),
              ),
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
    final result =
        await textRecogniseService.recogniseText(imagePath: imagePath);
    setState(() {
      scannedText = result;
    });
  }
}
