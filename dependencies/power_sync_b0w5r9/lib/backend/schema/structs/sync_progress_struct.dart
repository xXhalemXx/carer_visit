// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

/// Information about how far the current sync has progressed.
class SyncProgressStruct extends BaseStruct {
  SyncProgressStruct({
    /// The fraction of the sync progress as a number between 0 and 1 (inclusive).
    double? downloadedFraction,

    /// How many operations need to be downloaded in total until the current
    /// download is complete.
    int? totalOperations,

    /// How many operations have already been downloaded since the last complete
    /// download.
    int? downloadedOperations,
  })  : _downloadedFraction = downloadedFraction,
        _totalOperations = totalOperations,
        _downloadedOperations = downloadedOperations;

  // "downloadedFraction" field.
  double? _downloadedFraction;
  double get downloadedFraction => _downloadedFraction ?? 0.0;
  set downloadedFraction(double? val) => _downloadedFraction = val;

  void incrementDownloadedFraction(double amount) =>
      downloadedFraction = downloadedFraction + amount;

  bool hasDownloadedFraction() => _downloadedFraction != null;

  // "totalOperations" field.
  int? _totalOperations;
  int get totalOperations => _totalOperations ?? 0;
  set totalOperations(int? val) => _totalOperations = val;

  void incrementTotalOperations(int amount) =>
      totalOperations = totalOperations + amount;

  bool hasTotalOperations() => _totalOperations != null;

  // "downloadedOperations" field.
  int? _downloadedOperations;
  int get downloadedOperations => _downloadedOperations ?? 0;
  set downloadedOperations(int? val) => _downloadedOperations = val;

  void incrementDownloadedOperations(int amount) =>
      downloadedOperations = downloadedOperations + amount;

  bool hasDownloadedOperations() => _downloadedOperations != null;

  static SyncProgressStruct fromMap(Map<String, dynamic> data) =>
      SyncProgressStruct(
        downloadedFraction: castToType<double>(data['downloadedFraction']),
        totalOperations: castToType<int>(data['totalOperations']),
        downloadedOperations: castToType<int>(data['downloadedOperations']),
      );

  static SyncProgressStruct? maybeFromMap(dynamic data) => data is Map
      ? SyncProgressStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'downloadedFraction': _downloadedFraction,
        'totalOperations': _totalOperations,
        'downloadedOperations': _downloadedOperations,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'downloadedFraction': serializeParam(
          _downloadedFraction,
          ParamType.double,
        ),
        'totalOperations': serializeParam(
          _totalOperations,
          ParamType.int,
        ),
        'downloadedOperations': serializeParam(
          _downloadedOperations,
          ParamType.int,
        ),
      }.withoutNulls;

  static SyncProgressStruct fromSerializableMap(Map<String, dynamic> data) =>
      SyncProgressStruct(
        downloadedFraction: deserializeParam(
          data['downloadedFraction'],
          ParamType.double,
          false,
        ),
        totalOperations: deserializeParam(
          data['totalOperations'],
          ParamType.int,
          false,
        ),
        downloadedOperations: deserializeParam(
          data['downloadedOperations'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'SyncProgressStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SyncProgressStruct &&
        downloadedFraction == other.downloadedFraction &&
        totalOperations == other.totalOperations &&
        downloadedOperations == other.downloadedOperations;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([downloadedFraction, totalOperations, downloadedOperations]);
}

SyncProgressStruct createSyncProgressStruct({
  double? downloadedFraction,
  int? totalOperations,
  int? downloadedOperations,
}) =>
    SyncProgressStruct(
      downloadedFraction: downloadedFraction,
      totalOperations: totalOperations,
      downloadedOperations: downloadedOperations,
    );
