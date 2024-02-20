import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mkulimapro/screens/onboarding/components/text_input_field.dart';
import 'package:rive/rive.dart';
import 'package:mkulimapro/screens/entryPoint/entry_point.dart';

import '../../../global_resources/controllers/sasa_controller.dart';
import '../Controllers/onboard_page_controller.dart';
import 'error_text_widget.dart';
import 'onboard_button.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
    required this.mpOnboardPageController,
    required this.cameras
  }) : super(key: key);
  final MPOnboardPageController mpOnboardPageController;
  final List<CameraDescription>cameras;
  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;

  late SMITrigger confetti;

  void _onCheckRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    artboard.addController(controller!);
    error = controller.findInput<bool>('Error') as SMITrigger;
    success = controller.findInput<bool>('Check') as SMITrigger;
    reset = controller.findInput<bool>('Reset') as SMITrigger;
  }

  void _onConfettiRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);

    confetti = controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  void singIn(BuildContext context) {
    // confetti.fire();
    if (!widget.mpOnboardPageController.mPOnboardButtonController.isPressed) {
      setState(() {
        isShowConfetti = true;
        isShowLoading = true;
      });
      Future.delayed(
        const Duration(seconds: 1),
            () {
          if (_formKey.currentState!.validate()) {
            widget.mpOnboardPageController.onOnboardPress(
                onSuccess: (userAccount) {
                  success.fire();
                  Future.delayed(
                    const Duration(seconds: 2),
                        () {
                      setState(() {
                        isShowLoading = false;
                      });
                      confetti.fire();
                      // Navigate & hide confetti
                      Future.delayed(const Duration(milliseconds: 300), () {
                        //proceed to next
                        widget.mpOnboardPageController.proceedToHome(
                            context: context,
                            userAccount: userAccount,
                            cameras: widget.cameras
                        );

                      });
                    },
                  );
                },
                onFail:(){
                  error.fire();
                  Future.delayed(
                    const Duration(seconds: 2),
                        () {
                      setState(() {
                        isShowLoading = false;
                      });
                      reset.fire();
                    },
                  );
                },
                mpOnboardPageController: widget.mpOnboardPageController
            );

          } else {
            error.fire();
            Future.delayed(
              const Duration(seconds: 2),
                  () {
                setState(() {
                  isShowLoading = false;
                });
                reset.fire();
              },
            );
          }
        },
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    SasaController.stateManagement.addStateListener(
        widgetName: SasaController.stateManagement.SIGN_IN_FORM,
        onStateChange: (stateTrigger){
          SasaController.feedbackManagement.verbose('onStateChange', screenContext: 'SIGN_IN_FORM', verboseType: 'DEBUG');
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
    SasaController.stateManagement.removeStateListener(widgetName: SasaController.stateManagement.SIGN_IN_FORM);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInputField(
                loginScreenController: widget.mpOnboardPageController,
                labelText: widget.mpOnboardPageController.labelEmail,
                prefixIcon: const Icon(Icons.email,),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  else if (!SasaController.utils.isValidEmail(value)) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
              ),
              if(widget.mpOnboardPageController.onboardType==OnboardType.signUp)
                TextInputField(
                  loginScreenController: widget.mpOnboardPageController,
                  labelText: widget.mpOnboardPageController.labelSirName,
                  prefixIcon: const Icon(Icons.person,),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter your sir name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
              if(widget.mpOnboardPageController.onboardType==OnboardType.signUp)
                TextInputField(
                  loginScreenController: widget.mpOnboardPageController,
                  labelText: widget.mpOnboardPageController.labelFirstName,
                  prefixIcon: const Icon(Icons.person,),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
              TextInputField(
                loginScreenController: widget.mpOnboardPageController,
                labelText: widget.mpOnboardPageController.labelPassword,
                prefixIcon: const Icon(Icons.lock,),
                isPassword: true,
                validator: (value) {
                  String confirmPassword = widget.mpOnboardPageController.inputData[widget.mpOnboardPageController.labelConfirmPassword]??'';
                  if (value!.trim().isEmpty) {
                    return 'Please enter your password';
                  }
                  //todo match passwords here if sign up mode
                  else if (value!.trim()!=confirmPassword&&widget.mpOnboardPageController.onboardType==OnboardType.signUp) {
                    return 'Passwords do not match';
                  }
                  // else if (!SasaController.utils.isStrongPassword(value)&&widget.mpOnboardPageController.onboardType==OnboardType.signUp) {
                  //   return 'Enter a strong password: At least 8 characters, ene uppercase letter, one lowercase letter, one digit, one special character e.g. @,#,\$,%';
                  // }
                  return null;
                },
                keyboardType: TextInputType.visiblePassword,
                textInputAction: widget.mpOnboardPageController.onboardType==OnboardType.signUp?TextInputAction.next:TextInputAction.done,
              ),
              if(widget.mpOnboardPageController.onboardType==OnboardType.signUp)
                TextInputField(
                  loginScreenController: widget.mpOnboardPageController,
                  labelText: widget.mpOnboardPageController.labelConfirmPassword,
                  prefixIcon: const Icon(Icons.lock,),
                  isPassword: true,
                  validator: (value) {
                    String newPassword = widget.mpOnboardPageController.inputData[widget.mpOnboardPageController.labelPassword]??'';
                    if (value!.trim().isEmpty) {
                      return 'Please enter your password';
                    }
                    //todo match passwords here
                    else if (value!.trim()!=newPassword) {
                      return 'Passwords do not match';
                    }
                    // else if (!SasaController.utils.isStrongPassword(value)) {
                    //   return 'Enter a strong password: At least 8 characters, ene uppercase letter, one lowercase letter, one digit, one special character e.g. @,#,\$,%';
                    // }
                    return null;
                  },
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                ),
              const SizedBox(height: 20,),
              ErrorTextWidget(loginScreenController: widget.mpOnboardPageController),

              MPOnboardButton(
                mpOnboardPageController: widget.mpOnboardPageController,
                onPress: () {
                  singIn(context);
                },
              ),
            ],
          ),
        ),
        isShowLoading
            ? CustomPositioned(
                child: RiveAnimation.asset(
                  'assets/RiveAssets/check.riv',
                  fit: BoxFit.cover,
                  onInit: _onCheckRiveInit,
                ),
              )
            : const SizedBox(),
        isShowConfetti
            ? CustomPositioned(
                scale: 6,
                child: RiveAnimation.asset(
                  "assets/RiveAssets/confetti.riv",
                  onInit: _onConfettiRiveInit,
                  fit: BoxFit.cover,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, this.scale = 1, required this.child});

  final double scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 100,
            width: 100,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
