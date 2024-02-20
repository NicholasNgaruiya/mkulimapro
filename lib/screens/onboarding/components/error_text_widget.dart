
import 'package:flutter/material.dart';

import '../../../global_resources/controllers/sasa_controller.dart';
import '../Controllers/onboard_page_controller.dart';

class ErrorTextWidget extends StatelessWidget {
  const ErrorTextWidget({Key? key, required this.loginScreenController}) : super(key: key);
  final MPOnboardPageController loginScreenController;

  @override
  Widget build(BuildContext context) {
    return ErrorTextWidgetView(loginScreenController: loginScreenController,);
  }
}
class ErrorTextWidgetView extends StatefulWidget {
  const ErrorTextWidgetView({Key? key, required this.loginScreenController}) : super(key: key);
  final MPOnboardPageController loginScreenController;
  @override
  State<ErrorTextWidgetView> createState() => _ErrorTextWidgetViewState();
}
//todo error on dispose because it clears the latest onboard type
class _ErrorTextWidgetViewState extends State<ErrorTextWidgetView> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.loginScreenController.errorTextWidgetController.initializeAnimation(tickerProvider: this, onboardType: OnboardType.login);
    widget.loginScreenController.errorTextWidgetController.initializeAnimation(tickerProvider: this, onboardType: OnboardType.signUp);
    SasaController.stateManagement.addStateListener(
        widgetName: '${SasaController.stateManagement.ERROR_TEXT_WIDGET}_${OnboardType.login.toString()}',
        onStateChange: (stateTrigger){
          SasaController.feedbackManagement.verbose('onStateChange', screenContext: 'SG_ASPECT_HEADER', verboseType: 'DEBUG');
          setState(() {
            stateTrigger();
          });
        }
    );
    SasaController.stateManagement.addStateListener(
        widgetName: '${SasaController.stateManagement.ERROR_TEXT_WIDGET}_${OnboardType.signUp.toString()}',
        onStateChange: (stateTrigger){
          SasaController.feedbackManagement.verbose('onStateChange', screenContext: 'SG_ASPECT_HEADER', verboseType: 'DEBUG');
          setState(() {
            stateTrigger();
          });
        }
    );
  }
  @override
  void dispose() {
    // SasaController.stateManagement.removeStateListener(widgetName: '${SasaController.stateManagement.ERROR_TEXT_WIDGET}_${widget.loginScreenController.onboardType.toString()}');
    super.dispose();
  }

  @override
  Widget build(BuildContext globalContext) {

    return SizeTransition(
      sizeFactor: widget.loginScreenController.errorTextWidgetController.getAnimation(onboardType: widget.loginScreenController.onboardType),
      // axisAlignment: -1.0,
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(widget.loginScreenController.errorTextWidgetController.errorText,style: TextStyle(color: Colors.red),)
          ),
          SizedBox(height: 10.0,)
        ],
      ),
    );
  }
}