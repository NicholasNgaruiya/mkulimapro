import '../../../global_resources/controllers/department/security.dart';
import '../../../global_resources/extensions/bool_extensions.dart';

import '../../../global_resources/controllers/sasa_controller.dart';
import '../../../global_resources/models/sasa_object.dart';

class UserAccount extends SasaObject {
  const UserAccount({required this.userEmail, required this.firstName, this.isVerified=false});
  final String userEmail;
  final String firstName;
  final bool isVerified;

  @override
  String get distinguishingIDKey => 'userEmail'.encode();
  @override
  String get distinguishingIDValue => userEmail.encode();

  @override
  Map<String, dynamic> toMap() {
    return {
      'userEmail'.encode(): userEmail.encode(),
      'firstName'.encode(): firstName.encode(),
      'isVerified'.encode(): '$isVerified'.encode(),
    };
  }
  @override
  UserAccount fromMap(Map<String, dynamic> data) {
    return UserAccount(
        userEmail: (data['userEmail'.encode()] as String).decode(),
      firstName: (data['firstName'.encode()] as String).decode(),
      isVerified: (data['isVerified'.encode()] as String).decode().parseBool(),
    );
  }
  @override
  bool operator ==(Object other) {
    bool value = other is UserAccount &&
        userEmail == other.userEmail &&
        firstName == other.firstName &&
        isVerified == other.isVerified;
    if (value)SasaController.feedbackManagement.verbose('match; ${toMap()} vs ${other.toMap()}', screenContext: 'Account', verboseType: 'DEBUG');
    return value;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => getHashCode(userEmail, getHashCode(firstName,  isVerified));
  int getHashCode(s1,s2) {
    return s1.hashCode^s2.hashCode;
  }
}