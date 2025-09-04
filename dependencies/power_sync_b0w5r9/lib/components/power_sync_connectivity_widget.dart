import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'power_sync_connectivity_model.dart';
export 'power_sync_connectivity_model.dart';

class PowerSyncConnectivityWidget extends StatefulWidget {
  const PowerSyncConnectivityWidget({super.key});

  @override
  State<PowerSyncConnectivityWidget> createState() =>
      _PowerSyncConnectivityWidgetState();
}

class _PowerSyncConnectivityWidgetState
    extends State<PowerSyncConnectivityWidget> {
  late PowerSyncConnectivityModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PowerSyncConnectivityModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (!FFAppState().syncStatus.connected)
          Icon(
            Icons.cloud_off,
            color: FlutterFlowTheme.of(context).error,
            size: 24.0,
          ),
        if (FFAppState().syncStatus.connected)
          Icon(
            Icons.cloud_done,
            color: FlutterFlowTheme.of(context).success,
            size: 24.0,
          ),
        Icon(
          Icons.arrow_upward_sharp,
          color: FFAppState().syncStatus.uploading
              ? FlutterFlowTheme.of(context).secondary
              : FlutterFlowTheme.of(context).secondaryText,
          size: 24.0,
        ),
        Icon(
          Icons.arrow_downward_sharp,
          color: FFAppState().syncStatus.downloading
              ? FlutterFlowTheme.of(context).tertiary
              : FlutterFlowTheme.of(context).secondaryText,
          size: 24.0,
        ),
      ],
    );
  }
}
