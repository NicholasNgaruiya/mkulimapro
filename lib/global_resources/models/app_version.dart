import 'package:mkulimapro/global_resources/controllers/department/security.dart';
import 'package:mkulimapro/global_resources/models/sasa_object.dart';

import '../controllers/sasa_controller.dart';

class AppVersion extends SasaObject {
  const AppVersion({required this.version, required this.minVersion});
  final String version;
  final String minVersion;

  @override
  Map<String, dynamic> toMap() {
    return {
      'version'.encode(): version.encode(),
      'minVersion'.encode(): minVersion.encode(),
    };
  }
  @override
  AppVersion fromMap(Map<String, dynamic> data) {
    return AppVersion(
      version: (data['version'.encode()] as String).decode(),
      minVersion: (data['minVersion'.encode()] as String).decode(),
    );
  }
  @override
  bool operator ==(Object other) {
    bool value = other is AppVersion &&
        version == other.version&&
        minVersion == other.minVersion;
    if (value)SasaController.feedbackManagement.verbose('this; ${toMap()} vs ${other.toMap()}', screenContext: 'MyOrdersObject', verboseType: 'DEBUG');
    return value;
  }


  @override
  // TODO: implement hashCode
  int get hashCode => version.hashCode^minVersion.hashCode;
  int getHashCode(s1,s2) {
    return s1.hashCode^s2.hashCode;
  }
}