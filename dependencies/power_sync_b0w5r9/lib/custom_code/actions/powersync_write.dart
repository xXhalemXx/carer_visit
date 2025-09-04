// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'initialize_power_sync.dart' as init;
import 'powersync_query_once.dart';

Future powersyncWrite(
  String sql,
  dynamic parameters,
) async {
  final database = await init.getOrInitializeDatabase();
  await database.execute(sql, resolveArguments(sql, parameters));
}
