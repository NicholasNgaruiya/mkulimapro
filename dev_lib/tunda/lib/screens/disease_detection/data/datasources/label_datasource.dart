import 'package:tflite_flutter_helper_plus/tflite_flutter_helper_plus.dart';

class LabelDataSource {
  Future<List<String>> loadLabels() async {
    final rawLabels = await FileUtil.loadLabels('assets/labels.txt');
    //debugPrint('Labels: $labels');
    print('Labels: ${rawLabels[0]}');
    return rawLabels;
  }
}
