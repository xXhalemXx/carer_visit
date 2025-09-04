// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'initialize_power_sync.dart' as init;
import 'package:sqlparser/sqlparser.dart' as sql;

Future<List<dynamic>> powersyncQueryOnce(
  String sql,
  dynamic parameters,
) async {
  final database = await init.getOrInitializeDatabase();
  // ResultSet implements List<Map<String, dynamic>>
  return await database.getAll(sql, resolveArguments(sql, parameters));
}

List<Object?> resolveArguments(String sql, dynamic parameters) {
  if (parameters is List) {
    return parameters;
  } else if (parameters is Map) {
    return resolveNamedArguments(sql, parameters.cast());
  } else if (parameters == null) {
    return const [];
  } else {
    return [parameters];
  }
}

/// Finds named variables in the SQL [query] and lowers them into a list
/// understood by `package:powersync`.
///
/// We support named parameters because maps are substantially easier to create
/// in FlutterFlow than lists.
List<Object?> resolveNamedArguments(
    String query, Map<String, dynamic> parameters) {
  final engine = sql.SqlEngine();
  final tokens = engine.tokenize(query);
  final byIndex = <int, dynamic>{};
  int lastVariableIndex = 0; // SQL variables start at 1.

  for (final token in tokens) {
    String variableName;
    int index;

    if (token is sql.QuestionMarkVariableToken) {
      index = token.explicitIndex ?? ++lastVariableIndex;
      lastVariableIndex = index;

      variableName = '?$index';
    } else if (token is sql.NamedVariableToken) {
      variableName = token.name;
      index = ++lastVariableIndex;
    } else {
      continue;
    }

    if (!parameters.containsKey(variableName)) {
      throw ArgumentError.value(
          parameters, 'parameters', 'Missing key $variableName');
    }
    byIndex[index] = parameters[variableName];
  }

  final asList = List<Object?>.filled(lastVariableIndex, null);
  byIndex.forEach((key, value) {
    asList[key - 1] = value;
  });

  return asList;
}
