import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../global_resources/controllers/sasa_controller.dart';
import '../../../global_resources/models/user_account.dart';
import '../controller/entry_point_controller.dart';
class MPWidgetSwitcher extends StatefulWidget {
  const MPWidgetSwitcher({super.key, required this.mpEntryPointController,required this.cameras, required this.userAccount});
  final MPEntryPointController mpEntryPointController;
  final List<CameraDescription> cameras;
  final UserAccount userAccount;
  @override
  _MPWidgetSwitcherState createState() => _MPWidgetSwitcherState();
}

class _MPWidgetSwitcherState extends State<MPWidgetSwitcher> {
  @override
  void initState() {
    // TODO: implement initState
    SasaController.stateManagement.addStateListener(
        widgetName: SasaController.stateManagement.MP_WIDGET_SWITCH,
        onStateChange: (stateTrigger){
          SasaController.feedbackManagement.verbose('onStateChange', screenContext: 'MP_WIDGET_SWITCH', verboseType: 'DEBUG');
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
    SasaController.stateManagement.removeStateListener(widgetName: SasaController.stateManagement.MP_WIDGET_SWITCH);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: widget.mpEntryPointController.mPWidgetSwitchController.getWidgetSwitch(
            identifier: widget.mpEntryPointController.mPSideBarController.selectedSideMenu.title,
            cameras: widget.cameras,
          entryPointController: widget.mpEntryPointController,
          userAccount: widget.userAccount
        )
    );
  }

}