import '../../../global_resources/controllers/sasa_controller.dart';
import 'onboard_page_controller.dart';

class MPLoginSignupTabController {
  void changeOnboardTypeState({required MPOnboardPageController mpOnboardPageController}) {
    SasaController.feedbackManagement.verbose('onboardType: ${mpOnboardPageController.onboardType.toString()}', screenContext: toString(), verboseType: 'DEBUG');

    if (mpOnboardPageController.onboardType==OnboardType.login) {
      SasaController.stateManagement.setStateFromStateListener(
          statefulWidgets: [
            SasaController.stateManagement.MP_LOGIN_SIGNUP_TAB,
            SasaController.stateManagement.MP_ONBOARD_BUTTON,
            SasaController.stateManagement.SIGN_IN_FORM,
          ],
          stateTrigger: (){
            mpOnboardPageController.onboardType=OnboardType.signUp;
            mpOnboardPageController.mPOnboardButtonController.label = 'Sign up';
          }
      );
    }
    else if (mpOnboardPageController.onboardType==OnboardType.signUp){
      SasaController.stateManagement.setStateFromStateListener(
          statefulWidgets: [
            SasaController.stateManagement.MP_LOGIN_SIGNUP_TAB,
            SasaController.stateManagement.MP_ONBOARD_BUTTON,
            SasaController.stateManagement.SIGN_IN_FORM,
          ],
          stateTrigger: (){
            mpOnboardPageController.onboardType=OnboardType.login;
            mpOnboardPageController.mPOnboardButtonController.label = 'Log in';
          }
      );
    }
  }
}