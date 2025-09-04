import 'package:flutter/material.dart';
import '/backend/schema/structs/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  SyncStatusStruct _syncStatus = SyncStatusStruct();
  SyncStatusStruct get syncStatus => _syncStatus;
  set syncStatus(SyncStatusStruct value) {
    _syncStatus = value;
  }

  void updateSyncStatusStruct(Function(SyncStatusStruct) updateFn) {
    updateFn(_syncStatus);
  }
}
