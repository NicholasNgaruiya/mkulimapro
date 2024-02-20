
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mkulimapro/common/color_extension.dart';
import 'package:mkulimapro/global_resources/controllers/department/security.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:url_launcher/url_launcher.dart';

import '../sasa_controller.dart';
import 'data_flow.dart';

class Utils {
  final String screenContext = 'Utils';
  void iterateList(void Function(int index,void Function() onTriggerLoop) onSingleIteration,{int floor=0,int incrementValue=1}) {
    onSingleIteration(floor,(){//() {}// is the onTroop trigger method passed as widget
      iterateList(onSingleIteration,floor: floor+incrementValue);
    });
  }
  Future<void> openUrl(String url) async {
    try {
      var uri = Uri.parse(url);
      if (!await launchUrl(uri)) {
        throw Exception('Could not launch $uri');
      }
    } catch(error,stackTrace) {
      SasaController.feedbackManagement.verbose('error - $error', screenContext: screenContext, verboseType: 'DEBUG');
      SasaController.feedbackManagement.verbose('stacktrace - $stackTrace', screenContext: screenContext, verboseType: 'DEBUG');
    }
  }
  bool isJSON(String str) {
    try {
      jsonDecode(str);
      return true;
    } catch (_) {
      return false;
    }
  }
  String getLocalDateFromUTC({required String utcDateString}) {
    // Parse the UTC date and time string
    DateTime utcDateTime = DateTime.parse('${utcDateString}Z');

    // Convert to the local time zone
    DateTime localDateTime = utcDateTime.toLocal();

    // Format the local date and time
    String localDateString = DateFormat('yyyy-MM-dd').format(localDateTime);
    return localDateString;
  }
  DateTime getLocalDateObjectFromUTC({required String utcDateString}) {
    // Parse the UTC date and time string
    DateTime utcDateTime = DateTime.parse('${utcDateString}Z');

    // Convert to the local time zone
    DateTime localDateTime = utcDateTime.toLocal();

    return localDateTime;
  }
  double getDoubleValue(dynamic value) {
    double val = -1;
    try {
      val = double.parse(value);
    } catch(e) {
      val = value.toDouble();
    }
    return val;
  }
  T getEnumFromString<T extends Enum>({required String string, required List<T> values}) {
    String str = string;
    T tTypeSubject = values.firstWhere((e) {
      SasaController.feedbackManagement.verbose('enum value: $e', screenContext: 'tTypeSubject', verboseType: 'DEBUG');
      return e.toString() == str;
    });
    return tTypeSubject;
  }
  bool isValidEmail(String email) {
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]+');
    return regex.hasMatch(email);
  }
  bool isStrongPassword(String password) {
    String strongPasswordRegex = r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&+=!])(?!.*\s).{8,}$';
    RegExp regex = RegExp(strongPasswordRegex);
    return regex.hasMatch(password);
  }
  final kDefaultPadding = 20.0;
  final kErrorColor = Color(0xFFF03738);
  final kPrimaryColor = Color(0xFF00BF6D);
  Widget getUploadStatusWidget({required UploadStatus status, required BuildContext context}) {
    Color dotColor(UploadStatus status) {
      switch (status) {
        case UploadStatus.uploadFailed:
          return kErrorColor;
          break;
        case UploadStatus.uploadInProgress:
          return Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.1);
          break;
        case UploadStatus.uploadSuccessful:
          return kPrimaryColor;
          break;
        default:
          return Colors.transparent;
      }
    }
    return Container(
      margin: EdgeInsets.only(left: kDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: dotColor(status),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == UploadStatus.uploadFailed ? Icons.close : Icons.file_upload,
        size: 10,
        color: Colors.grey,
      ),
    );
  }
  Map<String,bool> tutorialsKeyMap = {};
  void showTutorial({required GlobalKey key, required BuildContext context, required Widget coachBody,required String identity, required VoidCallback onTargetClick, ContentAlign align = ContentAlign.bottom, required VoidCallback onShowDone}) {
    // Future.delayed(Duration(milliseconds: 100));
    bool allowShowTutorial = tutorialsKeyMap[identity]??false;
    if (!allowShowTutorial) {
      List<TargetFocus> targets = [];
      targets.add(
          TargetFocus(
              identify: identity,
              keyTarget: key,
              contents: [
                TargetContent(
                    align: align,
                    child: Container(
                      child: coachBody,
                    )
                )
              ]
          )
      );
      TutorialCoachMark(
          targets: targets,
          // List<TargetFocus>
          colorShadow: Colors.red,
          // DEFAULT Colors.black
          // alignSkip: Alignment.bottomRight,
          // textSkip: "SKIP",
          // paddingFocus: 10,
          // focusAnimationDuration: Duration(milliseconds: 500),
          // unFocusAnimationDuration: Duration(milliseconds: 500),
          // pulseAnimationDuration: Duration(milliseconds: 500),
          // pulseVariation: Tween(begin: 1.0, end: 0.99),
          // showSkipInLastTarget: true,
          // imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          onFinish: () {
            print("finish");
          },
          onClickTargetWithTapPosition: (target, tapDetails) {
            print("target: $target");
            print("clicked at position local: ${tapDetails
                .localPosition} - global: ${tapDetails.globalPosition}");
          },
          onClickTarget: (target) {
            onTargetClick();
          },
          // onSkip: () {
          //   print("skip");
          // }
      ).show(context: context);
      tutorialsKeyMap[identity] = true;
      onShowDone();
    }
  }
  List<Color> profileBackGroundColours = [
    Colors.black,
    const Color(0xfffe695d),
    const Color(0xff103289),
    Colors.greenAccent,
    Colors.amberAccent,
  ];

}

class CustomPayloadTransformer extends StreamTransformerBase<String, String> {
  int count = 0;
  String buffer = '';
  @override
  Stream<String> bind(Stream<String> stream) {
    //todo- distinguish server unique requests from other gateway requests
    return stream.transform(StreamTransformer.fromHandlers(
      handleData: (String chunk, EventSink<String> sink) {
        SasaController.feedbackManagement.verbose(
            '${++count} | chunk PRE received: $chunk',
            screenContext: 'CustomPayloadTransformer', verboseType: 'DEBUG', persist: true);
        // buffer.write(chunk); // Append the chunk to the buffer
        if (chunk.endsWith('end_dne90'.encodeL2())) {
          buffer += chunk.replaceFirst('end_dne90'.encodeL2(), "");
          // SasaController.feedbackManagement.showMessage(message: 'full payload received');
          // SasaController.feedbackManagement.verbose('full payload received', screenContext: 'CustomPayloadTransformer', verboseType: 'DEBUG');
          sink.add(buffer);
          buffer = '';
        }
        else {
          buffer += chunk;
        }
      },
      handleDone: (EventSink<String> sink) {
        // SasaController.feedbackManagement.showMessage(message: 'handleDone| buffer: $buffer');
        SasaController.feedbackManagement.verbose('handleDone| buffer: $buffer',
            screenContext: 'CustomPayloadTransformer', verboseType: 'DEBUG');
        // Pass the whole payload to the listener
        sink.close();
      },
    ));
  }
}
