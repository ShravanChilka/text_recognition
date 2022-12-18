import 'package:google_ml_kit/google_ml_kit.dart' as ml_model;

abstract class TextRecogniseService {
  Future<String> recogniseText({required String imagePath});
}

class TextRecogniseServiceImpl implements TextRecogniseService {
  final ml_model.TextRecognizer textRecognizer = ml_model.TextRecognizer(
      script: ml_model.TextRecognitionScript.devanagiri);

  @override
  Future<String> recogniseText({required String imagePath}) async {
    final ml_model.InputImage inputImage =
        ml_model.InputImage.fromFilePath(imagePath);
    final ml_model.RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    await textRecognizer.close();
    String scannedText = '';
    for (ml_model.TextBlock textBlock in recognizedText.blocks) {
      for (ml_model.TextLine textLine in textBlock.lines) {
        scannedText = '$scannedText${textLine.text}\n';
      }
    }
    return scannedText;
  }
}
