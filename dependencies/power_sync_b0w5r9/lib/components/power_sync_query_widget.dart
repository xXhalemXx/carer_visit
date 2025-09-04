import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:ff_theme/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'power_sync_query_model.dart';
export 'power_sync_query_model.dart';

class PowerSyncQueryWidget extends StatefulWidget {
  const PowerSyncQueryWidget({
    super.key,
    required this.sql,
    this.parameters,
    bool? watch,
    required this.child,
  }) : this.watch = watch ?? true;

  /// The SQL statement to run.
  final String? sql;

  /// The values for parameters in the prepared statement.
  final dynamic parameters;

  /// Whether to kepe watching the query, or whether it should only run once.
  final bool watch;

  /// The component to build with database rows.
  final Widget Function(

      /// The rows returned from the database.
      List<dynamic> rows)? child;

  @override
  State<PowerSyncQueryWidget> createState() => _PowerSyncQueryWidgetState();
}

class _PowerSyncQueryWidgetState extends State<PowerSyncQueryWidget> {
  late PowerSyncQueryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => PowerSyncQueryModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 0.0,
          height: 0.0,
          child: custom_widgets.InternalPowerSyncQuery(
            width: 0.0,
            height: 0.0,
            sql: widget!.sql!,
            watch: widget!.watch,
            variables: widget!.parameters,
            onData: (rows) async {
              _model.rows = rows.toList().cast<dynamic>();
              safeSetState(() {});
            },
          ),
        ),
        Builder(builder: (_) {
          return widget.child != null
              ? widget.child!(
                  _model.rows,
                )
              : SizedBox.shrink();
        }),
      ],
    );
  }
}
