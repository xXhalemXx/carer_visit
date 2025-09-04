import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'power_sync_state_updater_model.dart';
export 'power_sync_state_updater_model.dart';

class PowerSyncStateUpdaterWidget extends StatefulWidget {
  const PowerSyncStateUpdaterWidget({
    super.key,
    required this.sql,
    this.parameters,
    bool? watch,
    required this.onData,
  }) : this.watch = watch ?? true;

  /// Statement to run
  final String? sql;

  /// Values for prepared parameters in query.
  final dynamic parameters;

  /// Whether to run the query once or to keep watching it.
  final bool watch;

  /// Callback actions when rows are available
  final Future Function(

      /// Returned rows from database
      List<dynamic> rows)? onData;

  @override
  State<PowerSyncStateUpdaterWidget> createState() =>
      _PowerSyncStateUpdaterWidgetState();
}

class _PowerSyncStateUpdaterWidgetState
    extends State<PowerSyncStateUpdaterWidget> {
  late PowerSyncStateUpdaterModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PowerSyncStateUpdaterModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      child: custom_widgets.InternalPowerSyncQuery(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 1.0,
        sql: widget!.sql!,
        watch: widget!.watch,
        variables: widget!.parameters,
        onData: (rows) async {
          await widget.onData?.call(
            rows,
          );
        },
      ),
    );
  }
}
