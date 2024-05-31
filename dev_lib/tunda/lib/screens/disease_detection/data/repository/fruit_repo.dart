import 'package:flutter/material.dart';

// import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_plus/tflite_flutter_plus.dart';

import 'package:tunda/screens/disease_detection/data/model/tunda_model.dart';

class FruitRepo {
  Future<PlantModel> loadPlantModel() async {
    // final interpreter = await Interpreter.fromAsset('plant.tflite',
    final interpreter = await Interpreter.fromAsset('plantv2.tflite',
        options: InterpreterOptions());
    final inputShape = interpreter.getInputTensor(0).shape;
    final outputShape = interpreter.getOutputTensor(0).shape;
    debugPrint('InputShape: $inputShape');
    debugPrint('OutputShape: $outputShape');

    final inputType = interpreter.getInputTensor(0).type;
    final outputType = interpreter.getOutputTensor(0).type;
    debugPrint('InputType: $inputType ');
    debugPrint('OutputType: $outputType');
    return PlantModel(
        inputShape: inputShape,
        inputType: inputType,
        interpreter: interpreter,
        outputShape: outputShape,
        outputType: outputType);
  }

  Future<ClassifierModel> loadModel() async {
    // final interpreter = await Interpreter.fromAsset('disease_detection.tflite',
    final interpreter = await Interpreter.fromAsset(
        'maize_disease_detection.tflite',
        options: InterpreterOptions());
    final inputShape = interpreter.getInputTensor(0).shape;
    final outputShape = interpreter.getOutputTensor(0).shape;
    debugPrint('InputShape: $inputShape');
    debugPrint('OutputShape: $outputShape');

    final inputType = interpreter.getInputTensor(0).type;
    final outputType = interpreter.getOutputTensor(0).type;
    debugPrint('InputType: $inputType ');
    debugPrint('OutputType: $outputType');
    return ClassifierModel(
        inputShape: inputShape,
        inputType: inputType,
        interpreter: interpreter,
        outputShape: outputShape,
        outputType: outputType);
  }

  //Type Image
  // TensorImage preProcessInput(picture) {

  //   final inputTensor = TensorImage();
  //   inputTensor.loadImage(picture);
  //   final minLength = min(inputTensor.height, inputTensor.width);
  //   final cropOp = ResizeWithCropOrPadOp(minLength, minLength);
  //   final shapeLength = inputShape[1];
  //   final resizeOp = ResizeOp(shapeLength, shapeLength, ResizeMethod.bilinear);
  //   final normalizeOp = NormalizeOp(127.5, 127.5);
  //   final imageProcessor = ImageProcessorBuilder()
  //       .add(cropOp)
  //       .add(resizeOp)
  //       .add(normalizeOp)
  //       .build();
  //   imageProcessor.process(inputTensor);
  //   return inputTensor;
  // }

  // callProcess(image) {
  //   final inputImage = preProcessInput(image);
  //   print(
  //       'Pre-processed image: ${inputImage.width}x ${inputImage.height} size: ${inputImage.buffer.lengthInBytes}bytes');
  // }
}
