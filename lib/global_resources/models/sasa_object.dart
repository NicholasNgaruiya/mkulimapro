
import 'package:mkulimapro/global_resources/controllers/department/security.dart';

import '../controllers/department/data_flow.dart';
class SasaObject {
  const SasaObject({this.uploadStatus=UploadStatus.isNull});
  final UploadStatus uploadStatus;
  final String distinguishingIDKey = '';
  String get distinguishingIDValue => distinguishingIDKey;
  SasaObject fromMap(Map<String, dynamic> data) {
    return const SasaObject();
  }

  Map<String, dynamic>toMap() {
    return {txnStampKey.encode():getTransactionStamp().encode(ignore: true)};
  }
  String get txnStampKey =>'txnStamp';
  final List<String> alphabets = const [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];
  String getTransactionStamp() {
    DateTime now = DateTime.now().toUtc();
    int year = now.year;
    int month =now.month;
    int day = now.day;
    int hour = now.hour;
    int minute = now.minute;
    int second = now.second;
    int millisecond= now.millisecond;
    return getFormattedUTC(year: year, month: month, day: day, hour: hour, minute: minute, seconds: second, millisecond: millisecond);
  }
  String getFormattedUTC({required int year, required int month, required int day, required int hour, required int minute, required int seconds,required int millisecond}) {
    String transactionUTC = '';
    int lim = 26;
    //year [26 year grace period]
    int deltaYear = year - 2023;
    transactionUTC += alphabets[deltaYear];
    //month- max range 12
    int deltaMonth = month - 1;
    transactionUTC += alphabets[deltaMonth];
    //day - max range is 31
    int quotientDayTens = day~/lim;
    int moduloDayOnes = day%lim;
    transactionUTC += alphabets[quotientDayTens];
    transactionUTC += alphabets[moduloDayOnes];
    //hours - max range is 24
    int deltaHours = hour-1;
    transactionUTC += alphabets[deltaHours];
    //minutes - max range is 60
    int quotientMinutesTens = minute~/lim;
    int moduloMinutesOnes = minute%lim;
    transactionUTC += alphabets[quotientMinutesTens];
    transactionUTC += alphabets[moduloMinutesOnes];
    //seconds - max range is 60
    int quotientSecondsTens = seconds~/lim;
    int moduloSecondsOnes = seconds%lim;
    transactionUTC += alphabets[quotientSecondsTens];
    transactionUTC += alphabets[moduloSecondsOnes];
    //milliseconds - max range is 1000
    int quotientMillisecondsHundreds = millisecond~/(lim*lim);
    int moduloMillisecondsHundreds = millisecond%(lim*lim);
    int quotientMillisecondsTens = moduloMillisecondsHundreds~/lim;
    int moduloMillisecondsOnes = moduloMillisecondsHundreds%lim;
    transactionUTC += alphabets[quotientMillisecondsHundreds];
    transactionUTC += alphabets[quotientMillisecondsTens];
    transactionUTC += alphabets[moduloMillisecondsOnes];
    return transactionUTC;
  }
  String getLocalTimeFromFormattedUtc({required String formattedUtc}){
    //[0] - year
    //[1] - month
    //[2,3] - day
    //[4] - hours
    //[5,6] - minutes
    //[7,8] - seconds
    //[9,10,11]
    String localTime = '';
    return '';
  }
  static SasaObject get isNull => const SasaObject();
}