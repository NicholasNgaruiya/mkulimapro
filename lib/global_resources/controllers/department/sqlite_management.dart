// ignore_for_file: curly_braces_in_flow_control_structures, prefer_conditional_assignment

import 'package:flutter/material.dart';
import 'package:mkulimapro/global_resources/controllers/department/security.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../sasa_controller.dart';
//https://suragch.medium.com/simple-sqflite-database-example-in-flutter-e56a5aaa3f91
class SqliteController {
  String screenContext = 'SqliteController';
  final int version = 2;
  Database? db;
  requestDBInstantiation(String databaseName, {required ValueChanged<Database> onDatabaseInstance}) async {
    SasaController.feedbackManagement.verbose('requestDBInstantiation', screenContext: screenContext, verboseType: 'DEBUG');
    if (db==null) {
      db = await openDatabase(
          join(await getDatabasesPath(), '$databaseName.db'), version: version);
      onDatabaseInstance(db!);
    }
    else {
      onDatabaseInstance(db!);
    }
  }
  void resetSqlDb() {
    db = null;
  }
  Future<void> createTableIfNotExists({required String databaseName, required String tableName, required List<String> columnParameters}) async {
    requestDBInstantiation(
        databaseName,
      onDatabaseInstance: (database) async {
        SasaController.feedbackManagement.verbose('CREATE TABLE IF NOT EXISTS $tableName(${getColumnSqlString(columnParameters:columnParameters)})', screenContext: screenContext, verboseType: 'DEBUG');
        await database.execute('CREATE TABLE IF NOT EXISTS $tableName(${getColumnSqlString(columnParameters:columnParameters)})');
        SasaController.feedbackManagement.verbose('Table created with the following columns: ${getColumnSqlString(columnParameters:columnParameters)}', screenContext: screenContext, verboseType: 'DEBUG');
      }
    );
  }
  Future<void> deleteTableIfExists({required String databaseName,required String tableName}) async {
    requestDBInstantiation(
        databaseName,
      onDatabaseInstance: (database) async {
        await database.execute(
        'DROP TABLE IF EXISTS $tableName');
        SasaController.feedbackManagement.verbose('${tableName.decode()}|$tableName Table dropped successfully', screenContext: screenContext, verboseType: 'DEBUG');
      }
    );
  }
  Future<void> deleteSqlDatabase({required String databaseName}) async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, '$databaseName.db');
    await deleteDatabase(path);
    SasaController.feedbackManagement.verbose('db deleted successfully', screenContext: screenContext, verboseType: 'DEBUG');
  }
  //C-R-U-DE
  Future<void> insert({required String databaseName, required String tableName, required Map<String,dynamic> map,required ValueChanged<int> onAdd}) async {
    requestDBInstantiation(
        databaseName,
      onDatabaseInstance: (database) async{
          try {
            int id = await database.insert(
              tableName,
              map,
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
            onAdd(id);
            SasaController.feedbackManagement.verbose('inserted map: $map', screenContext: screenContext, verboseType: 'DEBUG');
          }
          catch(e,stackTrace) {
            SasaController.feedbackManagement.verbose('inserted error: $e\n$stackTrace', screenContext: screenContext, verboseType: 'DEBUG');
          }
      }
    );
  }
  Future<void> getData({required String databaseName,required String tableName,required ValueChanged<List<Map<String, dynamic>>> onDataSnapShot, required VoidCallback onNull, String? where, List<dynamic>? whereArgs, List<String>? columns,String? orderBy,int? limit}) async {
    requestDBInstantiation(
        databaseName,
      onDatabaseInstance: (database) async {
        try {
          var dataSnapShot = await database.query(
              tableName,
            columns: columns,
            where: where,
            whereArgs: whereArgs,
            orderBy: orderBy,
            limit: limit
          );
          onDataSnapShot(dataSnapShot);
        }
        catch(e, stackTrace) {
          SasaController.feedbackManagement.verbose('getData error: $e\n$stackTrace', screenContext: screenContext, verboseType: 'DEBUG');
          onNull();
        }
      }
    );

  }
  Future<void> getSpecificData({required String databaseName,required String tableName, required List<String> columnsToSelect,required String distinguishingIDKey, required String distinguishingIDValue,required ValueChanged<List<Map<String, dynamic>>> onDataSnapShot, required VoidCallback onNull}) async {
    requestDBInstantiation(
        databaseName,
        onDatabaseInstance: (database) async {
          try {
            SasaController.feedbackManagement.verbose('SELECT * FROM $tableName WHERE $distinguishingIDKey=$distinguishingIDValue', screenContext: screenContext, verboseType: 'DEBUG');
            var dataSnapShot = await database.rawQuery('SELECT * FROM $tableName WHERE $distinguishingIDKey=?', [distinguishingIDValue]);
            onDataSnapShot(dataSnapShot);
          }
          catch(e) {
            SasaController.feedbackManagement.verbose('getSpecificData error', screenContext: screenContext, verboseType: 'DEBUG');
            onNull();
          }
        }
    );
  }
  Future<void> updateSqlData({required String databaseName, required String tableName, required Map<String,dynamic> preUpdateMap, required Map<String,dynamic> updateMap, required String distinguishingIDKey, required String distinguishingIDValue,required VoidCallback onSuccess, required bool createNewEntryOnNull,required VoidCallback onNull}) async {
    requestDBInstantiation(
        databaseName,
        onDatabaseInstance: (database) async {
          try {
            var whereStatement = getWhereString(keys: preUpdateMap.keys.toList());
            var whereArgs = preUpdateMap.values.toList();
            SasaController.feedbackManagement.verbose('whereStatement: $whereStatement', screenContext: screenContext, verboseType: 'DEBUG');
            SasaController.feedbackManagement.verbose('whereArgs: $whereArgs', screenContext: screenContext, verboseType: 'DEBUG');

            int id = await database.update(
              tableName,
              updateMap,
              // Ensure that the Dog has a matching id.
              where: whereStatement,
              // Pass the Dog's id as a whereArg to prevent SQL injection.
              whereArgs: whereArgs,
            );
            //data exist update
            //data not exist create new entry
            SasaController.feedbackManagement.verbose('update id: $id', screenContext: screenContext, verboseType: 'DEBUG');
            if (id==0&&!createNewEntryOnNull) onNull();
            else if (id==0&&createNewEntryOnNull) {
              //create new data entry
              await insert(databaseName: databaseName, tableName: tableName, map: updateMap, onAdd: (id){
                SasaController.feedbackManagement.verbose('new entry created upon update fail id: $id', screenContext: screenContext, verboseType: 'DEBUG');
                onSuccess();
              });
            }
            else if (id>0) onSuccess();
          }
          catch(e, stackTrace) {
            //no table... create table and new entry
            if (createNewEntryOnNull){
              SasaController.feedbackManagement.verbose('update error but creating new entry for: $updateMap\n$stackTrace', screenContext: screenContext, verboseType: 'DEBUG');
              List<String> columnParameters = [];
              updateMap.forEach((key, value) {
                columnParameters.add(key);
              });
              await createTableIfNotExists(
                  databaseName: databaseName,
                  tableName: tableName,
                  columnParameters: columnParameters
              );
              await insert(databaseName: databaseName, tableName: tableName, map: updateMap, onAdd: (id){
                SasaController.feedbackManagement.verbose('new entry created upon update fail id: $id', screenContext: screenContext, verboseType: 'DEBUG');
                onSuccess();
              });
            }
            else
            SasaController.feedbackManagement.verbose('update error $e, $stackTrace', screenContext: screenContext, verboseType: 'DEBUG');
          }
        }
    );
  }
  String getWhereString({required List<String> keys}) {
    String whereStatement = '';
    for (int i=0;i<keys.length;i++) {
      var key = keys[i];
      whereStatement += '$key = ? ';
      if (i+1<keys.length) {
        whereStatement +='AND ';
      }
    }
    return whereStatement;
  }
  Future<void> delete({required String databaseName, required String tableName, required String distinguishingIDKey, required String distinguishingIDValue,required ValueChanged<int> onDelete}) async {
    requestDBInstantiation(
        databaseName,
        onDatabaseInstance: (database) async {
          try {
            onDelete(await database.delete(tableName, where: '$distinguishingIDKey = ?', whereArgs: [distinguishingIDValue]));
            SasaController.feedbackManagement.verbose('data deleted successfully', screenContext: screenContext, verboseType: 'DEBUG');
          }
          catch(e) {}
        }
    );
    return ;
  }

  String getColumnSqlString({required List<String> columnParameters}) {
    String command = '${'sqlId'.encode()} INTEGER PRIMARY KEY,';
    int count = 0;
    for (var cmd in columnParameters) {
      command += ' $cmd TEXT';
      if (count+1<columnParameters.length) command +=',';
      count++;
    }
    return command;
  }

}