import 'package:flutter/material.dart';

import '../../../global_resources/controllers/sasa_controller.dart';
import '../../../model/menu.dart';
import '../../../utils/rive_utils.dart';
import '../Controllers/onboard_page_controller.dart';
import '../Widgets/segment_button.dart';


class MPLoginSignUpTab extends StatefulWidget {
  const MPLoginSignUpTab({super.key, required this.mpOnboardPageController});
  final MPOnboardPageController mpOnboardPageController;
  @override
  State<MPLoginSignUpTab> createState() => _MPLoginSignUpTabState();
}

class _MPLoginSignUpTabState extends State<MPLoginSignUpTab> {
  @override
  void initState() {
    // TODO: implement initState
    SasaController.stateManagement.addStateListener(
        widgetName: SasaController.stateManagement.MP_LOGIN_SIGNUP_TAB,
        onStateChange: (stateTrigger){
          SasaController.feedbackManagement.verbose('onStateChange', screenContext: 'MP_LOGIN_SIGNUP_TAB', verboseType: 'DEBUG');
          setState(() {
            stateTrigger();
          });
        }
    );
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    SasaController.stateManagement.removeStateListener(widgetName: SasaController.stateManagement.MP_LOGIN_SIGNUP_TAB);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      height: 50,
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.25),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Expanded(
            child: SegmentButton(
              title: "Log in",
              isActive: widget.mpOnboardPageController.onboardType==OnboardType.login,
              onPressed: () {
                widget.mpOnboardPageController.mPLoginSignupTabController.changeOnboardTypeState(mpOnboardPageController: widget.mpOnboardPageController);
              },
            ),
          ),
          Expanded(
            child: SegmentButton(
              title: "Sign up",
              isActive: widget.mpOnboardPageController.onboardType==OnboardType.signUp,
              onPressed: () {
                widget.mpOnboardPageController.mPLoginSignupTabController.changeOnboardTypeState(mpOnboardPageController: widget.mpOnboardPageController);
              },
            ),
          ),
        ],
      ),
    );
  }
}
