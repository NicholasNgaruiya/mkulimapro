// ignore_for_file: prefer_const_constructors

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mkulimapro/global_resources/controllers/sasa_controller.dart';


class MPScanScreen extends StatelessWidget {
  const MPScanScreen({Key? key, required this.cameras}) : super(key: key);
  final List<CameraDescription> cameras;
  @override
  Widget build(BuildContext context) {
    return FaceScanSf(cameras: cameras,);
  }

}
class FaceScanSf extends StatefulWidget {
  const FaceScanSf({Key? key, required this.cameras}) : super(key: key);
  final List<CameraDescription> cameras;


  @override
  State<FaceScanSf> createState() => _FaceScanSfState();
}

class _FaceScanSfState extends State<FaceScanSf>
    with SingleTickerProviderStateMixin {
  bool initialed = false;
  late CameraController _controller;
  late int _selectedCameraIndex;
  IconData getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        throw ArgumentError('Unknown lens direction');
    }
  }
  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    final onChanged = (CameraDescription? description) {
      if (description == null) {
        return;
      }

      onNewCameraSelected(description);
    };

    if (widget.cameras.isEmpty) {
      return const Text('No camera found');
    } else {
      for (CameraDescription cameraDescription in widget.cameras) {
        toggles.add(
          SizedBox(
            width: 90.0,
            child: RadioListTile<CameraDescription>(
              title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
              groupValue: _controller?.description,
              value: cameraDescription,
              onChanged:
              _controller != null && _controller!.value.isRecordingVideo
                  ? null
                  : onChanged,
            ),
          ),
        );
      }
    }

    return Row(children: toggles);
  }
  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (_controller != null) {
      await _controller!.dispose();
    }
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.ultraHigh,
      // enableAudio: enableAudio,
      // imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) setState(() {});
      if (cameraController.value.hasError) {
        // showInSnackBar(
        //     'Camera error ${cameraController.value.errorDescription}');
      }
    });
    // if (mounted) {
    //   setState(() {});
    //
    // }
    _controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
      //   initialed = true;
        setState(() {});
      //   // _controller.startImageStream((CameraImage image) {
      //   //   print('new image');
      //   // });
      // });
    });
  }
  @override
  void initState() {
    super.initState();
    SasaController.feedbackManagement.verbose('CAMERA initialed', screenContext: toString(), verboseType: 'DEBUG');
    // Initialize the camera controller
    final CameraController cameraController = CameraController(
      widget.cameras[0],
      ResolutionPreset.ultraHigh,
      // enableAudio: enableAudio,
      // imageFormatGroup: ImageFormatGroup.jpeg,
    );
    _controller = cameraController;
    onNewCameraSelected(widget.cameras[0]);
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    initialed = false;
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body:Stack(
        children: [
          Center(
            child: CameraPreview(_controller),
          ),
          // scroll(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              // isScrollControlled: true,
              builder: (BuildContext context) {
                return scroll();
              });
        },

      ),
    );

  }
  scroll() {
    return DraggableScrollableSheet(
        initialChildSize: 1.0,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Maize Disease',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Description: Maize disease is a common issue affecting maize crops, causing symptoms such as leaf spots, wilting, and stunted growth. Proper identification and treatment are crucial for crop health and yield.',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
