import 'package:flutter/material.dart';

import '../sasa_controller.dart';

class StateManagement {
  final MP_WIDGET_SWITCH = 'MP_WIDGET_SWITCH';
  // final MP_SIDE_BAR = 'MP_SIDE_BAR';
  final MP_LOGIN_SIGNUP_TAB = 'MP_LOGIN_SIGNUP_TAB';
  final MP_ONBOARD_BUTTON = 'MP_ONBOARD_BUTTON';
  final ERROR_TEXT_WIDGET = 'ERROR_TEXT_WIDGET';
  final SIGN_IN_FORM = 'SIGN_IN_FORM';
  final ENTRY_POINT = 'ENTRY_POINT';
  final MP_SIDE_MENU = 'MP_SIDE_MENU';
  Map<String,void Function(VoidCallback stateTrigger)> widgetStates = {};
  void addStateListener({required String widgetName,required void Function(VoidCallback stateTrigger) onStateChange}) {
    widgetStates[widgetName] = onStateChange;
  }
  void setStateFromStateListener({required List<String> statefulWidgets,required VoidCallback stateTrigger}) {
    for (var name in statefulWidgets) {
      bool isNull = widgetStates[name] == null;
      if (!isNull) {
        widgetStates[name]!(
            stateTrigger
        );
      }
      else {
        //execute state trigger irregardeless
        stateTrigger();
        SasaController.feedbackManagement.verbose(
            'state listener for $name not yet declared',
            screenContext: 'StateManagement', verboseType: 'DEBUG');
      }
    }
  }
  void removeStateListener({required String widgetName}) {
    widgetStates[widgetName] = (stateTrigger){
      //BUT execute state trigger
      stateTrigger();
      SasaController.feedbackManagement.verbose('state listener for $widgetName already removed', screenContext: 'StateManagement', verboseType: 'DEBUG');
    };
  }
}