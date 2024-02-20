import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:tunda/presentation/bloc/fruit_tester_bloc.dart';
import 'package:image/image.dart' as img;
// import 'package:tunda/presentation/fungicides/screens/fungicide_recommendation.dart';
import 'package:tunda/screens/disease_detection/presentation/bloc/fruit_tester_bloc.dart';
import 'package:tunda/screens/disease_detection/presentation/fungicides/screens/fungicide_recommendation.dart';
// import 'package:tunda/presentation/fungicides/widgets/disease_details_widget.dart';

class TundaWidget extends StatefulWidget {
  const TundaWidget({super.key});

  @override
  State<TundaWidget> createState() => _TundaWidgetState();
}

class _TundaWidgetState extends State<TundaWidget> {
  XFile? pickedImage;
  File? selectedImg;
  bool isLoading = false;

  Future<void> _takePicture() async {
    setState(() {
      isLoading = true;
    });

    pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (pickedImage != null) {
      selectedImg = File(pickedImage!.path);

      img.Image? image = img.decodeImage(selectedImg!.readAsBytesSync());
      print(image!.height);
      if (context.mounted) {
        context.read<FruitTesterBloc>().add(LoadData(convertedImage: image));
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _getImageFromGallery() async {
    setState(() {
      isLoading = true;
    });

    pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      selectedImg = File(pickedImage!.path);

      img.Image? image = img.decodeImage(selectedImg!.readAsBytesSync());
      print(image!.height);
      if (context.mounted) {
        context.read<FruitTesterBloc>().add(LoadData(convertedImage: image));
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    width: mediaQuery.width,
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                    ),
                    // elevation: 5,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            height: mediaQuery.height * 0.2,
                            width: mediaQuery.width * 0.5,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: pickedImage == null
                                ? const Center(
                                    child: Text(
                                        'Take a picture from \nthe options below'),
                                  )
                                : Image.file(
                                    selectedImg!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                BlocBuilder<FruitTesterBloc, FruitTesterState>(
                              builder: (context, state) {
                                if (state is FruitTesterLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (state is FruitTesterLoaded) {
                                  double topScore =
                                      double.tryParse(state.topScore) ?? 0.0;
                                  if (topScore < 20.0) {
                                    return const Center(
                                      child: Text(
                                        'Error loading image.\nTake a clearer image.',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                    );
                                  } else {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Disease:',
                                          style: TextStyle(
                                              fontSize: 19,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          ' ${state.topLabel}',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                        Text(
                                          'Accuracy Level: ${state.topScore}%',
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    );
                                  }
                                }
                                if (state is FruitTesterError) {
                                  return const Center(
                                    child: Text(
                                      'Error loading image.\nTake a clearer picture.',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  );
                                }

                                return const SizedBox.shrink();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: _getImageFromGallery,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Upload'),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: _takePicture,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                      child: const Icon(Icons.camera_alt_outlined),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(),
            // const DiseaseDetailsWidget(
            //     diseaseName: 'Blight',
            //     signsAndSymptoms: 'Details',
            //     preventiveMeasures: 'Details'),
            //Widget to display recommended fungicides
            const FungicideRecommendationWidget(),
          ],
        ),
      ),
    );
  }
}
