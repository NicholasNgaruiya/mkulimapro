
import 'package:flutter/material.dart';

import '../../../global_resources/controllers/sasa_controller.dart';
import '../Controllers/onboard_page_controller.dart';

class TextInputField extends StatelessWidget {
  const TextInputField({Key? key, required this.labelText, required this.prefixIcon, this.isPassword = false,required this.validator,required this.keyboardType, required this.loginScreenController, this.textInputAction}) : super(key: key);
  final String labelText;
  final Icon prefixIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final MPOnboardPageController loginScreenController;

  @override
  Widget build(BuildContext context) {
    return TextInputFieldView(labelText: labelText, prefixIcon: prefixIcon, isPassword: isPassword, validator: validator, keyboardType: keyboardType,loginScreenController: loginScreenController, textInputAction: textInputAction,);
  }
}
class TextInputFieldView extends StatefulWidget {
  const TextInputFieldView({Key? key, required this.labelText, required this.prefixIcon, required this.isPassword,required this.validator,required this.keyboardType, required this.loginScreenController, this.textInputAction}) : super(key: key);
  final String labelText;
  final Icon prefixIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final MPOnboardPageController loginScreenController;
  final TextInputAction? textInputAction;
  @override
  State<TextInputFieldView> createState() => _TextInputFieldViewState();
}

class _TextInputFieldViewState extends State<TextInputFieldView> {
  @override
  void initState() {
    super.initState();
    // SasaController.stateManagement.addStateListener(
    //     widgetName: SasaController.stateManagement.SG_ASPECT_HEADER,
    //     onStateChange: (stateTrigger){
    //       SasaController.feedbackManagement.verbose('onStateChange', screenContext: 'SG_ASPECT_HEADER', verboseType: 'DEBUG');
    //       setState(() {
    //         stateTrigger();
    //       });
    //     }
    // );
  }
  @override
  void dispose() {
    // SasaController.stateManagement.removeStateListener(widgetName: SasaController.stateManagement.SG_ASPECT_HEADER);
    super.dispose();
  }

  @override
  Widget build(BuildContext globalContext) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: TextFormField(
        initialValue: !widget.isPassword?widget.loginScreenController.inputData[widget.labelText]:null,
        obscureText: widget.isPassword,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          hintText: widget.labelText,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: widget.prefixIcon,
          ),
        ),
        onChanged: (value){
          // loginScreenController.email = value!.trim().toLowerCase();
          widget.loginScreenController.inputData[widget.labelText] = value.trim();
          widget.loginScreenController.errorTextWidgetController.hideErrorTextWidget(onboardType: widget.loginScreenController.onboardType);
        },
      ),
    );
  }
}