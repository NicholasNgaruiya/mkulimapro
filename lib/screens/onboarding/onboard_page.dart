import 'dart:convert';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import '../../common/color_extension.dart';
import '../../global_resources/controllers/sasa_controller.dart';
import '../../global_resources/models/user_account.dart';
import '../entryPoint/entry_point.dart';
import 'Constants/Colors.dart';
import 'Controllers/onboard_page_controller.dart';
import 'Widgets/CustomButton.dart';
import 'Widgets/CustomSphere.dart';
import 'Widgets/GlassMorphismContainer.dart';
import 'Widgets/segment_button.dart';
import 'components/login_signup_tab.dart';
import 'components/sign_in_form.dart';
import 'components/sign_in_google.dart';


class MPOnboardPage extends StatefulWidget {
  MPOnboardPage({super.key, required this.cameras});
  final List<CameraDescription>cameras;
  final mPOnboardPageController = MPOnboardPageController();
  @override
  State<MPOnboardPage> createState() => _MPOnboardPageState();
}

class _MPOnboardPageState extends State<MPOnboardPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // This is called when the app is resumed from the background
      SasaController.feedbackManagement.verbose('App resumed ##########################################', screenContext: toString(), verboseType: 'DEBUG');
      // Add your code here to handle actions when the app is resumed
      initPlatformState();
    }
  }
  Future<void> initPlatformState() async {
    // Get the initial URL when the app is opened using the custom URL scheme
    final initialLink = await getInitialLink();
    if (initialLink != null) {
      var param = Uri.parse(initialLink).queryParameters['param'];
      var jsonMap = jsonDecode(param!);
      var userAccount = const UserAccount(userEmail: '', firstName: '').fromMap(jsonMap);
      SasaController.feedbackManagement.verbose('param: $param', screenContext: toString(), verboseType: 'DEBUG');
      SasaController.feedbackManagement.verbose('userName', screenContext: toString(), verboseType: 'DEBUG');
      SasaController.dataFlow.persistUser(
          userAccount: userAccount,
          onSuccess: (){
            SasaController.routeManagement.routeToScreen(
                forgetHistory: true,
                context: context,
                destination: EntryPoint(userAccount: userAccount, cameras: widget.cameras,)
            );
          });


    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [greenBack, green2Back],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),
        ),
        child: Stack(
          children: [
            // Positioned(
            //   left: -50,
            //   top: height * 0.1,
            //   child: CustomSphere(
            //     height: 200,
            //     width: 200,
            //   ),
            // ),
            // Positioned(
            //   right: -50,
            //   bottom: height * 0.075,
            //   child: CustomSphere(
            //     height: 225,
            //     width: 225,
            //   ),
            // ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Center(
              child: GlassMorphismContainer(
                height: 670,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          const Text(
                            "Mkulima Pro",
                            style: TextStyle(
                              fontSize: 34,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          MPLoginSignUpTab(mpOnboardPageController: widget.mPOnboardPageController,),

                          SignInForm(mpOnboardPageController: widget.mPOnboardPageController, cameras: widget.cameras,),
                          // const Row(
                          //   children: [
                          //     Expanded(
                          //       child: Divider(),
                          //     ),
                          //     Padding(
                          //       padding: EdgeInsets.symmetric(horizontal: 16),
                          //       child: Text(
                          //         "OR",
                          //         style: TextStyle(
                          //           color: Colors.black26,
                          //           fontWeight: FontWeight.w500,
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(child: Divider()),
                          //   ],
                          // ),
                          // const SizedBox(
                          //   height: 24,
                          // ),
                          // MPSignInGoogle(mpOnboardPageController: widget.mPOnboardPageController),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
