import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart' as img;

import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';
// import 'package:tflite_flutter_plus/tflite_flutter_plus.dart';
import 'package:tunda/screens/disease_detection/data/datasources/label_datasource.dart';
import 'package:tunda/screens/disease_detection/data/repository/fruit_repo.dart';
// import 'package:tunda/presentation/fungicides/bloc/recommended_fungicides_bloc.dart';
// import 'package:tunda/presentation/widgets/classifier_cat.dart';
import 'package:tunda/screens/disease_detection/presentation/fungicides/bloc/recommended_fungicides_bloc.dart';
import 'package:tunda/screens/disease_detection/presentation/widgets/classifier_cat.dart';

part 'fruit_tester_event.dart';
part 'fruit_tester_state.dart';

class FruitTesterBloc extends Bloc<FruitTesterEvent, FruitTesterState> {
  final RecommendedFungicidesBloc recommendedFungicidesBloc;
  FruitTesterBloc({required this.recommendedFungicidesBloc})
      : super(FruitTesterInitial()) {
    on<LoadData>((event, emit) async {
      try {
        emit(FruitTesterInitial());
        emit(FruitTesterLoading());

        ///
        final plantRepo = await FruitRepo().loadPlantModel();
        print('plant model loaded successfully');

        TensorImage preprocessBinaryInput(picture) {
          final inputTensor = TensorImage(plantRepo.inputType);
          inputTensor.loadImage(picture);
          final minLength = min(inputTensor.height, inputTensor.width);
          final cropOp = ResizeWithCropOrPadOp(minLength, minLength);
          final shapeLength = plantRepo.inputShape;
          final resizeOp =
              ResizeOp(shapeLength[1], shapeLength[2], ResizeMethod.bilinear);
          // final normalizeOp = NormalizeOp(127.5, 127.5);
          // Normalize the pixel values to be between 0 and 1
          final normalizeOp =
              NormalizeOp(0, 1); // Assuming pixel values range from 0 to 255
          int cropSize = min(inputTensor.height, inputTensor.width);
          return ImageProcessorBuilder()
              // .add(cropOp)
              .add(resizeOp)
              // .add(normalizeOp)
              .build()
              .process(inputTensor);
        }

        Future<bool> predictPlant(image) async {
          final inputBuffer = preprocessBinaryInput(image);
          final outputBuffer = TensorBuffer.createFixedSize(
              plantRepo.outputShape, plantRepo.outputType);
          plantRepo.interpreter.run(inputBuffer.buffer, outputBuffer.buffer);
          final isPlant = outputBuffer.getDoubleValue(0) > 0.5;
          return isPlant;
        }

        var newConvertedImage = event.convertedImage;
        try {
          final isPlant = await predictPlant(newConvertedImage);
          if (isPlant) {
            // debugPrint('Plant detected');
            final labelDs = await LabelDataSource().loadLabels();
            print('labels:${labelDs[0]}');
            final fRipo = await FruitRepo().loadModel();
            TensorImage preProcessInput(picture) {
              final inputTensor = TensorImage(fRipo.inputType);

              inputTensor.loadImage(picture);
              final minLength = min(inputTensor.height, inputTensor.width);
              final cropOp = ResizeWithCropOrPadOp(minLength, minLength);
              print(
                  'CROPOP ${cropOp.getOutputImageHeight(inputTensor.height, inputTensor.width)}');
              final shapeLength = fRipo.inputShape;
              print('shapeLength $shapeLength');
              final resizeOp = ResizeOp(
                  shapeLength[1], shapeLength[2], ResizeMethod.bilinear);
              // final normalizeOp = NormalizeOp(127.5, 127.5);
              final normalizeOp = NormalizeOp(0, 1);
              print('Nomralize Op ${normalizeOp.stddev}');

              int cropSize = min(inputTensor.height, inputTensor.width);
              print('crop size $cropSize');
              //
              // Calculate mean and standard deviation for rescaling
              //const mean = 0.0;
              //const stddev =
              1.0 / 255.0; // Rescale by dividing pixel values by 255.0

              // Rescale the pixel values to be between 0 and 1
              //final rescaleOp = NormalizeOp(mean, stddev);
              //

              return ImageProcessorBuilder()
                  // .add(cropOp)
                  .add(resizeOp)
                  //.add(rescaleOp)
                  // .add(normalizeOp)
                  .build()
                  .process(inputTensor);
            }

            var convertedImage = event.convertedImage;

            final inputImage = preProcessInput(convertedImage);
            print(inputImage);
            print(
                'Pre-processed image: ${inputImage.width}x ${inputImage.height} size: ${inputImage.buffer.lengthInBytes}bytes');
            print(fRipo.outputShape);
            print(fRipo.outputType);

            final outputBuffer = TensorBuffer.createFixedSize(
                fRipo.outputShape, fRipo.outputType);
            final array = outputBuffer.getDoubleList();
            final copy =
                array.map((value) => value.toStringAsFixed(4)).toList();
            print('jaba$copy');
            final highest = array.reduce(max);
            final maxIndex = array.indexOf(highest);

            print('Disease: $maxIndex');
            final String maxString = labelDs[maxIndex];
            print('Disease: $maxString');

            fRipo.interpreter.run(inputImage.buffer, outputBuffer.getBuffer());
            print('OutputBuffer: ${outputBuffer.getDoubleList()}]');

            List<ClassifierCategory> postProcessOutput(
                TensorBuffer outputBuffer) {
              final postProcessNormalizeOp = NormalizeOp(0, 1);
              final probabilityProcessor =
                  TensorProcessorBuilder().add(postProcessNormalizeOp).build();
              final labeledResult = TensorLabel.fromList(
                  labelDs, probabilityProcessor.process(outputBuffer));
              final categoryList = <ClassifierCategory>[];
              labeledResult.getMapWithFloatValue().forEach((key, value) {
                final category = ClassifierCategory(key, value);
                categoryList.add(category);
                debugPrint('label: ${category.label}, score:${category.score}');
              });
              categoryList.sort((a, b) => (b.score > a.score ? 1 : -1));
              return categoryList;
            }

            Future<ClassifierCategory> predict(image) async {
              final inpoutImage = preProcessInput(image);
              final outputBuffer = TensorBuffer.createFixedSize(
                  fRipo.outputShape, fRipo.outputType);
              fRipo.interpreter.run(inpoutImage.buffer, outputBuffer.buffer);
              final resultCategories = postProcessOutput(outputBuffer);
              final topResult = resultCategories.first;
              final topScore = topResult.score;
              final topLabel = topResult.label;
              final formattedProbability = (topScore * 100).toStringAsFixed(2);
              debugPrint('Top category: $formattedProbability');

              debugPrint('Top category: $topResult');

              emit(FruitTesterLoaded(
                  topLabel: topLabel, topScore: formattedProbability));
              return topResult;
            }

            await predict(convertedImage);
            if (state is FruitTesterLoaded) {
              final loadedState = state as FruitTesterLoaded;
              print('Detected disease label: ${loadedState.topLabel}');
              recommendedFungicidesBloc
                  .add(FetchRecommendedFungicides(loadedState.topLabel));
            }
          } else {
            emit(FruitTesterError());
            recommendedFungicidesBloc.add(ClearRecommendedFungicides());
            debugPrint('No plant detected');
          }
        } catch (e) {
          debugPrint('Error: $e');
          emit(FruitTesterError());
          //Dispatch the event to clear the state of Recommended
        }

        ///
      } catch (e, stackTrace) {
        print('${e.toString()} stacktrace: $stackTrace');
      }
    });
  }
}
