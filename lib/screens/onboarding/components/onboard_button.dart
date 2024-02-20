import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../common/color_extension.dart';
import '../../../global_resources/controllers/sasa_controller.dart';
import '../Controllers/onboard_page_controller.dart';



class MPOnboardButton extends StatefulWidget {
  const MPOnboardButton({super.key, required this.onPress, required this.mpOnboardPageController});
  final VoidCallback onPress;
  final MPOnboardPageController mpOnboardPageController;
  @override
  State<MPOnboardButton> createState() => _MPOnboardButtonState();
}

class _MPOnboardButtonState extends State<MPOnboardButton> {
  @override
  void initState() {
    // TODO: implement initState
    SasaController.stateManagement.addStateListener(
        widgetName: SasaController.stateManagement.MP_ONBOARD_BUTTON,
        onStateChange: (stateTrigger){
          SasaController.feedbackManagement.verbose('onStateChange', screenContext: 'MP_ONBOARD_BUTTON', verboseType: 'DEBUG');
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
    SasaController.stateManagement.removeStateListener(widgetName: SasaController.stateManagement.MP_ONBOARD_BUTTON);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: ElevatedButton.icon(
        onPressed: widget.onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          minimumSize: const Size(double.infinity, 56),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
        ),
        icon: const Icon(
          CupertinoIcons.arrow_right,
          color: Colors.green,
        ),
        label: !widget.mpOnboardPageController.mPOnboardButtonController.isPressed?
        Text(widget.mpOnboardPageController.mPOnboardButtonController.label)
            :
        const Padding(
          padding: EdgeInsets.all(12.0),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
      ),
    );
  }
}
