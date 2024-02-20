import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:mkulimapro/global_resources/controllers/department/functions_manager.dart';
import 'package:mkulimapro/global_resources/controllers/department/security.dart';
import 'package:mkulimapro/global_resources/controllers/department/utils.dart';

import '../../models/sasa_object.dart';
import '../sasa_controller.dart';
import 'package:http/http.dart' as http;

enum ClientRequestType{guest, allowedUser}
class DataManagement {
  String screenContext = 'DataManagement';
  String guestUrl = "";
  // String endPointUrl = 'https://52d3-197-176-206-91.ngrok-free.app';
  String endPointUrl = 'https://mkulimapro.com';
  Future<void> requestGetCloudData<T extends SasaObject>({required String path,required ValueChanged<ErrorOutput> onNull,required T instance, required void Function(T data, VoidCallback onFinish) onSingleDataSnap, required VoidCallback onDataSnapShot, required VoidCallback onError}) async {
    await requestGetDataCloud(
        path: path,
        requestType: ClientRequestType.allowedUser,
        onResponse: (response) {
          if (response.statusCode == 200) {
            // handle the response here
            var responseBody = json.decode(response.body);
            SasaController.feedbackManagement.verbose(
                'responseBody: $responseBody', screenContext: screenContext,
                verboseType: 'DEBUG');
            int statusCode = responseBody['statusCode'];
            if (statusCode == 200) {
              //convert payload to object here
              var payload = responseBody['payload'];
              SasaController.feedbackManagement.verbose(
                  'payload: $payload', screenContext: screenContext,
                  verboseType: 'DEBUG');
              if ((payload).isNotEmpty) {
                SasaController.utils.iterateList((index, onTriggerLoop) {
                  var singlePayload = payload[index];
                  SasaController.feedbackManagement.verbose(
                      '$index | singlePayload: $singlePayload',
                      screenContext: screenContext,
                      verboseType: 'DEBUG');
                  onSingleDataSnap(instance.fromMap(singlePayload) as T, () {
                    if (index + 1 == payload.length) {
                      onDataSnapShot();
                    }
                    else {
                      onTriggerLoop();
                    }
                  });
                });
              } else {
                onDataSnapShot();
              }
            }
            else {
              onError();
            }
          }
          else {
            onError();
          }
        },
        onError: onError
    );

  }
  Future<void> requestGetDataCloud({required String path,Map<String,String>? headersMap, required ClientRequestType requestType, required ValueChanged<http.Response> onResponse, required VoidCallback onError}) async {
    final client = RetryClient(http.Client());
    try {
      final url = Uri.parse('$endPointUrl$path');
      SasaObject sasaObject = const SasaObject();
      String requestIdentifier = '';
      if (requestType == ClientRequestType.guest) {
        requestIdentifier = 'MT';
      }
      else if (requestType == ClientRequestType.allowedUser) {
        requestIdentifier = 'AU';
      }
      var auth = '${requestIdentifier}_${sasaObject.getTransactionStamp()}'
          .encodeL2();
      final headers = headersMap??<String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': auth,
        // add any other headers that you need
      };
      final response = await client.get(
        url,
        headers: headers,
      );
      onResponse(response);

    } catch (error,stackTrace) {
      SasaController.feedbackManagement.verbose(
          'get error: $error\nstackTrace: $stackTrace', screenContext: screenContext,
          verboseType: 'DEBUG');
      onError();
    } finally {
      // client.close();
    }

  }
  // Map<String,http.Client> aliveConnections = {};
  Map<String,http.Client> aliveConnections = {};
  // Map<String,Dio> aliveConnections = {};
  int getConnectionsCounter = 0;
  int postConnectionsCounter = 0;
  // void requestStreamDataFromGetRequest({required String path, required ClientRequestType requestType, required void Function(String sseEvent,http.Client hClient) onEvent}) async {
  //   SasaController.feedbackManagement.verbose('requestStreamDataFromGetRequest', screenContext: screenContext, verboseType: 'DEBUG',persist: true);
  //   final url = Uri.parse('$endPointUrl$path');
  //   SasaObject sasaObject = const SasaObject();
  //   String requestIdentifier = '';
  //   if (requestType==ClientRequestType.guest) {
  //     requestIdentifier = 'MT';
  //   }
  //   else if (requestType==ClientRequestType.allowedUser) {
  //     requestIdentifier = 'AU';
  //   }
  //   var auth = '${requestIdentifier}_${sasaObject.getTransactionStamp()}'.encodeL2();
  //   final headers = <String, String>{
  //     // 'Content-Type': 'application/json; charset=UTF-8',
  //     'Authorization': auth,
  //     'Accept':'text/event-stream',
  //     'Cache-Control': 'no-cache'
  //     // add any other headers that you need
  //   };
  //   final client = http.Client();
  //   aliveConnections['a${getConnectionsCounter++}'] = client;
  //
  //   final request = http.Request('GET',url);
  //   request.headers.addAll(headers);
  //
  //   // final response = await client.send(request);
  //   try {
  //     final response = await client.send(request);
  //
  //     response.stream.transform(utf8.decoder).transform(
  //         CustomPayloadTransformer()).listen((event) {
  //       onEvent(event, client);
  //     });
  //   }
  //   catch(error,stackTrace) {
  //     SasaController.feedbackManagement.verbose('$error $stackTrace', screenContext: screenContext, verboseType: 'DEBUG',persist: true);
  //   }
  // }
  n() {}
  // firebase compliant

  Future<void> requestStreamDataFromGetRequest({required String contextKey,required String path, required ClientRequestType requestType, required void Function(int requestNumber,bool isValidResponse, Map sseEvent, void Function() onFinish) onEvent, required bool isSubsequentRequest}) async {
    initNewConnectionsTrigger[contextKey] = onEvent;
    SasaController.feedbackManagement.verbose('requestStreamDataFromGetRequest', screenContext: screenContext, verboseType: 'DEBUG');
    await requestGetDataCloud(
        path: path,
        requestType: requestType,
        onResponse: (response){
          if (response.statusCode == 200) {
            // handle the response here
            var responseBody = json.decode(response.body);
            int statusCode = responseBody['statusCode'];
            SasaController.feedbackManagement.verbose(
                'responseBody: $responseBody', screenContext: screenContext,
                verboseType: 'DEBUG');
            if (statusCode == 200) {
              //convert payload to object here
              var events = responseBody['events'];
              SasaController.feedbackManagement.verbose(
                  'events: $events', screenContext: screenContext,
                  verboseType: 'DEBUG');
              SasaController.utils.iterateList((index, onTriggerLoop) {
                var event = events[index];
                SasaController.feedbackManagement.verbose(
                    '$index | event: $event', screenContext: screenContext,
                    verboseType: 'DEBUG');
                var requestNumber = event['requestNumber'];
                SasaController.feedbackManagement.verbose(
                    'requestNumber: $requestNumber', screenContext: screenContext,
                    verboseType: 'DEBUG');
                SasaController.feedbackManagement.verbose(
                    'isSubsequentRequest: $isSubsequentRequest', screenContext: screenContext,
                    verboseType: 'DEBUG');
                if (requestNumber==1&&isSubsequentRequest) {
                  onEvent(requestNumber+1,true,event,(){
                    if (index+1==events.length) {
                    }
                    else {
                      onTriggerLoop();
                    }
                  });
                }
                else {
                  onEvent(requestNumber,true,event,(){
                    if (index+1==events.length) {
                    }
                    else {
                      onTriggerLoop();
                    }
                  });
                }
              });
            }
            else {
              SasaController.feedbackManagement.verbose('onError | requestStreamDataFromGetRequest', screenContext: screenContext, verboseType: 'DEBUG');
              onEvent(0,false,{},(){});
            }
          }
          else {
            SasaController.feedbackManagement.verbose('onError | requestStreamDataFromGetRequest', screenContext: screenContext, verboseType: 'DEBUG');
            onEvent(0,false,{},(){});
          }
        },
        onError: () {
          SasaController.feedbackManagement.verbose('onError | requestStreamDataFromGetRequest', screenContext: screenContext, verboseType: 'DEBUG');
          onEvent(0,false,{},(){});
        }
    );
  }
  k(){}
  // void requestStreamFromPostRequest<T extends SasaObject>({required String path, required ClientRequestType requestType, required T instance, required void Function(String sseEvent,http.Client hClient) onEvent}) async {
  //   SasaController.feedbackManagement.verbose('requestStreamFromPostRequest<$T>', screenContext: screenContext, verboseType: 'DEBUG');
  //   final url = Uri.parse('$endPointUrl$path');
  //   SasaObject sasaObject = const SasaObject();
  //   String requestIdentifier = '';
  //   if (requestType==ClientRequestType.guest) {
  //     requestIdentifier = 'MT';
  //   }
  //   else if (requestType==ClientRequestType.allowedUser) {
  //     requestIdentifier = 'AU';
  //   }
  //   var auth = '${requestIdentifier}_${sasaObject.getTransactionStamp()}'.encodeL2();
  //   final headers = <String, String>{
  //     // 'Content-Type': 'application/json; charset=UTF-8',
  //     'Authorization': auth,
  //     'Accept':'text/event-stream',
  //     'Cache-Control': 'no-cache'
  //     // add any other headers that you need
  //   };
  //   final client = http.Client();
  //   aliveConnections['a${postConnectionsCounter++}'] = client;
  //   final requestBody = instance.toMap();
  //   final requestBodyJson = json.encode(requestBody);
  //
  //   final request = http.Request('POST',url);
  //   request.headers.addAll(headers);
  //   request.body = requestBodyJson;
  //
  //   try {
  //     final response = await client.send(request);
  //
  //     response.stream.transform(utf8.decoder).transform(
  //         CustomPayloadTransformer()).listen((event) {
  //       // response.stream.transform(utf8.decoder).transform(SseEventTransformer()).listen((event) {
  //       onEvent(event, client);
  //     });
  //   }
  //   catch(error,stackTrace) {
  //     SasaController.feedbackManagement.verbose('$error $stackTrace', screenContext: screenContext, verboseType: 'DEBUG',persist: true);
  //   }
  //
  // }
  o(){}
  // firebase compliant
  void requestStreamFromPostRequest<T extends SasaObject>({required String path, required ClientRequestType requestType, required T instance, required void Function(int requestNumber,bool isValidResponse, Map sseEvent, void Function() onFinish) onEvent}) async {
    SasaController.feedbackManagement.verbose('requestStreamFromPostRequest<$T>', screenContext: screenContext, verboseType: 'DEBUG');
    requestPostDataCloud<T>(
        path: path,
        requestType: requestType,
        instance: instance,
        onResponse: (response){
          if (response.statusCode == 200) {
            // handle the response here
            var responseBody = json.decode(response.body);
            int statusCode = responseBody['statusCode'];
            SasaController.feedbackManagement.verbose(
                'responseBody: $responseBody', screenContext: screenContext,
                verboseType: 'DEBUG');
            if (statusCode == 200) {
              //convert payload to object here
              var events = responseBody['events'];
              SasaController.feedbackManagement.verbose(
                  'events: $events', screenContext: screenContext,
                  verboseType: 'DEBUG');
              SasaController.utils.iterateList((index, onTriggerLoop) {
                var event = events[index];
                SasaController.feedbackManagement.verbose(
                    '$index | event: $event', screenContext: screenContext,
                    verboseType: 'DEBUG');
                var requestNumber = event['requestNumber'];
                SasaController.feedbackManagement.verbose(
                    'requestNumber: $requestNumber', screenContext: screenContext,
                    verboseType: 'DEBUG');
                onEvent(requestNumber,true,event,(){
                  if (index+1==events.length) {
                  }
                  else {
                    onTriggerLoop();
                  }
                });
              });
            }
            else {
              SasaController.feedbackManagement.verbose('onError | requestStreamDataFromGetRequest', screenContext: screenContext, verboseType: 'DEBUG');
              onEvent(0,false,{},(){});
            }
          }
          else {
            SasaController.feedbackManagement.verbose('onError | requestStreamDataFromGetRequest', screenContext: screenContext, verboseType: 'DEBUG');
            onEvent(0,false,{},(){});
          }
        },
        onError: () {
          SasaController.feedbackManagement.verbose('onError | requestStreamFromPostRequest', screenContext: screenContext, verboseType: 'DEBUG');
          onEvent(0,false,{},(){});
        }
    );
  }

  void requestPostDataCloud<T extends SasaObject>({required String path, required ClientRequestType requestType, required T instance, required ValueChanged<http.Response> onResponse, required VoidCallback onError}) async {
    final client = http.Client();
    try {
      final url = Uri.parse('$endPointUrl$path');
      SasaObject sasaObject = const SasaObject();
      String requestIdentifier = '';
      if (requestType == ClientRequestType.guest) {
        requestIdentifier = 'MT';
      }
      else if (requestType == ClientRequestType.allowedUser) {
        requestIdentifier = 'AU';
      }
      var auth = '${requestIdentifier}_${sasaObject.getTransactionStamp()}'
          .encodeL2();
      SasaController.feedbackManagement.verbose(
          'auth: $auth', screenContext: screenContext, verboseType: 'DEBUG');
      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': auth,
        // add any other headers that you need
      };
      final response = await client.post(
          url, headers: headers, body: jsonEncode(instance.toMap()));
      var responseBody = json.decode(response.body);
      SasaController.feedbackManagement.verbose(
          'responseBody: $responseBody', screenContext: screenContext,
          verboseType: 'DEBUG');
      onResponse(response);
    } catch (error,stackTrace) {
      SasaController.feedbackManagement.verbose(
          'post error: $error\nstackTrace: $stackTrace\nrequest payload: ${instance.toMap()}', screenContext: screenContext,
          verboseType: 'DEBUG');
      onError();
    }
    finally {
      client.close();
    }
  }
  void requestPostBulkDataCloud<T extends SasaObject>({required String path, required ClientRequestType requestType, required List<T> instances, required ValueChanged<http.Response> onResponse, required VoidCallback onError}) async {
    final client = RetryClient(http.Client());
    var listOfMaps = instances.map((object) => object.toMap()).toList();
    try {
      final url = Uri.parse('$endPointUrl$path');
      SasaObject sasaObject = const SasaObject();
      String requestIdentifier = '';
      if (requestType == ClientRequestType.guest) {
        requestIdentifier = 'MT';
      }
      else if (requestType == ClientRequestType.allowedUser) {
        requestIdentifier = 'AU';
      }
      var auth = '${requestIdentifier}_${sasaObject.getTransactionStamp()}'
          .encodeL2();
      SasaController.feedbackManagement.verbose(
          'auth: $auth', screenContext: screenContext, verboseType: 'DEBUG');
      final headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': auth,
        // add any other headers that you need
      };

      final response = await client.post(
          url, headers: headers, body: jsonEncode(listOfMaps));
      var responseBody = json.decode(response.body);
      SasaController.feedbackManagement.verbose(
          'responseBody: $responseBody', screenContext: screenContext,
          verboseType: 'DEBUG');
      onResponse(response);
    } catch (error,stackTrace) {
      SasaController.feedbackManagement.verbose(
          'post error: $error\nstackTrace: $stackTrace\nrequest payload: $listOfMaps', screenContext: screenContext,
          verboseType: 'DEBUG');
      onError();
    }
    finally {
      client.close();
    }
  }
  void requestGetLocalData<T extends SasaObject>({required String databaseName,required String tableName,required ValueChanged<ErrorOutput> onNull,required T instance, required void Function(T data, VoidCallback onFinish) onSingleDataSnap, required void Function(List<T>) onDataSnapShot, String? where, List<dynamic>? whereArgs,List<String>? columns,String? orderBy, int? limit}) async {
    SasaController.feedbackManagement.verbose('requestGetLocalDataSqlite<${instance.toString()}>', screenContext: screenContext, verboseType: 'DEBUG');
    await SasaController.sqlManagement.getData(
        databaseName:databaseName,
        tableName: tableName,
        columns: columns,
        where: where,
        whereArgs: whereArgs,
        orderBy: orderBy,
        limit: limit,
        onDataSnapShot: (dataSnapShot) async {
          var maps = dataSnapShot;
          SasaController.feedbackManagement.verbose('${instance.toString()}-stored data: \n$maps|${maps.length}', screenContext: screenContext, verboseType: 'DEBUG');

          if (maps.isEmpty) {
            SasaController.feedbackManagement.verbose('agrisasaObjects.isEmpty', screenContext: screenContext, verboseType: 'DEBUG');
            var nullBody = ErrorOutput();
            nullBody.emptyList = true;
            onNull(nullBody);
          }
          else {
            List<T> snaps = [];
            SasaController.utils.iterateList((index,onTriggerLoop) {
              SasaController.feedbackManagement.verbose('----------------', screenContext: screenContext, verboseType: 'DEBUG');
              SasaController.feedbackManagement.verbose('alpha: $index', screenContext: screenContext, verboseType: 'DEBUG');
              var singleSnap= instance.fromMap(maps[index]) as T;
              snaps.add(singleSnap);
              onSingleDataSnap(singleSnap, (){
                SasaController.feedbackManagement.verbose('sqlId: ${maps[index]['sqlId']},isInt;${maps[index]['sqlId'] is int}', screenContext: screenContext, verboseType: 'DEBUG');
                SasaController.feedbackManagement.verbose('onfinish: $index', screenContext: screenContext, verboseType: 'DEBUG');
                if (index<maps.length) {
                  if (index+1==maps.length) {
                    onDataSnapShot(snaps);
                  } else {
                    onTriggerLoop();
                  }
                }
              });
              SasaController.feedbackManagement.verbose('omega: $index', screenContext: screenContext, verboseType: 'DEBUG');
            });
          }
          // else {
          //   onDataSnapShot();
          // }
        },
        onNull: () {
          //error1: due to non existent table
          SasaController.feedbackManagement.verbose('getStoredData error', screenContext: screenContext, verboseType: 'DEBUG');
          var nullBody = ErrorOutput();
          nullBody.nonExistentTable = true;
          onNull(nullBody);
        }
    );


  }
  //todo redundant
  void querySpecificData<T extends SasaObject>({required String databaseName,required String tableName,required ValueChanged<ErrorOutput> onNull,required T instance, required void Function(T data, VoidCallback onFinish) onSingleDataSnap, required VoidCallback onDataSnapShot, String? distinguishingKey,String? distinguishingValue}) async {
    await SasaController.sqlManagement.getSpecificData(
      databaseName: databaseName,
      tableName: tableName,
      columnsToSelect: instance.toMap().keys.toList(),
      distinguishingIDKey: distinguishingKey??instance.distinguishingIDKey,
      distinguishingIDValue: distinguishingValue??instance.distinguishingIDValue,
      onDataSnapShot: (dataSnapShot) async {
        var maps = dataSnapShot;
        SasaController.feedbackManagement.verbose('specific stored data: \n$maps|${maps.length}', screenContext: screenContext, verboseType: 'DEBUG');
        if (maps.isEmpty) {
          SasaController.feedbackManagement.verbose('agrisasaObjects.isEmpty', screenContext: screenContext, verboseType: 'DEBUG');
          var nullBody = ErrorOutput();
          nullBody.emptyList = true;
          onNull(nullBody);
        }
        else {
          SasaController.utils.iterateList((index,onTriggerLoop) {
            SasaController.feedbackManagement.verbose('----------------', screenContext: screenContext, verboseType: 'DEBUG');
            SasaController.feedbackManagement.verbose('alpha: $index', screenContext: screenContext, verboseType: 'DEBUG');
            onSingleDataSnap(instance.fromMap(maps[index]) as T, (){
              SasaController.feedbackManagement.verbose('onfinish: $index', screenContext: screenContext, verboseType: 'DEBUG');
              if (index<maps.length) {
                if (index+1==maps.length) {
                  onDataSnapShot();
                } else {
                  onTriggerLoop();
                }
              }
            });
            SasaController.feedbackManagement.verbose('omega: $index', screenContext: screenContext, verboseType: 'DEBUG');
          });
        }
      },
      onNull: () {
        //error1: due to non existent table
        SasaController.feedbackManagement.verbose('getStoredData error nonExistentTable', screenContext: screenContext, verboseType: 'DEBUG');
        var nullBody = ErrorOutput();
        nullBody.nonExistentTable = true;
        onNull(nullBody);
      },
    );
  }
  void requestPostLocalData<T extends SasaObject>({required String databaseName,required String tableName,required T instance, required List<T> sasaObjectsToAdd, required VoidCallback onSuccess}) async {
    await SasaController.sqlManagement.createTableIfNotExists(
        databaseName: databaseName,
        tableName: tableName,
        columnParameters: getColumnParameters<T>(agrisasaObject: instance)
    );
    // SasaController.feedbackManagement.verbose('sqlTableColumns: ${getColumnParameters<T>(agrisasaObject: instance)}', screenContext: screenContext, verboseType: 'DEBUG');
    for (var sasaObjects in sasaObjectsToAdd) {
      SasaController.feedbackManagement.verbose('adding: ${sasaObjects.toMap()}', screenContext: screenContext, verboseType: 'DEBUG');
      await SasaController.sqlManagement.insert(
          databaseName: databaseName,
          tableName: tableName,
          map: sasaObjects.toMap(),
          onAdd: (id) {
            // SasaController.feedbackManagement.verbose('Sqlite data insert: $id', screenContext: screenContext, verboseType: 'DEBUG');
          }
      );
    }
    onSuccess();
  }
  void requestUpdateLocalData<T extends SasaObject>({required String databaseName, required String tableName,required T preUpdateInstance,required T updateInstance, required VoidCallback onSuccess,bool createNewEntryOnNull=false}) async {
    await SasaController.sqlManagement.updateSqlData(
        databaseName: databaseName,
        tableName: tableName,
        preUpdateMap: preUpdateInstance.toMap(),
        updateMap: updateInstance.toMap(),
        distinguishingIDKey: updateInstance.distinguishingIDKey,
        distinguishingIDValue: updateInstance.distinguishingIDValue,
        onSuccess: onSuccess,
        createNewEntryOnNull: createNewEntryOnNull,
        onNull: (){
          SasaController.feedbackManagement.verbose('FAIL requestUpdateLocalData', screenContext: screenContext, verboseType: 'DEBUG');
        }
    );
  }
  Future<void> requestDeleteSqlDatabase({required String databaseName}) async{
    await SasaController.sqlManagement.deleteSqlDatabase(databaseName: databaseName);
    SasaController.sqlManagement.resetSqlDb();
  }

  // void requestHybridGetData<T extends SasaObject>({required String databaseName,required String path,required String tableName,required ValueChanged<ErrorOutput> onNull,required T instance, required void Function(T data, VoidCallback onFinish) onSingleDataSnapCloud, required void Function(T data, VoidCallback onFinish) onSingleDataSnap, required VoidCallback onDataSnapShot, String? where, List<String>? whereArgs,String? orderBy, int? limit,bool populateLocalOnCloudData = true,required void Function(int streamRequestNumber, Map<String,dynamic> dataSnap, ValueChanged<bool> onValidate) onRequestValidateOnNewPayload, required void Function(T dataSnap) onNotifyNewUpdates, bool isSubsequentRequest = false, required VoidCallback onRequestInitNewConnection}) {
  //   //todo - check local
  //   //todo - if exists populate and also check cloud
  //   //todo - else check cloud
  //   //todo - if cloud exist - populate local (unless !populateLocalOnCloudData)- read
  //   //todo - else - network error
  //
  //   //todo use a pouch manager here
  //   const cloudRequestKey = 'cloudRequestKey';
  //   const sheetPayloadInsertKey = 'sheetPayloadInsertKey';
  //   const sheetPayloadBodyKey = 'sheetPayloadBodyKey';
  //   PouchManager().execute<void>((onSaveFunction, executeSavedFunction) {
  //     onSaveFunction<void>(cloudRequestKey,({VoidCallback? onFinish}){
  //       requestStreamDataFromGetRequest(
  //           path: path,
  //           requestType: ClientRequestType.allowedUser,
  //           onEvent: (event,client){
  //             SasaController.feedbackManagement.verbose('event: $event\n_\n', screenContext: screenContext, verboseType: 'DEBUG');
  //             bool isValidJSON = SasaController.utils.isJSON(event);
  //             if (isValidJSON) {
  //               var responseMap = jsonDecode(event);
  //               int statusCode = responseMap['statusCode'];
  //               if (statusCode==200) {
  //                 int requestNumber = responseMap['requestNumber'];
  //                 SasaController.feedbackManagement.verbose('analyzing request ids | requestNumber: $requestNumber', screenContext: screenContext, verboseType: 'DEBUG');
  //
  //                 if (requestNumber==1||requestNumber==2||requestNumber==4) {
  //                   onSaveFunction<List<dynamic>>(sheetPayloadBodyKey,({VoidCallback? onFinish}){
  //                     return responseMap['payload'];
  //                   });
  //                   onSaveFunction<void>(sheetPayloadInsertKey,({VoidCallback? onFinish}){
  //                     var payload = executeSavedFunction<List<dynamic>>(sheetPayloadBodyKey);
  //                     SasaController.feedbackManagement.verbose(
  //                         'payload: $payload', screenContext: screenContext,
  //                         verboseType: 'DEBUG');
  //                     SasaController.utils.iterateList((index, onTriggerLoop) {
  //                       var singlePayload = payload[index];
  //                       SasaController.feedbackManagement.verbose(
  //                           '$index | singlePayload: $singlePayload', screenContext: screenContext,
  //                           verboseType: 'DEBUG');
  //                       //
  //                       if (populateLocalOnCloudData) {
  //                         onRequestValidateOnNewPayload(requestNumber,singlePayload,(isValidated){
  //                           var singleDataSnap = instance.fromMap(singlePayload) as T;
  //                           if (isValidated){
  //                             requestPostLocalData<T>(
  //                                 databaseName: databaseName,
  //                                 tableName: tableName,
  //                                 instance: instance,
  //                                 sasaObjectsToAdd: [singleDataSnap],
  //                                 onSuccess: () {
  //                                   onSingleDataSnapCloud(singleDataSnap,(){
  //                                     if (requestNumber==2) {
  //                                       onNotifyNewUpdates(singleDataSnap);
  //                                     }
  //                                     if (index+1==payload.length) {
  //                                       //redundant because onDataSnapshot is only necessary during initial ui builds
  //                                       //and  request data cloud is only called for ui updates
  //                                     }
  //                                     else {
  //                                       onTriggerLoop();
  //                                     }
  //                                   });
  //                                 }
  //                             );
  //                           }
  //                           else {
  //                             SasaController.feedbackManagement.verbose('isValidated FALSE due to duplicates', screenContext: screenContext, verboseType: 'DEBUG');
  //                             /***
  //                              * for now we don't expect duplicates to intermingle with non duplicates in a payload
  //                              */
  //                             if (index+1==payload.length) {
  //                               //redundant because onDataSnapshot is only necessary during initial ui builds
  //                               //and  request data cloud is only called for ui updates
  //                             }
  //                             else {
  //                               onTriggerLoop();
  //                             }
  //                           }
  //                         });
  //                       }
  //                       else {
  //                         var singleDataSnap = instance.fromMap(singlePayload) as T;
  //                         onSingleDataSnapCloud(singleDataSnap,(){
  //                           if (index+1==payload.length) {
  //                             //redundant because onDataSnapshot is only necessary during initial ui builds
  //                             //and  request data cloud is only called for ui updates
  //                           }
  //                           else {
  //                             onTriggerLoop();
  //                           }
  //                         });
  //                       }
  //
  //                     });
  //                   });
  //                 }
  //                 if (requestNumber==0) {
  //                   //this is ping pong to keep the connection alive
  //                 }
  //                 else if (requestNumber==1) {
  //                   //this is for getting new updates initially
  //                   executeSavedFunction<void>(sheetPayloadInsertKey);
  //                 }
  //                 else if (requestNumber==2) {
  //                   //this is for new updates from the listener
  //                   //expecting singular data
  //                   //data has to be vetted first
  //                   executeSavedFunction<void>(sheetPayloadInsertKey);
  //                 }
  //                 else if (requestNumber==3) {
  //                   //this is a notice that the connection is closing,
  //                   //theres need to restart a new connection from the top level
  //                   SasaController.feedbackManagement.verbose('requesting a new connection from the top level', screenContext: screenContext, verboseType: 'DEBUG');
  //                   onRequestInitNewConnection();
  //                 }
  //                 else if (requestNumber==4) {
  //                   //this is for new updates from the listener
  //                   //expecting singular data
  //                   //data has to be vetted first
  //                   executeSavedFunction<void>(sheetPayloadInsertKey);
  //                 }
  //               }
  //               else {
  //                 //todo fail here
  //                 //Error declaration redundant since its already fired in the ui
  //               }
  //             }
  //             else {
  //               //todo fail here
  //               SasaController.feedbackManagement.verbose('event NOT a valid json', screenContext: screenContext, verboseType: 'DEBUG');
  //               //Error declaration redundant since its already fired in the ui
  //             }
  //           }
  //       );
  //     });
  //     if (!isSubsequentRequest) {
  //       requestGetLocalData<T>(
  //           databaseName: databaseName,
  //           tableName: tableName,
  //           instance: instance,
  //           where: where,
  //           whereArgs: whereArgs,
  //           orderBy: orderBy,
  //           limit: limit,
  //           onNull: (errorOutput) {
  //             //check cloud here
  //             onNull(errorOutput); //to set the ui to empty
  //             executeSavedFunction<void>(cloudRequestKey);
  //           },
  //           onSingleDataSnap: onSingleDataSnap,
  //           onDataSnapShot: () {
  //             onDataSnapShot(); //to set the ui with locally stored data
  //             //now check if there are new posts made to the cloud
  //             executeSavedFunction<void>(cloudRequestKey);
  //           }
  //       );
  //     } else {
  //       executeSavedFunction<void>(cloudRequestKey);
  //     }
  //   });
  // }

  int initConnectionCounter = 0;
  Map<String,void Function(int requestNumber,bool isValidResponse, Map sseEvent, void Function() onFinish)> initNewConnectionsTrigger = {};
  Map<String,Timer> timers= {};
  Map<String,bool> timersInit= {};
  int timerCounter = 0;
  //todo add key from high level
  void triggerConnectionClosure({required String contextKey}) async {
    // SasaController.feedbackManagement.verbose('triggerConnectionClosure $contextKey| size: ${initNewConnectionsTrigger.length}', screenContext: screenContext, verboseType: 'DEBUG');
    // await Future.delayed(const Duration(milliseconds: 1750));
    // initNewConnectionsTrigger[contextKey]!(3, true, {}, () {});
  }
  //firebase compliant
  var br = "";
  void requestHybridGetData<T extends SasaObject>({required String contextKey,required String databaseName,required String path,required String tableName,required ValueChanged<ErrorOutput> onNull,required T instance, required void Function(T data, VoidCallback onFinish) onSingleDataSnapCloud, required void Function(T data, VoidCallback onFinish) onSingleDataSnap, required VoidCallback onDataSnapShot, String? where, List<String>? whereArgs,String? orderBy, int? limit,bool populateLocalOnCloudData = true,required void Function(int streamRequestNumber, Map<String,dynamic> dataSnap, ValueChanged<bool> onValidate) onRequestValidateOnNewPayload, required void Function(T dataSnap) onNotifyNewUpdates, bool isSubsequentRequest = false, required VoidCallback onCloudError, required VoidCallback onRequestInitNewConnection}) {
    //todo - check local
    //todo - if exists populate and also check cloud
    //todo - else check cloud
    //todo - if cloud exist - populate local (unless !populateLocalOnCloudData)- read
    //todo - else - network error

    //todo use a pouch manager here
    const cloudRequestKey = 'cloudRequestKey';
    const sheetPayloadInsertKey = 'sheetPayloadInsertKey';
    const sheetPayloadBodyKey = 'sheetPayloadBodyKey';
    PouchManager().execute<void>((onSaveFunction, executeSavedFunction) {
      onSaveFunction<void Function({void Function({required String contextKey})? onFinishCloud})>(cloudRequestKey,({VoidCallback? onFinish}){
        return ({void Function({required String contextKey})? onFinishCloud}) {
          requestStreamDataFromGetRequest(
            contextKey: contextKey,
              path: path,
              requestType: ClientRequestType.allowedUser,
              isSubsequentRequest: isSubsequentRequest,
              onEvent: (requestNumber,isValidResponse,event,onFinishEvent){
                /***
                 * req 0 - ping pong
                 *     1 - initial payload
                 *     2 - subsequent update payload
                 *     3 - closing connection
                 *     > 3 - other payloads that can be manipulated at the top level
                 */
                SasaController.feedbackManagement.verbose(
                    'isValidResponse: $isValidResponse',
                    screenContext: screenContext,
                    verboseType: 'DEBUG');
                if (isValidResponse) {
                  var responseMap = event;
                  // int requestNumber = responseMap['requestNumber'];
                  SasaController.feedbackManagement.verbose(
                      'analyzing request ids | requestNumber: $requestNumber',
                      screenContext: screenContext, verboseType: 'DEBUG');

                  if (requestNumber == 1 || requestNumber == 2 ||
                      requestNumber == 4) {
                    onSaveFunction<List<dynamic>>(
                        sheetPayloadBodyKey, ({VoidCallback? onFinish}) {
                      return responseMap['payload'];
                    });
                    onSaveFunction<void>(
                        sheetPayloadInsertKey, ({VoidCallback? onFinish}) {
                      var payload = executeSavedFunction<List<dynamic>>(
                          sheetPayloadBodyKey);
                      SasaController.feedbackManagement.verbose(
                          'payload: $payload', screenContext: screenContext,
                          verboseType: 'DEBUG');
                      SasaController.utils.iterateList((index, onTriggerLoop) {
                        var singlePayload = payload[index];
                        SasaController.feedbackManagement.verbose(
                            '$index | singlePayload: $singlePayload',
                            screenContext: screenContext,
                            verboseType: 'DEBUG');
                        //
                        if (populateLocalOnCloudData) {
                          onRequestValidateOnNewPayload(
                              requestNumber, singlePayload, (isValidated) {
                            var singleDataSnap = instance.fromMap(
                                singlePayload) as T;
                            if (isValidated) {
                              requestPostLocalData<T>(
                                  databaseName: databaseName,
                                  tableName: tableName,
                                  instance: instance,
                                  sasaObjectsToAdd: [singleDataSnap],
                                  onSuccess: () {
                                    onSingleDataSnapCloud(singleDataSnap, () {
                                      if (requestNumber == 2) {
                                        onNotifyNewUpdates(singleDataSnap);
                                      }
                                      if (index + 1 == payload.length) {
                                        //redundant because onDataSnapshot is only necessary during initial ui builds
                                        //and  request data cloud is only called for ui updates
                                        onFinishEvent();
                                        if (onFinishCloud != null &&
                                            !isSubsequentRequest) {
                                          onFinishCloud(contextKey: contextKey);
                                        }
                                      }
                                      else {
                                        onTriggerLoop();
                                      }
                                    });
                                  }
                              );
                            }
                            else {
                              SasaController.feedbackManagement.verbose(
                                  'isValidated FALSE due to duplicates',
                                  screenContext: screenContext,
                                  verboseType: 'DEBUG');
                              /***
                               * for now we don't expect duplicates to intermingle with non duplicates in a payload
                               */
                              if (index + 1 == payload.length) {
                                //redundant because onDataSnapshot is only necessary during initial ui builds
                                //and  request data cloud is only called for ui updates
                                onFinishEvent();
                                if (onFinishCloud != null &&
                                    !isSubsequentRequest) {
                                  onFinishCloud(contextKey: contextKey);
                                }
                              }
                              else {
                                onTriggerLoop();
                              }
                            }
                          });
                        }
                        else {
                          //todo the below code block is pron to errors of not considering all use case permutations
                          var singleDataSnap = instance.fromMap(
                              singlePayload) as T; //todo this line is pron to bugs, oof not considering all use case permutations
                          onSingleDataSnapCloud(singleDataSnap, () {
                            if (index + 1 == payload.length) {
                              //redundant because onDataSnapshot is only necessary during initial ui builds
                              //and  request data cloud is only called for ui updates
                              onFinishEvent();
                              if (onFinishCloud != null && !isSubsequentRequest) {
                                onFinishCloud(contextKey: contextKey);
                              }
                            }
                            else {
                              onTriggerLoop();
                            }
                          });
                        }
                      });
                    });
                  }
                  if (requestNumber == 0) {
                    //this is ping pong to keep the connection alive
                  }
                  else if (requestNumber == 1) {
                    //this is for getting new updates initially
                    executeSavedFunction<void>(sheetPayloadInsertKey);
                  }
                  else if (requestNumber == 2) {
                    //this is for new updates from the listener
                    //expecting singular data
                    //data has to be vetted first
                    executeSavedFunction<void>(sheetPayloadInsertKey);
                  }
                  else if (requestNumber == 3) {
                    //this is a notice that the connection is closing,
                    //theres need to restart a new connection from the top level
                    SasaController.feedbackManagement.verbose(
                        'requesting a new connection from the top level',
                        screenContext: screenContext, verboseType: 'DEBUG');
                    onRequestInitNewConnection();
                  }
                  else if (requestNumber == 4) {
                    //this is for new updates from the listener
                    //expecting singular data
                    //data has to be vetted first
                    executeSavedFunction<void>(sheetPayloadInsertKey);
                  }
                } else {
                  onCloudError();
                  if (onFinishCloud!=null) {
                    onFinishCloud(contextKey: contextKey);
                  }
                }
              }
          );
        };
      });
      if (!isSubsequentRequest) {
        requestGetLocalData<T>(
            databaseName: databaseName,
            tableName: tableName,
            instance: instance,
            where: where,
            whereArgs: whereArgs,
            orderBy: orderBy,
            limit: limit,
            onNull: (errorOutput) {
              //check cloud here
              onNull(errorOutput); //to set the ui to empty
              executeSavedFunction<void Function({void Function({required String contextKey})? onFinishCloud})>(cloudRequestKey)(onFinishCloud: triggerConnectionClosure);

            },
            onSingleDataSnap: onSingleDataSnap,
            onDataSnapShot: (dataSnapshot) {
              onDataSnapShot(); //to set the ui with locally stored data
              //now check if there are new posts made to the cloud
              executeSavedFunction<void Function({void Function({required String contextKey})? onFinishCloud})>(cloudRequestKey)(onFinishCloud: triggerConnectionClosure);
            }
        );
      } else {
        executeSavedFunction<void Function({void Function({required String contextKey})? onFinishCloud})>(cloudRequestKey)(onFinishCloud: triggerConnectionClosure);
      }
    });
  }
  var br1 = "";
  //to eliminate repetitive onSingleDataSnap and onDataSnapshot
  void requestDeleteLocalData<T extends SasaObject>({required String databaseName, required String tableName, required T deleteInstance,required VoidCallback onSuccess}) async {
    await SasaController.sqlManagement.delete(
        databaseName: databaseName,
        tableName: tableName,
        distinguishingIDKey: deleteInstance.distinguishingIDKey,
        distinguishingIDValue: deleteInstance.distinguishingIDValue,
        onDelete: (id) {
          SasaController.feedbackManagement.verbose('Sqlite data delete: $id', screenContext: screenContext, verboseType: 'DEBUG');
          onSuccess();
        }
    );
  }
  static List<String> getColumnParameters<T extends SasaObject>({required T agrisasaObject}) {
    var map = agrisasaObject.toMap();
    List<String> columns = [];
    for (var key in map.keys) {
      columns.add(
          key//map is already encoded
      );
    }
    return columns;
  }
}
