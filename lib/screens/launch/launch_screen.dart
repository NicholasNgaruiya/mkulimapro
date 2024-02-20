
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/color_extension.dart';
import 'components/loader_animation.dart';
import 'controllers/launch_screen_controller.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key, required this.cameras}) : super(key: key);
  final List<CameraDescription>cameras;
  @override
  Widget build(BuildContext context) {
    return LaunchScreenView(cameras: cameras,);
  }
}
class LaunchScreenView extends StatefulWidget {
  const LaunchScreenView({super.key, required this.cameras});
  final List<CameraDescription>cameras;
  @override
  _LaunchScreenViewState createState() => _LaunchScreenViewState();
}

class _LaunchScreenViewState extends State<LaunchScreenView> {
  final launchScreenController= LaunchScreenController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    launchScreenController.init(context: context, cameras: widget.cameras);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Customize the background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.jpg', // Replace 'logo.png' with your actual logo image name
              width: 150, // Adjust the size of your logo image as needed
            ),
            const SizedBox(height: 20), // Add some spacing between logo and loader animation
            LoaderAnimation(), // Show the loader animation widget
          ],
        ),
      ),
    );
  }
}
