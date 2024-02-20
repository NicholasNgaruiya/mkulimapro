import 'package:flutter/material.dart';

import '../../../common/color_extension.dart';
import '../../../global_resources/controllers/sasa_controller.dart';
import '../../../model/menu.dart';
import '../../../utils/rive_utils.dart';
import '../Controllers/onboard_page_controller.dart';
import '../Widgets/segment_button.dart';


class MPSignInGoogle extends StatefulWidget {
  const MPSignInGoogle({super.key, required this.mpOnboardPageController});
  final MPOnboardPageController mpOnboardPageController;
  @override
  State<MPSignInGoogle> createState() => _MPSignInGoogleState();
}

class _MPSignInGoogleState extends State<MPSignInGoogle> {
  @override
  void initState() {
    // TODO: implement initState
    // SasaController.stateManagement.addStateListener(
    //     widgetName: SasaController.stateManagement.MP_SIDE_BAR,
    //     onStateChange: (stateTrigger){
    //       SasaController.feedbackManagement.verbose('onStateChange', screenContext: 'MP_SIDE_BAR', verboseType: 'DEBUG');
    //       setState(() {
    //         stateTrigger();
    //       });
    //     }
    // );
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    // SasaController.stateManagement.removeStateListener(widgetName: SasaController.stateManagement.MP_SIDE_BAR);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.mpOnboardPageController.signInWithGoogle(context: context);
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage("assets/images/google_btn.png"),
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                  color: Colors.white.withOpacity(0.7),
                  blurRadius: 8,
                  offset: const Offset(0, 4))
            ]),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/google.png",
              width: 15,
              height: 15,
              color: TColor.gray,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Sign up with Google",
              style: TextStyle(
                  color: TColor.gray,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
