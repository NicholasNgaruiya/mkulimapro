
import 'package:mkulimapro/global_resources/controllers/department/security.dart';

import '../../../global_resources/controllers/sasa_controller.dart';
import '../../../global_resources/models/sasa_object.dart';
import '../Controllers/onboard_page_controller.dart';
// payload[crypto.getEncryptedString("userEmail")] = crypto.getEncryptedString("odera.marvinogutu@gmail.com");
// payload[crypto.getEncryptedString("userPassword")] = crypto.getEncryptedStringL2("marvin@123!pio");
// payload[crypto.getEncryptedString("sirName")] = crypto.getEncryptedString("Odera");
// payload[crypto.getEncryptedString("firstName")] = crypto.getEncryptedString("Marvin");
// var transactionStamp = crypto.getTransactionStamp();
// payload[crypto.getEncryptedString("txnStamp")] = crypto.getEncryptedString(transactionStamp);
// payload[crypto.getEncryptedString("projectID")] = crypto.getEncryptedStringL2(projectId);
class Onboard extends SasaObject {
  const Onboard({
    required this.userEmail,
    required this.userPassword,
    this.sirName,
    this.firstName,
    required this.onboardType
  });
  final String userEmail,userPassword;
  final String? sirName, firstName;
  final OnboardType onboardType;

  @override
  String get distinguishingIDKey => 'userEmail'.encode();
  @override
  String get distinguishingIDValue => userEmail.encode();

  @override
  Map<String, dynamic> toMap() {
    if (onboardType==OnboardType.login) {
      return {
        'userEmail'.encode(): userEmail.encode(),
        'userPassword'.encode(): userPassword.encodeL2(),
        'txnStamp'.encode(): getTransactionStamp().encode(),
      };
    } else if (onboardType==OnboardType.signUp) {
      return {
        'userEmail'.encode(): userEmail.encode(),
        'userPassword'.encode(): userPassword.encodeL2(),
        'txnStamp'.encode(): getTransactionStamp().encode(),
        'sirName'.encode(): sirName!.encode(),
        'firstName'.encode(): firstName!.encode(),
      };
    }
    else {
      return {};
    }
  }
  // @override
  // Onboard fromMap(Map<String, dynamic> data) {
  //   return Onboard(
  //     id: (data['id'.encode()] as String).decode(),
  //     knowledgeText: (data['knowledgeText'.encode()] as String).decode(),
  //   );
  // }
  @override
  bool operator ==(Object other) {
    bool value = false;
    if (onboardType==OnboardType.login) {
      value = other is Onboard &&
          userEmail == other.userEmail &&
          userPassword == other.userPassword
      ;
    }
    else if (onboardType==OnboardType.signUp) {
      value = other is Onboard &&
          userEmail == other.userEmail &&
          userPassword == other.userPassword &&
          sirName == other.sirName &&
          firstName == other.firstName;
    }
    if (value)SasaController.feedbackManagement.verbose('match;', screenContext: 'Account', verboseType: 'DEBUG');
    return value;
  }

  @override
// TODO: implement hashCode
  int get hashCode {
   if (onboardType==OnboardType.login) {
     return getHashCode(userEmail, userPassword);
   }
   else if (onboardType==OnboardType.signUp){
     return getHashCode(userEmail, getHashCode(userPassword, getHashCode(sirName, firstName)));
   }
   else {
     return userEmail.hashCode;
   }
  }
  int getHashCode(s1,s2) {
    return s1.hashCode^s2.hashCode;
  }
}