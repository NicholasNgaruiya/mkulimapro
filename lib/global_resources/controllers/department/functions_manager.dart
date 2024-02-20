
import 'package:flutter/cupertino.dart';

import '../sasa_controller.dart';

class SequenceManager {
  //todo garbage collection
  //todo clear maps after execution for memory optimisation
  final String screenContext = 'SequenceManager';
  Map<String,void Function(VoidCallback onFinish)> mapFunctions = {};
  Map<String,int> mapFunctionsOnQueueType = {};
  int count = -1;
  SequenceManager queue(void Function(VoidCallback onFinish) function) {
    mapFunctions['f${++count}'] = function;
    return this;
  }
  void executeFunctions() {
    SasaController.utils.iterateList((index,onTriggerLoop) {
      SasaController.feedbackManagement.verbose('executing queued function: f$index', screenContext: screenContext, verboseType: 'DEBUG');
      mapFunctions['f$index']!(//onFinish
          (){
            if (index<count) {
              onTriggerLoop();
            }
          }
      );
    });
  }
}
/***
 * to be used in a loop
 * where a function execution can be delayed to be executed in another iteration
 */
class PouchManager {
  final String screenContext = 'PouchManager';
  Map<String,Function({VoidCallback? onFinish})> mapFunctions = {};
  M execute<M>(M Function(void Function<T>(String key, T Function({VoidCallback? onFinish}) savedFunction) onSaveFunction,K Function<K>(String key, {VoidCallback? onFinish}) executeSavedFunction) function) {

    return function(<T>(key,savedFunction){
      mapFunctions[key] = savedFunction;
      SasaController.feedbackManagement.verbose('the function of the key \'$key\' SAVED', screenContext: screenContext, verboseType: 'DEBUG');
    }, <K>(key, {VoidCallback? onFinish}){
      if (mapFunctions[key]!=null) {
        SasaController.feedbackManagement.verbose('EXECUTING the function of the key \'$key\'', screenContext: screenContext, verboseType: 'DEBUG');
        return mapFunctions[key]!(onFinish: onFinish);
      }
      else {
        SasaController.feedbackManagement.verbose('the function of the key \'$key\' does not exist', screenContext: screenContext, verboseType: 'DEBUG');
         throw 'the function of the key \'$key\' does not exist';
      }
    });
  }
  //todo to allow global saving and execution for all


}