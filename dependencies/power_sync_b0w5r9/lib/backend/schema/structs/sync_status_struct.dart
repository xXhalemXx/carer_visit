// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SyncStatusStruct extends BaseStruct {
  SyncStatusStruct({
    bool? connected,
    bool? connecting,
    bool? hasSynced,
    bool? downloading,
    DateTime? lastSyncedAt,
    String? downloadError,
    String? uploadError,
    bool? uploading,

    /// If downloading, information about how far the download has progressed.
    SyncProgressStruct? downloadProgress,
  })  : _connected = connected,
        _connecting = connecting,
        _hasSynced = hasSynced,
        _downloading = downloading,
        _lastSyncedAt = lastSyncedAt,
        _downloadError = downloadError,
        _uploadError = uploadError,
        _uploading = uploading,
        _downloadProgress = downloadProgress;

  // "connected" field.
  bool? _connected;
  bool get connected => _connected ?? false;
  set connected(bool? val) => _connected = val;

  bool hasConnected() => _connected != null;

  // "connecting" field.
  bool? _connecting;
  bool get connecting => _connecting ?? false;
  set connecting(bool? val) => _connecting = val;

  bool hasConnecting() => _connecting != null;

  // "hasSynced" field.
  bool? _hasSynced;
  bool get hasSynced => _hasSynced ?? false;
  set hasSynced(bool? val) => _hasSynced = val;

  bool hasHasSynced() => _hasSynced != null;

  // "downloading" field.
  bool? _downloading;
  bool get downloading => _downloading ?? false;
  set downloading(bool? val) => _downloading = val;

  bool hasDownloading() => _downloading != null;

  // "lastSyncedAt" field.
  DateTime? _lastSyncedAt;
  DateTime? get lastSyncedAt => _lastSyncedAt;
  set lastSyncedAt(DateTime? val) => _lastSyncedAt = val;

  bool hasLastSyncedAt() => _lastSyncedAt != null;

  // "downloadError" field.
  String? _downloadError;
  String get downloadError => _downloadError ?? '';
  set downloadError(String? val) => _downloadError = val;

  bool hasDownloadError() => _downloadError != null;

  // "uploadError" field.
  String? _uploadError;
  String get uploadError => _uploadError ?? '';
  set uploadError(String? val) => _uploadError = val;

  bool hasUploadError() => _uploadError != null;

  // "uploading" field.
  bool? _uploading;
  bool get uploading => _uploading ?? false;
  set uploading(bool? val) => _uploading = val;

  bool hasUploading() => _uploading != null;

  // "downloadProgress" field.
  SyncProgressStruct? _downloadProgress;
  SyncProgressStruct get downloadProgress =>
      _downloadProgress ?? SyncProgressStruct();
  set downloadProgress(SyncProgressStruct? val) => _downloadProgress = val;

  void updateDownloadProgress(Function(SyncProgressStruct) updateFn) {
    updateFn(_downloadProgress ??= SyncProgressStruct());
  }

  bool hasDownloadProgress() => _downloadProgress != null;

  static SyncStatusStruct fromMap(Map<String, dynamic> data) =>
      SyncStatusStruct(
        connected: data['connected'] as bool?,
        connecting: data['connecting'] as bool?,
        hasSynced: data['hasSynced'] as bool?,
        downloading: data['downloading'] as bool?,
        lastSyncedAt: data['lastSyncedAt'] as DateTime?,
        downloadError: data['downloadError'] as String?,
        uploadError: data['uploadError'] as String?,
        uploading: data['uploading'] as bool?,
        downloadProgress: data['downloadProgress'] is SyncProgressStruct
            ? data['downloadProgress']
            : SyncProgressStruct.maybeFromMap(data['downloadProgress']),
      );

  static SyncStatusStruct? maybeFromMap(dynamic data) => data is Map
      ? SyncStatusStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'connected': _connected,
        'connecting': _connecting,
        'hasSynced': _hasSynced,
        'downloading': _downloading,
        'lastSyncedAt': _lastSyncedAt,
        'downloadError': _downloadError,
        'uploadError': _uploadError,
        'uploading': _uploading,
        'downloadProgress': _downloadProgress?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'connected': serializeParam(
          _connected,
          ParamType.bool,
        ),
        'connecting': serializeParam(
          _connecting,
          ParamType.bool,
        ),
        'hasSynced': serializeParam(
          _hasSynced,
          ParamType.bool,
        ),
        'downloading': serializeParam(
          _downloading,
          ParamType.bool,
        ),
        'lastSyncedAt': serializeParam(
          _lastSyncedAt,
          ParamType.DateTime,
        ),
        'downloadError': serializeParam(
          _downloadError,
          ParamType.String,
        ),
        'uploadError': serializeParam(
          _uploadError,
          ParamType.String,
        ),
        'uploading': serializeParam(
          _uploading,
          ParamType.bool,
        ),
        'downloadProgress': serializeParam(
          _downloadProgress,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static SyncStatusStruct fromSerializableMap(Map<String, dynamic> data) =>
      SyncStatusStruct(
        connected: deserializeParam(
          data['connected'],
          ParamType.bool,
          false,
        ),
        connecting: deserializeParam(
          data['connecting'],
          ParamType.bool,
          false,
        ),
        hasSynced: deserializeParam(
          data['hasSynced'],
          ParamType.bool,
          false,
        ),
        downloading: deserializeParam(
          data['downloading'],
          ParamType.bool,
          false,
        ),
        lastSyncedAt: deserializeParam(
          data['lastSyncedAt'],
          ParamType.DateTime,
          false,
        ),
        downloadError: deserializeParam(
          data['downloadError'],
          ParamType.String,
          false,
        ),
        uploadError: deserializeParam(
          data['uploadError'],
          ParamType.String,
          false,
        ),
        uploading: deserializeParam(
          data['uploading'],
          ParamType.bool,
          false,
        ),
        downloadProgress: deserializeStructParam(
          data['downloadProgress'],
          ParamType.DataStruct,
          false,
          structBuilder: SyncProgressStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'SyncStatusStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SyncStatusStruct &&
        connected == other.connected &&
        connecting == other.connecting &&
        hasSynced == other.hasSynced &&
        downloading == other.downloading &&
        lastSyncedAt == other.lastSyncedAt &&
        downloadError == other.downloadError &&
        uploadError == other.uploadError &&
        uploading == other.uploading &&
        downloadProgress == other.downloadProgress;
  }

  @override
  int get hashCode => const ListEquality().hash([
        connected,
        connecting,
        hasSynced,
        downloading,
        lastSyncedAt,
        downloadError,
        uploadError,
        uploading,
        downloadProgress
      ]);
}

SyncStatusStruct createSyncStatusStruct({
  bool? connected,
  bool? connecting,
  bool? hasSynced,
  bool? downloading,
  DateTime? lastSyncedAt,
  String? downloadError,
  String? uploadError,
  bool? uploading,
  SyncProgressStruct? downloadProgress,
}) =>
    SyncStatusStruct(
      connected: connected,
      connecting: connecting,
      hasSynced: hasSynced,
      downloading: downloading,
      lastSyncedAt: lastSyncedAt,
      downloadError: downloadError,
      uploadError: uploadError,
      uploading: uploading,
      downloadProgress: downloadProgress ?? SyncProgressStruct(),
    );
