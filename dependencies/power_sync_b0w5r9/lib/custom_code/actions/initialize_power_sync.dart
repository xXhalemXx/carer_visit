// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/foundation.dart' show kDebugMode;
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:powersync/powersync.dart' as ps;
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import 'package:powersync/sqlite_async.dart' as ps;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart' as p;

ps.PowerSyncDatabase? _db;
StreamSubscription? _statusSubscription;
Future<ps.PowerSyncDatabase>? _initializingDb;
PowerSyncCustomization powerSyncOptions = PowerSyncCustomization();

ps.PowerSyncDatabase get db =>
    _db ??
    (throw StateError(
        'Tried to access PowerSync database without calling initializePowerSync() action!'));

Future<void> initializePowerSync() async {
  await getOrInitializeDatabase();
}

Future<ps.PowerSyncDatabase> _initializePowerSyncInternal() async {
  final values = FFLibraryValues();
  final syncService = values.PowerSyncUrl;
  final schema =
      _convertJsonToSchema(convert.jsonDecode(values.PowerSyncSchema));

  final (hasOwnAssets, wasmUri) = await _wasmUri();
  final db = _db = ps.PowerSyncDatabase.withFactory(
    ps.PowerSyncOpenFactory(
      path: await _getDatabasePath(),
      sqliteOptions: ps.SqliteOptions(
        webSqliteOptions: ps.WebSqliteOptions(
          wasmUri: wasmUri,
          // If we're running in a project that doesn't have its own WASM
          // bundle, it probably won't have a worker either. Instead of trying
          // to load one, we put one from a different domain which will
          // immediately trigger a SecurityException, which makes sqlite3_web
          // fall back to the workaround avoiding workers.
          workerUri: hasOwnAssets
              ? 'db_worker.js'
              : 'https://missingworker.powersync.com/db_worker.js',
        ),
      ),
    ),
    schema: schema,
  );

  _statusSubscription?.cancel();
  _statusSubscription = db.statusStream.listen((status) {
    final state = FFAppState();
    state.update(() {
      state.syncStatus = SyncStatusStruct(
        connected: status.connected,
        connecting: status.connecting,
        lastSyncedAt: status.lastSyncedAt,
        hasSynced: status.hasSynced,
        downloading: status.downloading,
        uploading: status.uploading,
        downloadError: status.downloadError?.toString(),
        uploadError: status.uploadError?.toString(),
        downloadProgress: switch (status.downloadProgress) {
          null => null,
          final progress => SyncProgressStruct(
              downloadedFraction: progress.downloadedFraction,
              downloadedOperations: progress.downloadedOperations,
              totalOperations: progress.totalOperations,
            )
        },
      );
    });
  });

  await db.initialize();
  if (powerSyncOptions.useSupabaseConnector) {
    _manageSyncWithSupabase(syncService);
  }

  return db;
}

void _manageSyncWithSupabase(String syncService) {
  _SupabaseConnector? currentConnector;

  if (_SupabaseConnector.isLoggedIn()) {
    // If the user is already logged in, connect immediately.
    // Otherwise, connect once logged in.
    currentConnector = _SupabaseConnector(db, syncService);
    db.connect(connector: currentConnector);
  }

  supabase.Supabase.instance.client.auth.onAuthStateChange.listen((data) async {
    final event = data.event;
    if (event == supabase.AuthChangeEvent.signedIn) {
      // Connect to PowerSync when the user is signed in
      currentConnector = _SupabaseConnector(db, syncService);
      db.connect(connector: currentConnector!);
    } else if (event == supabase.AuthChangeEvent.signedOut) {
      // Implicit sign out - disconnect, but don't delete data
      currentConnector = null;
      await db.disconnect();
    } else if (event == supabase.AuthChangeEvent.tokenRefreshed) {
      // Supabase token refreshed - trigger token refresh for PowerSync.
      currentConnector?.prefetchCredentials();
    }
  });
}

const _isCompilingToWeb = bool.fromEnvironment('dart.library.js_interop');

ps.Schema _convertJsonToSchema(dynamic schema) {
  final columnTypes = {
    for (final entry in ps.ColumnType.values) entry.name: entry,
  };

  ps.Table readTable(Map<String, dynamic> tbl) {
    final name = tbl['name'] as String;
    final viewNameOverride = tbl['view_name'] as String?;
    final localOnly = tbl['local_only'] as bool;
    final insertOnly = tbl['insert_only'] as bool;
    final columns = [
      for (final col in tbl['columns'] as List)
        ps.Column(col['name'], columnTypes[col['type']]!)
    ];
    final indexes = [
      for (final idx in tbl['indexes'] as List)
        ps.Index(
          idx['name'],
          (idx['columns'] as List)
              .map(
                  (e) => ps.IndexedColumn(e['name'], ascending: e['ascending']))
              .toList(),
        ),
    ];

    if (insertOnly) {
      return ps.Table.insertOnly(name, columns, viewName: viewNameOverride);
    }

    return ps.Table(
      name,
      columns,
      indexes: indexes,
      viewName: viewNameOverride,
      localOnly: localOnly,
    );
  }

  return ps.Schema(
    [
      for (final tbl in schema['tables'] as List) readTable(tbl),
    ],
  );
}

final class _SupabaseConnector extends ps.PowerSyncBackendConnector {
  final ps.PowerSyncDatabase db;
  final String _psEndpoint;
  Future<void>? _refreshFuture;

  _SupabaseConnector(this.db, this._psEndpoint);

  /// Get a Supabase token to authenticate against the PowerSync instance.
  @override
  Future<ps.PowerSyncCredentials?> fetchCredentials() async {
    // Wait for pending session refresh if any
    await _refreshFuture;

    // Use Supabase token for PowerSync
    final session = supabase.Supabase.instance.client.auth.currentSession;
    if (session == null) {
      // Not logged in
      return null;
    }

    // Use the access token to authenticate against PowerSync
    final token = session.accessToken;

    return ps.PowerSyncCredentials(endpoint: _psEndpoint, token: token);
  }

  @override
  void invalidateCredentials() {
    // Trigger a session refresh if auth fails on PowerSync.
    // Generally, sessions should be refreshed automatically by Supabase.
    // However, in some cases it can be a while before the session refresh is
    // retried. We attempt to trigger the refresh as soon as we get an auth
    // failure on PowerSync.
    //
    // This could happen if the device was offline for a while and the session
    // expired, and nothing else attempt to use the session it in the meantime.
    //
    // Timeout the refresh call to avoid waiting for long retries,
    // and ignore any errors. Errors will surface as expired tokens.
    _refreshFuture = supabase.Supabase.instance.client.auth
        .refreshSession()
        .timeout(const Duration(seconds: 5))
        .then((response) => null, onError: (error) => null);
  }

  // Upload pending changes to Supabase.
  @override
  Future<void> uploadData(ps.PowerSyncDatabase database) async {
    // This function is called whenever there is data to upload, whether the
    // device is online or offline.
    // If this call throws an error, it is retried periodically.
    final transaction = await database.getNextCrudTransaction();
    if (transaction == null) {
      return;
    }

    final rest = supabase.Supabase.instance.client.rest;
    ps.CrudEntry? lastOp;
    try {
      // Note: If transactional consistency is important, use database functions
      // or edge functions to process the entire transaction in a single call.
      for (var op in transaction.crud) {
        lastOp = op;

        final table = rest.from(op.table);
        if (op.op == ps.UpdateType.put) {
          var data = Map<String, dynamic>.of(op.opData!);
          data['id'] = op.id;
          powerSyncOptions.transformData(op.table, data);

          await table.upsert(data);
        } else if (op.op == ps.UpdateType.patch) {
          var data = Map<String, dynamic>.of(op.opData!);
          powerSyncOptions.transformData(op.table, data);

          await table.update(data).eq('id', op.id);
        } else if (op.op == ps.UpdateType.delete) {
          await table.delete().eq('id', op.id);
        }
      }

      // All operations successful.
      await transaction.complete();
    } on supabase.PostgrestException catch (e) {
      if (e.code != null &&
          fatalResponseCodes.any((re) => re.hasMatch(e.code!))) {
        /// Instead of blocking the queue with these errors,
        /// discard the (rest of the) transaction.
        ///
        /// Note that these errors typically indicate a bug in the application.
        /// If protecting against data loss is important, save the failing records
        /// elsewhere instead of discarding, and/or notify the user.
        print('Data upload error - discarding $lastOp' + e.toString());
        await transaction.complete();
      } else {
        // Error may be retryable - e.g. network error or temporary server error.
        // Throwing an error here causes this call to be retried after a delay.
        rethrow;
      }
    }
  }

  /// Postgres Response codes that we cannot recover from by retrying.
  static final List<RegExp> fatalResponseCodes = [
    // Class 22 — Data Exception
    // Examples include data type mismatch.
    RegExp(r'^22...$'),
    // Class 23 — Integrity Constraint Violation.
    // Examples include NOT NULL, FOREIGN KEY and UNIQUE violations.
    RegExp(r'^23...$'),
    // INSUFFICIENT PRIVILEGE - typically a row-level security violation
    RegExp(r'^42501$'),
  ];

  static bool isLoggedIn() {
    return supabase.Supabase.instance.client.auth.currentSession?.accessToken !=
        null;
  }
}

/// Options that can be used to customize how the PowerSync integration for
/// FlutterFlow behaves.
final class PowerSyncCustomization {
  void Function(String table, Map<String, Object?> data) transformData;
  bool useSupabaseConnector;

  PowerSyncCustomization({
    this.transformData = _noTransformation,
    this.useSupabaseConnector = true,
  });

  static void _noTransformation(String table, Map<String, Object?> data) {}
}

Future<ps.PowerSyncDatabase> getOrInitializeDatabase() {
  if (_db case final db?) {
    return Future.value(db);
  }

  return _initializingDb ??= _initializePowerSyncInternal();
}

Future<String> _getDatabasePath() async {
  var path = 'powersync-sqlite.db';
  // getApplicationSupportDirectory is not supported on Web
  if (!_isCompilingToWeb) {
    final dir = await p.getApplicationSupportDirectory();
    path = p.join(dir.path, path);
  }
  return path;
}

const _defaultUri = 'sqlite3.wasm';
const _fallbackUri =
    'https://cdn.jsdelivr.net/npm/@powersync/dart-wasm-bundles@latest/dist/sqlite3.wasm';

Future<(bool, String)> _wasmUri() async {
  if (!kDebugMode) {
    // Force users to install their own sqlite3.wasm on release builds.
    return (true, _defaultUri);
  }

  final hasWasm = _isCompilingToWeb ? await _hasOwnSqliteWasm() : true;
  if (!hasWasm) {
    debugPrint(
      "You don't have a sqlite3.wasm in your web folder. This is expected for "
      'FlutterFlow debug builds, but please consider following the web setup '
      'guide for better web performance',
    );
    return (false, _fallbackUri);
  }

  return (true, _defaultUri);
}

Future<bool> _hasOwnSqliteWasm() async {
  // FlutterFlow's test server will serve the index.html on all paths it doesn't
  // have. This includes the wasm file. That's fine, but unfortunately it serves
  // that HTML with an application/wasm content type which breaks our check.
  // We could try making a range request and validate headers to check this, but
  // since users are really supposed to have a wasm file and we're just doing
  // this for test more, this check is easier:
  if (Uri.base.host.contains('ff-debug-service')) {
    return false;
  }

  // Check if a sqlite3.wasm exists.
  final client = http.Client();

  try {
    final response = await client.head(Uri.parse(_defaultUri));
    if (response.statusCode != 200) {
      return false;
    }

    final contentType = response.headers['content-type'];
    return contentType != null && contentType.contains('application/wasm');
  } catch (e) {
    return false;
  } finally {
    client.close();
  }
}
