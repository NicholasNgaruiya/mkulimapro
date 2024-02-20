import 'package:mkulimapro/global_resources/controllers/department/security.dart';
import 'package:mkulimapro/global_resources/models/sasa_object.dart';

import '../controllers/sasa_controller.dart';

class LocalAppVersion extends SasaObject {
  LocalAppVersion({required this.appVersion});
  final int appVersion;

  @override
  Map<String, dynamic> toMap() {
    return {
      'appVersion'.encode(): '$appVersion'.encode(),
    };
  }
  @override
  LocalAppVersion fromMap(Map<String, dynamic> data) {
    return LocalAppVersion(
      appVersion: int.parse((data['appVersion'.encode()] as String).decode()),
    );
  }
  @override
  bool operator ==(Object other) {
    bool value = other is LocalAppVersion &&
        appVersion == other.appVersion;
    if (value)SasaController.feedbackManagement.verbose('this; ${toMap()} vs ${other.toMap()}', screenContext: 'MyOrdersObject', verboseType: 'DEBUG');
    return value;
  }


  @override
  // TODO: implement hashCode
  int get hashCode => appVersion.hashCode;
  int getHashCode(s1,s2) {
    return s1.hashCode^s2.hashCode;
  }
}