// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';

import '../actions/initialize_power_sync.dart';
import '../actions/powersync_query_once.dart';

import 'package:powersync/sqlite3_common.dart';
import 'package:collection/collection.dart';

/// A custom widget that runs an [sql] statement (either once or multiple times
/// depending on [watch]) and reports resulting rows through [onData].
///
/// Users of the PowerSync FlutterFlow library should not use
/// [InternalPowerSyncQuery] directly! Instead, use the `PowerSyncQuery` and
/// `PowerSyncStateUpdater` components as described in [our guide](https://docs.powersync.com/integration-guides/flutterflow-+-powersync#read-data).
///
/// The purpose of this custom widget is to be able to hook into the lifecycle
/// of the surrounding page, since we can setup stream subscriptions for
/// watching queries when the page initializes and cancel them once the page
/// becomes inactive. The widget has no other purpose and renders as an empty
/// box at runtime.
class InternalPowerSyncQuery extends StatefulWidget {
  const InternalPowerSyncQuery({
    super.key,
    this.width,
    this.height,
    required this.sql,
    this.variables,
    this.watch,
    required this.onData,
  });

  final double? width;
  final double? height;
  final String sql;
  final dynamic? variables;
  final bool? watch;
  final Future Function(List<dynamic> rows) onData;

  @override
  State<InternalPowerSyncQuery> createState() => _PowerSyncQueryState();
}

class _PowerSyncQueryState extends State<InternalPowerSyncQuery> {
  static const _listEquality = ListEquality();

  StreamSubscription<ResultSet>? _subscription;
  List<Object?> _resolvedVariables = const [];

  @override
  void initState() {
    super.initState();

    _resolveVariables();
    _subscribe();
  }

  @override
  void didUpdateWidget(covariant InternalPowerSyncQuery oldWidget) {
    super.didUpdateWidget(oldWidget);

    final oldVariables = _resolvedVariables;
    _resolveVariables();
    if (oldWidget.sql != widget.sql ||
        !_listEquality.equals(oldVariables, _resolvedVariables)) {
      _subscribe();
    }
  }

  void _resolveVariables() {
    _resolvedVariables = resolveArguments(widget.sql, widget.variables);
  }

  void _subscribe() {
    _unsubscribe();

    final stream = switch (widget.watch) {
      false => Stream.fromFuture(getOrInitializeDatabase()
          .then((db) => db.getAll(widget.sql, _resolvedVariables))),
      _ => Stream.fromFuture(getOrInitializeDatabase()).asyncExpand(
          (db) => db.watch(widget.sql, parameters: _resolvedVariables)),
    };
    _subscription = stream.listen(widget.onData);
  }

  void _unsubscribe() {
    _subscription?.cancel();
    _subscription = null;
  }

  @override
  void dispose() {
    _unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This widget is not supposed to be visible. Instead, it's added to a page
    // so that we can set up the stream subscrption when the widget is created
    // and clean it up once it's disposed.
    // The `PowerSyncStateUpdater` and `PowerSyncQuery` components of the
    // PowerSync FlutterFlow library wrap this widget by reacting to the
    // [onData] callback.
    return const SizedBox.shrink();
  }
}
