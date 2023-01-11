import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_ml_kit/google_ml_kit.dart' as ml;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? imagePath;
  final ImagePicker picker = ImagePicker();
  String scannedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imagePath != null
                ? Center(
                    child: Image.file(
                      File(imagePath!),
                      width: 200,
                      height: 200,
                    ),
                  )
                : Center(
                    child: Container(
                      color: Colors.black12,
                      width: 200,
                      height: 200,
                      child: const Center(child: Icon(Icons.upload)),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, top: 10, bottom: 10, right: 5),
                  child: InkWell(
                    onTap: () => cameraClickEvent(context),
                    child: Ink(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black12,
                      ),
                      child: const Icon(Icons.camera_alt),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10, top: 10, bottom: 10, left: 5),
                  child: InkWell(
                    onTap: () => galleryClickEvent(context),
                    child: Ink(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black12,
                      ),
                      child: const Icon(Icons.image),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10, top: 10, bottom: 10, left: 5),
                  child: InkWell(
                    onTap: () {
                      if (imagePath != null) {
                        recogniseText();
                      }
                    },
                    child: Ink(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orangeAccent,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          'Recognise Text',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 10, top: 10, bottom: 10, left: 5),
                  child: InkWell(
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: scannedText))
                          .whenComplete(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Text copied to clipboard')));
                      });
                    },
                    child: Ink(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black12,
                      ),
                      child: const Icon(Icons.copy),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(child: SingleChildScrollView(child: Text(scannedText))),
          ],
        ),
      )),
    );
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

  void recogniseText() async {
    ml.InputImage inputImage = ml.InputImage.fromFilePath(imagePath!);
    ml.TextRecognizer textRecognizer = ml.GoogleMlKit.vision
        .textRecognizer(script: ml.TextRecognitionScript.devanagiri);
    ml.RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    scannedText = '';
    for (ml.TextBlock textBlock in recognizedText.blocks) {
      for (ml.TextLine textLine in textBlock.lines) {
        scannedText = '$scannedText${textLine.text}\n';
      }
    }
    setState(() {});
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
}
