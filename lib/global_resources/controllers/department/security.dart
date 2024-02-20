import 'dart:convert';

extension SecurityDouble on double {
  double encode({bool ignore = false}) => this;
  double decode({bool ignore = false}) => this;
}
extension SecurityInt on int {
  int encode({bool ignore = false}) => this;
  int decode({bool ignore = false}) => this;
}
final List<String> alphabets = const [
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
  'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
];
String getTest(String abc) {
  return abc;
}
int pin = 5738;
String getEncryptedString(String str) {
  List<int> uInt8list = utf8.encode(str);
  String secured = '';
  for (int i=0;i<uInt8list.length;i++) {
    int encoded = getEncodedInt(value: uInt8list[i], pin: pin, index: i);
    int quotientTens = encoded~/26;
    int moduloOnes = encoded%26;
    secured += alphabets[quotientTens];
    secured += alphabets[moduloOnes];
  }
  return secured;
}
String getDecryptedString(String str) {
  String deSecured = '';
  // print('${alphabets[i]}: ${alphabets[i].toLowerCase().codeUnitAt(0)-96}');
  List<int> deSecuredList = List.generate(str.length~/2, (index) => 0);
  for (int i=0;i<str.length;i+=2) {
    int quotientTens = (str[i].toLowerCase().codeUnitAt(0)-96)-1;
    int moduloOnes = (str[i+1].toLowerCase().codeUnitAt(0)-96)-1;
    int encoded = (quotientTens*26)+moduloOnes;
    int decoded = getDecodedInt(value: encoded, pin: pin, index: i~/2);
    deSecuredList[i~/2]=decoded;
  }
  deSecured = utf8.decode(deSecuredList);
  return deSecured;
}
int getEncodedInt({required int value, required int pin, required int index}) {
  int quotient = pin~/256;
  int remainder = pin%256;//max 255

  int randomizer = quotient%21;//max value is 24
  int sum = value + remainder+randomizer;//max value 265;
  int encoded = -1;
  if (sum>255) {
    int delta = sum - 255;
    encoded = -1+ delta;
  }
  else {
    encoded = sum;
  }

  return encoded;
}
int getDecodedInt({required int value, required int pin, required int index}) {
  int quotient = pin~/256;
  int remainder = pin%256;//max 255

  int randomizer = quotient%21;//max value is 24
  int difference = value - remainder-randomizer;//max value -10;
  int decoded = -1;
  if (difference<0) {
    decoded = 256+difference;
  }
  else {
    decoded = difference;
  }
  return decoded;
}
String getEncryptedStringL2(String str) {
  List<int> uInt8list = utf8.encode(str);
  String secured = '';
  for (int i=0;i<uInt8list.length;i++) {
    int encoded = getEncodedIntL2(value: uInt8list[i], pin: pin, index: i, length: uInt8list.length);
    int quotientTens = encoded~/26;
    int moduloOnes = encoded%26;
    secured += alphabets[quotientTens];
    secured += alphabets[moduloOnes];
  }
  return secured;
}
String getDecryptedStringL2(String str) {
  String deSecured = '';
  // print('${alphabets[i]}: ${alphabets[i].toLowerCase().codeUnitAt(0)-96}');
  List<int> deSecuredList = List.generate(str.length~/2, (index) => 0);
  for (int i=0;i<str.length;i+=2) {
    int quotientTens = (str[i].toLowerCase().codeUnitAt(0)-96)-1;
    int moduloOnes = (str[i+1].toLowerCase().codeUnitAt(0)-96)-1;
    int encoded = (quotientTens*26)+moduloOnes;
    int decoded = getDecodedIntL2(value: encoded, pin: pin, index: i~/2, length: (str.length~/2));
    deSecuredList[i~/2]=decoded;
  }
  deSecured = utf8.decode(deSecuredList);
  return deSecured;
}
int getEncodedIntL2({required int value, required int pin, required int index, required int length}) {
  int quotient = pin~/256;
  int remainder = pin%256;//max 255
  // print('index: $index, quotient: $quotient');
  bool isEven = index%2==0;
  int distort = length%(index+1);
  int ran = isEven?((2+distort)%51):((4+distort)%51);
  int randomizer = (quotient%21)+ran;//max value is 70
  // print('randomizer: $randomizer');
  int sum = value + remainder+randomizer;//max value 265;
  int encoded = -1;
  if (sum>255) {
    int delta = sum - 255;
    encoded = -1+ delta;
  }
  else {
    encoded = sum;
  }

  return encoded;
}
int getDecodedIntL2({required int value, required int pin, required int index, required int length}) {
  int quotient = pin~/256;
  int remainder = pin%256;//max 255

  bool isEven = index%2==0;
  int distort = length%(index+1);
  int ran = isEven?((2+distort)%51):((4+distort)%51);
  int randomizer = (quotient%21)+ran;//max value is 70
  int difference = value - remainder-randomizer;//max value -10;
  int decoded = -1;
  if (difference<0) {
    decoded = 256+difference;
  }
  else {
    decoded = difference;
  }
  return decoded;
}
extension SecurityString on String {
  String encode({bool ignore = false}) {
    if (ignore) {
      return this;
    }
    return getEncryptedString(this);
  }
  String decode({bool ignore = false}) {
    if (ignore) {
      return this;
    }
    return getDecryptedString(this);
  }
  String encodeL2() {
    return getEncryptedStringL2(this);
  }
  String decodeL2() {
    return getDecryptedStringL2(this);
  }
}
extension SecurityBool on bool {
  bool encode({bool ignore = false}) => this;
  bool decode({bool ignore = false}) => this;
}